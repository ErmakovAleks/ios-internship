import Foundation

public class Washer: Employee {
    var productivity: Int
    
    public init(name: String,
                  gender: Gender,
                  age: Int,
                  salary: Salary = .value(2000.0),
                  bankAccount: Double = 0.0,
                  productivity: Int = 1) {
        
        self.productivity = productivity
        
        super.init(name: name,
                   gender: gender,
                   age: age,
                   salary: salary,
                   bankAccount: bankAccount)
    }
}
