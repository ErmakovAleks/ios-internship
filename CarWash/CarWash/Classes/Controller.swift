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
    var freeWashers: [Washer]
    var cars: [Car] = []
    let queue = DispatchQueue(label: "")
    var time: DispatchTime
    
    var letShowWasherMessage: Bool
    var letShowAccountantMessage: Bool
    
    // MARK: -
    // MARK: Initializations
    
    init(view: FeedbackView, complex: CarWashComplex) {
        self.view = view
        self.complex = complex
        self.adminBuilding = complex.adminBuilding
        self.washingBuilding = complex.washingBuilding
        self.director = complex.adminBuilding.director
        self.time = DispatchTime.now()
        self.letShowWasherMessage = true
        self.letShowAccountantMessage = true
        
        self.accountants = complex.adminBuilding.rooms
            .flatMap { $0.employees.compactMap { $0 as? Accountant } }
        
        self.washers = complex.washingBuilding.rooms
            .flatMap { $0.employees.compactMap { $0 as? Washer } }
        
        self.freeWashers = self.washers.filter { $0.isBusy }
        
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
        
        var cars = complex.washingBuilding.rooms.flatMap { $0.cars }
        
        complex.washingBuilding.rooms.forEach { room in
            room.cars.removeAll()
        }
        
        self.queue.asyncAfter(deadline: time) {
            self.freeWashers.forEach { washer in
                if !cars.isEmpty { washer.action(car: cars.removeFirst())
                    self.freeWashers.append(self.freeWashers.removeFirst())
                }
            }
        }
    }
    
    public func report(object: MoneyContainable) {
        if object is Washer {
            self.queue.asyncAfter(deadline: self.time + 1) {
                if self.letShowWasherMessage {
                    self.view.show(message: object.message)
                    self.letShowWasherMessage = false
                }
                if object.isBusy {
                    self.queue.asyncAfter(deadline: self.time + 2) {
                        self.accountants.forEach { accountant in
                            accountant.action(object: object)
                            self.accountants.append(self.accountants.removeFirst())
                        }
                    }
                } else {
                    self.letShowWasherMessage = true
                    object.isBusy = true
                }
            }
        } else if object is Accountant {
            self.queue.asyncAfter(deadline: self.time + 3) {
                if self.letShowAccountantMessage || DispatchTime.now() > self.time + 5 {
                    self.view.show(message: object.message)
                    self.letShowAccountantMessage = false
                }
                self.director?.action(object: object)
            }
        } else if object is Director {
            self.view.show(message: object.message)
            self.letShowWasherMessage = true
            self.letShowAccountantMessage = true
            self.time = DispatchTime.now()
        }
    }
}

