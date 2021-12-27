import Foundation

public class Controller {
    
    // MARK: -
    // MARK: Public variables
    
    let view: FeedbackView
    let complex: CarWashComplex
    let adminBuilding: AdminBuilding
    let washingBuilding: WashingBuilding
    var director: Director?
    var accountant: Accountant?
    var washer: Washer?
    
    var accountants: [Accountant]
    var washers: [Washer]
    var cars: ThreadSafeArray<Car> = ThreadSafeArray()
    let queue = DispatchQueue(label: "com.car-wash.controller-queue", attributes: .concurrent)
    let lock = NSRecursiveLock()
    
    // MARK: -
    // MARK: Initializations
    
    init(view: FeedbackView, complex: CarWashComplex) {
        self.view = view
        self.complex = complex
        self.adminBuilding = complex.adminBuilding
        self.washingBuilding = complex.washingBuilding
        self.director = complex.adminBuilding.director
        
        self.accountants = complex.adminBuilding.rooms
            .flatMap { $0.employees }
            .compactMap { $0 as? Accountant }
        
        self.washers = complex.washingBuilding.rooms
            .flatMap { $0.employees }
            .compactMap { $0 as? Washer }
        
        complex.washingBuilding.rooms.forEach { room in
            while !room.cars.isEmpty {
                if let car = room.cars.extract() {
                    self.cars.append(car)
                }
            }
        }
        
        director?.didFinishWork = { [weak self] worker in
            self?.report(object: worker)
        }
        
        accountants.forEach { worker in
            worker.didFinishWork = { [weak self] worker in
                self?.report(object: worker)
            }
        }
        
        washers.forEach { worker in
            worker.didFinishWork = { [weak self] worker in
                self?.report(object: worker)
            }
        }
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func checkQueue() {
        
        self.complex.washingBuilding.rooms.forEach { room in
            while !room.cars.isEmpty {
                if let car = room.cars.extract() {
                    self.cars.append(car)
                }
            }
        }
        
        queue.async {
            let freeWashers: Atomic<[Washer]> = Atomic([])
            freeWashers.modify {
                $0 = self.washers.filter { !($0.isBusy.wrappedValue) }
                $0.forEach { washer in
                    if !self.cars.isEmpty {
                        washer.isBusy.wrappedValue = true
                        if let car = self.cars.removeFirst() {
                            washer.action(car: car)
                        }
                    }
                }
            }
        }
    }
    
    public func report(object: MoneyContainable) {
        queue.async {
            if object is Washer {
                self.view.show(message: object.message)
                if object.isEarned.wrappedValue {
                    let freeAccountants: Atomic<[Accountant]> = Atomic([])
                    freeAccountants.modify {
                        $0 = self.accountants.filter { !($0.isBusy.wrappedValue) }
                        if !$0.isEmpty {
                            self.accountant = $0.removeFirst()
                            self.accountant?.isBusy.wrappedValue = true
                            self.accountant?.action(object: object)
                            object.isBusy.wrappedValue = false
                        }
                    }
                }
                object.isBusy.wrappedValue = false
            } else if object is Accountant {
                self.view.show(message: object.message)
                if object.isEarned.wrappedValue {
                    self.director?.action(object: object)
                }
                object.isBusy.wrappedValue = false
            } else if object is Director {
                self.view.show(message: object.message)
            }
        }
    }
}

