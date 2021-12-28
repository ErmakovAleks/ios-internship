import Foundation

public enum Gender {
    case male
    case female
}

public enum Salary {
    case coefficient(Double)
    case none
}

public class Employee: MoneyContainable {
    
    // MARK: -
    // MARK: Public variables
    
    public var earnings: Atomic<Double> = Atomic(0)
    public var name: String
    public var salary: Salary
    public var bankAccount: Atomic<Double> = Atomic(0)
    public var isBusy = Atomic(false)
    public var message = String()
    public var serviceCost: Double
    
    // MARK: -
    // MARK: Initializations
    
    public init(
        name: String,
        salary: Salary = .coefficient(0.2),
        bankAccount: Double = 0.0,
        money: Double = 0
    ){
        self.name = name
        self.salary = salary
        self.bankAccount.value = bankAccount
        self.earnings.value = money
        self.serviceCost = 0
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func salaryCoefficient() -> Double {
        switch salary {
        case .none:
            return 1.0
        case let .coefficient(doubleValue):
            return doubleValue
        }
    }
    
    public func action() {
        fatalError("This function is not implemented in this class")
    }
}
