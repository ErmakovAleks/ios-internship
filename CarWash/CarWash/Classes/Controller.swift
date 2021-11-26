import Foundation

public class Controller: ActionDelegate {
    let view: FeedbackView
    let director: Director
    let accountant: Accountant
    let washer: Washer
    
    init(view: FeedbackView, director: Director, accountant: Accountant, washer: Washer) {
        self.view = view
        self.director = director
        self.accountant = accountant
        self.washer = washer
    }
    
    public func checkQueue<T: CarContainable>(object: T) {
        if !object.cars.isEmpty && washer.isSuccess {
            washer.action(car: object.cars.extract()!)
        } else {
            print("There are no cars in the queue, sir!")
        }
    }
    
    public func report(object: MoneyContainable) {
        if object.position == "washer" {
            view.show(message: washer.message)
            if object.isSuccess {
                accountant.action(object: washer)
            } else {
                object.isSuccess = true
            }
        } else if object.position == "accountant" {
            view.show(message: accountant.message)
            director.action(object: accountant)
        } else if object.position == "director" {
            view.show(message: director.message)
        }
    }
}
