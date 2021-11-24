import Foundation

public enum Gender {
    case male
    case female
}

public enum Salary {
    case value(Double)
    case none
}

public class Employee: ActionDelegate, MoneyContainable {
    
    // MARK: -
    // MARK: Public variables
    
    public var money: Double = 0
    public var name: String
    public var gender: Gender
    public var age: Int
    public var salary: Salary
    public var bankAccount: Double = 0
    
    // MARK: -
    // MARK: Initializations
    
    public init(name: String, gender: Gender, age: Int, salary: Salary = .value(0.2), bankAccount: Double = 0.0, money: Double = 0) {
        self.name = name
        self.gender = gender
        self.age = age
        self.salary = salary
        self.bankAccount = bankAccount
        self.money = money
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func requestEarnings(object: MoneyContainable) {
        fatalError("There is no function implementation in this class")
    }
    
    public func salaryCoefficient() -> Double {
        switch salary {
        case .none:
            return 1.0
        case let .value(doubleValue):
            return doubleValue
        }
    }
    
    public func balanceInfo() {
        print("Hello, my name is \(self.name) and I have \(bankAccount) dollars on my bank account!")
    }
}
