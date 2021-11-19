import Foundation

public class Accountant: Employee, TransferDelegate {
    
    public var directorDelegate: TransferDelegate?
    
    public var washerDelegate: TransferDelegate?
    
    public override init(name: String,
                  gender: Gender,
                  age: Int,
                  salary: Salary = .value(2200.0),
                  bankAccount: Double = 0.0) {
        
        super.init(name: name,
                   gender: gender,
                   age: age,
                   salary: salary,
                   bankAccount: bankAccount)
    }
    
    public func requestEarnings(sum: Double) {
        calculateProfit(sum: sum)
    }
    
    private func calculateProfit(sum: Double) {
        self.bankAccount += sum * Double(self.salary)!
        self.washerDelegate?.requestEarnings(sum: sum * Double(washerDelegate.salary))
        self.directorDelegate?.requestEarnings(sum: sum - sum * (Double(self.salary) + Double(directorDelegate.salary)))
    }
}
