import Foundation

public class Controller {
    
    // MARK: -
    // MARK: Public variables
    
    let view: FeedbackView
    let adminBuilding: AdminBuilding
    let washingBuilding: WashingBuilding
    var director: Director?
    var accountant: Accountant?
    var washer: Washer?
    
    // MARK: -
    // MARK: Initializations
    
    init(view: FeedbackView, complex: CarWashComplex) {
        self.view = view
        self.adminBuilding = complex.adminBuilding
        self.washingBuilding = complex.washingBuilding
        self.director = complex.adminBuilding.director
        self.accountant = complex.adminBuilding.rooms[0].employees.extract() as? Accountant
        self.washer = complex.washingBuilding.rooms[0].employees.extract() as? Washer
        
        director?.didFinishWork = { [weak self] worker in
            self?.report(object: worker)
        }
        
        accountant?.didFinishWork = { [weak self] worker in
            self?.report(object: worker)
        }
        washer?.didFinishWork = { [weak self] worker in
            self?.report(object: worker)
        }
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func checkQueue() {
        if !(complex.washingBuilding.rooms.isEmpty) &&
        !(complex.washingBuilding.rooms[0].cars.isEmpty) {
            washer!.action(car: complex.washingBuilding.rooms[0].cars.extract() as! Car)
        } else {
            print("There are no cars in the queue, sir!")
        }
    }
    
    public func report(object: MoneyContainable) {
        if object is Washer {
            view.show(message: washer!.message)
            if object.isSuccess {
                accountant?.action(object: washer!)
            } else {
                object.isSuccess = true
            }
        } else if object is Accountant {
            view.show(message: accountant!.message)
            director?.action(object: accountant!)
        } else if object is Director {
            director.map {
                view.show(message: $0.message)
            }
        }
    }
}
