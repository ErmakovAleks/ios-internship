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
    var freeWashers: [Washer] = []
    var cars: [Car] = []
    let queue = DispatchQueue(label: "", attributes: .concurrent)
    
    // MARK: -
    // MARK: Initializations
    
    init(view: FeedbackView, complex: CarWashComplex) {
        self.view = view
        self.complex = complex
        self.adminBuilding = complex.adminBuilding
        self.washingBuilding = complex.washingBuilding
        self.director = complex.adminBuilding.director
        
        /// ЗАМЕНИТЬ ВЛОЖЕННЫЕ CompactMap ///
        
        self.accountants = complex.adminBuilding.rooms
            .flatMap { $0.employees.compactMap { $0 as? Accountant } }
        
        self.washers = complex.washingBuilding.rooms
            .flatMap { $0.employees.compactMap { $0 as? Washer } }
        
        self.freeWashers = self.washers.filter { !($0.isBusy) }
        
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
        
        self.freeWashers.forEach { washer in
            if !cars.isEmpty { washer.action(car: cars.removeFirst())
                self.freeWashers.append(self.freeWashers.removeFirst())
            }
        }
    }
    
    public func report(object: MoneyContainable) {
        if object is Washer {
            self.view.show(message: object.message)
            if !object.isBusy {
                self.accountants.forEach { accountant in
                    accountant.action(object: object)
                    self.accountants.append(self.accountants.removeFirst())
                }
            } else {
                object.isBusy = true
            }
        } else if object is Accountant {
            self.view.show(message: object.message)
            self.director?.action(object: object)
        } else if object is Director {
            self.view.show(message: object.message)
        }
    }
}

