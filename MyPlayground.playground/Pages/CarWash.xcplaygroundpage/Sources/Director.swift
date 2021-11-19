import Foundation

public class Director: Employee, TransferDelegate {
    
    public override init(name: String,
                  gender: Gender,
                  age: Int,
                  salary: Salary = .none,
                  bankAccount: Double = 0.0) {
        
        super.init(name: name,
                   gender: gender,
                   age: age,
                   salary: salary,
                   bankAccount: bankAccount)
    }
    
    public func requestEarnings(sum: Double) {
        bankAccount += sum
    }
}
