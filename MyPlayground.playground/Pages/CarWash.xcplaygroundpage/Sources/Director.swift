import Foundation

public class Director: Employee {
    public var profit = Double()
    
    init(name: String,
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
}
