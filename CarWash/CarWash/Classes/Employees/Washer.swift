import Foundation

public class Washer: Employee {
    
    // MARK: -
    // MARK: Public variables
    
    public weak var delegate: ActionDelegate?
    public var serviceCost: Double = 20.0
    
    // MARK: -
    // MARK: Initializations
    
    public override init(name: String, gender: Gender, salary: Salary = .value(0.15),
                         bankAccount: Double = 0.0, money: Double = 0) {
        super.init(name: name, gender: gender, salary: salary, bankAccount: bankAccount, money: money)
        position = "washer"
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func action(car: Car!) {
        washing(client: car)
    }
    
    public func washing(client: Car) {
        if isPermissible(client: client) {
            moneyFromClient(client: client)
            message = "My name is \(self.name), I am a \(self.position), " +
            "I have \(self.bankAccount) on my bank account"
            client.cleanness = true
        } else {
            isSuccess = false
            message = "I'm sorry, you don't have enough money, sir"
        }
        self.delegate?.report(object: self)
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func isPermissible(client: Car) -> Bool {
        return client.money >= serviceCost && !client.cleanness
    }
    
    private func moneyFromClient(client: Car) {
        self.money += client.pay(payment: serviceCost)
    }
}
