import Foundation

public class Controller: ActionDelegate {
    
    // MARK: -
    // MARK: Public variables
    
    let view: FeedbackView
    let director: Director
    let accountant: Accountant
    let washer: Washer
    
    // MARK: -
    // MARK: Initializations
    
    init(view: FeedbackView, director: Director, accountant: Accountant, washer: Washer) {
        self.view = view
        self.director = director
        self.accountant = accountant
        self.washer = washer
        
        director.delegate = self
        accountant.delegate = self
        washer.delegate = self
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
            director.action(object: accountant)
        } else if object is Director {
            view.show(message: director.message)
        }
    }
}
