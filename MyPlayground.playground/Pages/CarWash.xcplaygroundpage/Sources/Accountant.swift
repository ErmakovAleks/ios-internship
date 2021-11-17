import Foundation

public class Accountant: Employee {
    public var earnings = Double()
    
    init(name: String,
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
}
