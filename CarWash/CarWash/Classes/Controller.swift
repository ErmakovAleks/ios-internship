import Foundation

extension NSLocking {
    func `do`( _ action: () -> ()) {
        self.lock()
        defer { self.unlock() }
        
        action()
    }
}

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
    let queue = DispatchQueue(label: "com.controllerQueue", attributes: .concurrent)
    let lock = NSLock()
    
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
            let freeWashers = self.washers.filter { !($0.isBusy) }
            freeWashers.forEach { washer in
                if !self.cars.isEmpty {
                    washer.isBusy = true
                    if let car = self.cars.removeFirst() {
                        washer.action(car: car)
                    }
                }
            }
        }
    }
    
    public func report(object: MoneyContainable) {
        queue.async {
            if object is Washer {
                self.view.show(message: object.message)
                if object.isEarned && !self.accountants.isEmpty {
                    var freeAccountants = self.accountants.filter { !($0.isBusy) }
                    self.accountant = freeAccountants.removeFirst()
                    self.accountant?.isBusy = true
                    self.accountant?.action(object: object)
                }
                object.isBusy = false
            } else if object is Accountant {
                self.view.show(message: object.message)
                if object.isEarned {
                    self.director?.action(object: object)
                }
                object.isBusy = false
            } else if object is Director {
                self.view.show(message: object.message)
            }
        }
    }
}

