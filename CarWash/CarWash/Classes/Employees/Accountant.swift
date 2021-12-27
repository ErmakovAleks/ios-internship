import Foundation

public class Accountant: Employee {
    
    // MARK: -
    // MARK: Public variables
    
    public var didFinishWork: ((Accountant) -> ())?
    
    // MARK
    // MARK: Initializations
    
    public override init(
        name: String,
        gender: Gender,
        salary: Salary = .coefficient(0.2),
        bankAccount: Double = 0,
        money: Double = 0
    ) {
        super.init(name: name, gender: gender, salary: salary, bankAccount: bankAccount, money: money)
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func action(object: MoneyContainable) {
        self.distributeEarnings(object: object)
        self.message = "My name is \(self.name), I am an accountant," +
        " I have \(self.bankAccount.wrappedValue) on my bank account"
        sleep(UInt32(Int.random(in: 0...3)))
        self.didFinishWork?(self)
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func distributeEarnings(object: MoneyContainable) {
        object.bankAccount.wrappedValue += object.serviceCost * object.salaryCoefficient()
        self.bankAccount.wrappedValue += object.serviceCost * self.salaryCoefficient()
        self.earnings.wrappedValue = object.serviceCost - object.serviceCost *
        (self.salaryCoefficient() + object.salaryCoefficient())
        self.serviceCost = object.serviceCost
        object.earnings.wrappedValue -= object.serviceCost
        object.isEarned.wrappedValue = false
        self.isEarned.modify { $0 = true }
    }
}
