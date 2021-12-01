import Foundation

public class Controller {
    
    // MARK: -
    // MARK: Public variables
    
    let view: FeedbackView
    let adminBuilding: Building
    let washingBuilding: Building
    var director: Director
    var accountant: Accountant
    var washer: Washer
    
    // MARK: -
    // MARK: Initializations
    
    init(view: FeedbackView, complex: CarWashComplex) {
        self.view = view
        //self.director = director
        //self.accountant = accountant
        //self.washer = washer
        self.director = complex.adminBuilding.director
        
        director?.didFinishWork = { [weak self] worker in
            self?.report(object: worker)
        }
        
        accountant.didFinishWork = { [weak self] worker in
            self?.report(object: worker)
        }
        washer.didFinishWork = { [weak self] worker in
            self?.report(object: worker)
        }
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func checkQueue<T: CarContainable>(object: T) {
        if !object.cars.isEmpty && washer.isSuccess {
            washer.action(car: object.cars.extract()!)
        } else {
            print("There are no cars in the queue, sir!")
        }
    }
    
    public func report(object: MoneyContainable) {
        if object is Washer {
            view.show(message: washer.message)
            if object.isSuccess {
                accountant.action(object: washer)
            } else {
                object.isSuccess = true
            }
        } else if object is Accountant {
            view.show(message: accountant.message)
            director!.action(object: accountant)
        } else if object is Director {
            view.show(message: director.message ?? "")
        }
    }
}
