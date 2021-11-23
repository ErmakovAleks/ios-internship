import Foundation

public class Accountant: Employee {
    
    // MARK: -
    // MARK: Public variables
    
    public var delegate: ActionDelegate?
    
    // MARK: Initializations
    
    public override init(name: String, gender: Gender, age: Int, salary: Salary = .value(0.2), bankAccount: Double = 0.0, money: Int = 0) {
        super.init(name: name, gender: gender, age: age, salary: salary, bankAccount: bankAccount, money: money)
    }
    
    public override func requestEarnings(object: MoneyContainable) {
        object.bankAccount += Double(object.money) * object.salaryCoefficient()
        self.bankAccount += Double(object.money) * self.salaryCoefficient()
        self.money = Int(Double(object.money) - Double(object.money) * (self.salaryCoefficient() + object.salaryCoefficient()))
        object.money = 0
        self.delegate?.requestEarnings(object: self)
    }
}
