import Foundation

public class Accountant: Employee {
    
    // MARK: -
    // MARK: Public variables
    
    public var delegate: ActionDelegate?
    
    // MARK
    // MARK: Initializations
    
    public override init(name: String, gender: Gender, age: Int, salary: Salary = .value(0.2), bankAccount: Double = 0.0, money: Double = 0) {
        super.init(name: name, gender: gender, age: age, salary: salary, bankAccount: bankAccount, money: money)
    }
    
    // MARK: -
    // MARK: Public functions
    
    public override func requestEarnings(object: MoneyContainable) {
        distributeEarnings(object: object)
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func distributeEarnings(object: MoneyContainable) {
        object.bankAccount += object.money * object.salaryCoefficient()
        self.bankAccount += object.money * self.salaryCoefficient()
        self.money = object.money - object.money * (self.salaryCoefficient() + object.salaryCoefficient())
        object.money = 0
        self.delegate?.requestEarnings(object: self)
    }
}
