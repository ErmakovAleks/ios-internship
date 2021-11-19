import Foundation

/*public enum Gender {
    case male
    case female
}

public enum Salary {
    case value(Double)
    case none
}*/

public class Employee {
    public var name: String
    public var gender: Gender
    public var age: Int
    public var salary: Salary
    internal var bankAccount: Double
    
    public init(name: String,
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
