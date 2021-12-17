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
    var cars: [Car] = []
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
        
        self.cars = complex.washingBuilding.rooms.flatMap { $0.cars }
        
        complex.washingBuilding.rooms.forEach { room in
            room.cars.removeAll()
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
        
        safetyActions {
            queue.async {
                self.cars += self.complex.washingBuilding.rooms.flatMap { $0.cars }
                
                self.complex.washingBuilding.rooms.forEach { room in
                    room.cars.removeAll()
                }
            }
        }
        
        safetyActions {
            queue.async {
                let freeWashers = self.washers.filter { !($0.isBusy) }
                freeWashers.forEach { washer in
                    if !self.cars.isEmpty {
                        washer.isBusy = true
                        washer.action(car: self.cars.removeFirst())
                    }
                }
            }
        }
    }
    
    public func report(object: MoneyContainable) {
        safetyActions {
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
    
    private func safetyActions(closure: () -> ()) {
        lock.lock()
        closure()
        lock.unlock()
    }
}

