import Foundation

public class Director: Employee {
    
    // MARK: -
    // MARK: Public variables
    
    public weak var delegate: ActionDelegate?
    
    // MARK: -
    // MARK: Initializations
    
    public override init(name: String, gender: Gender, salary: Salary = .none,
                         bankAccount: Double = 0.0, money: Double = 0) {
        super.init(name: name, gender: gender, salary: salary, bankAccount: bankAccount, money: money)
        position = "director"
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func action(object: MoneyContainable) {
        takeProfit(object: object)
        message = "My name is \(self.name), I am a \(self.position), " +
        "I have \(self.bankAccount) on my bank account"
        self.delegate?.report(object: self)
    }
    
    public func takeProfit(object: MoneyContainable) {
        self.bankAccount += Double(object.money)
        object.money = 0
    }
}
