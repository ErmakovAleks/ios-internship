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
                $0 = self.washers.filter { !($0.isBusy.value) }
                $0.forEach { washer in
                    if !self.cars.isEmpty {
                        washer.isBusy.value = true
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
                if object.earnings.value > 0 {
                    let freeAccountants: Atomic<[Accountant]> = Atomic([])
                    freeAccountants.modify {
                        $0 = self.accountants.filter { !($0.isBusy.value) }
                        if !$0.isEmpty {
                            $0.forEach { accountant in
                                accountant.isBusy.value = true
                                accountant.action(object: object)
                                object.isBusy.value = false
                            }
                        }
                    }
                }
                object.isBusy.value = false
            } else if object is Accountant {
                self.view.show(message: object.message)
                if object.earnings.value > 0 {
                    self.director?.action(object: object)
                }
                object.isBusy.value = false
            } else if object is Director {
                print("aaa")
                self.view.show(message: object.message)
            }
        }
    }
}

