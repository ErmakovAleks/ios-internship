import Foundation

enum Gender {
    case male
    case female
}

enum Salary {
    case value(Double)
    case none
}

public class Employee {
    var name: String
    var gender: Gender
    var age: Int
    var salary: Salary
    var bankAccount: Double
    
    init(name: String,
         gender: Gender,
         age: Int,
         salary: Salary = .value(2000.0),
         bankAccount: Double = 0.0) {
        
        self.name = name
        self.gender = gender
        self.age = age
        self.salary = salary
        self.bankAccount = bankAccount
    }
}
