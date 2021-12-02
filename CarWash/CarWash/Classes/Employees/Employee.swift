import Foundation

public enum Gender {
    case male
    case female
}

public enum Salary {
    case value(Double)
    case none
}

public class Employee: MoneyContainable {
    
    // MARK: -
    // MARK: Public variables
    
    public var money: Double = 0
    public var name: String
    public var gender: Gender
    public var salary: Salary
    public var bankAccount: Double = 0
    public var position = String()
    public var isSuccess = true
    public var message = String()
    
    // MARK: -
    // MARK: Initializations
    
    public init(name: String,
                gender: Gender,
                salary: Salary = .value(0.2),
                bankAccount: Double = 0.0,
                money: Double = 0)
    {
        self.name = name
        self.gender = gender
        self.salary = salary
        self.bankAccount = bankAccount
        self.money = money
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func salaryCoefficient() -> Double {
        switch salary {
        case .none:
            return 1.0
        case let .value(doubleValue):
            return doubleValue
        }
    }
    
    public func action() {
        fatalError("This function is not implemented in this class")
    }
}
