import Foundation

public class Accountant: Employee {
    
    // MARK: -
    // MARK: Public variables
    
    public var didFinishWork: ((Accountant) -> ())?
    private let queue = DispatchQueue(label: "", qos: .background)
    
    // MARK
    // MARK: Initializations
    
    public override init(
        name: String,
        gender: Gender,
        salary: Salary = .coefficient(0.2),
        bankAccount: Double = 0.0,
        money: Double = 0
    ) {
        super.init(
            name: name,
            gender: gender,
            salary: salary,
            bankAccount: bankAccount,
            money: money
        )
        position = "accountant"
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func action(object: MoneyContainable) {
        self.distributeEarnings(object: object)
        self.message = "My name is \(self.name), I am a \(self.position)," +
        " I have \(self.bankAccount) on my bank account"
        self.didFinishWork?(self)
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func distributeEarnings(object: MoneyContainable) {
        object.bankAccount += object.money * object.salaryCoefficient()
        self.bankAccount += object.money * self.salaryCoefficient()
        self.money = object.money - object.money *
        (self.salaryCoefficient() + object.salaryCoefficient())
        object.money = 0
    }
}
