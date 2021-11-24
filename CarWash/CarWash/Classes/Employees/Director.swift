import Foundation

public class Director: Employee {
    
    // MARK: -
    // MARK: Initializations
    
    public override init(name: String, gender: Gender, age: Int, salary: Salary = .none, bankAccount: Double = 0.0, money: Double = 0) {
        super.init(name: name, gender: gender, age: age, salary: salary, bankAccount: bankAccount, money: money)
    }
    
    // MARK: -
    // MARK: Public functions
    
    public override func requestEarnings(object: MoneyContainable) {
        self.bankAccount += Double(object.money)
        object.money = 0
    }
}
