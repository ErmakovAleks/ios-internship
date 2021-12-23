import Foundation

public class Director: Employee {
    
    // MARK: -
    // MARK: Public variables
    
    public var didFinishWork: ((Director) -> ())?
    
    // MARK: -
    // MARK: Initializations
    
    public override init(
        name: String,
        gender: Gender,
        salary: Salary = .none,
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
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func action(object: MoneyContainable) {
        self.takeProfit(object: object)
        self.message = "My name is \(self.name), I am a director, " +
        "I have \(self.bankAccount) on my bank account"
        sleep(UInt32(Int.random(in: 0...2)))
        self.didFinishWork!(self)
    }
    
    public func takeProfit(object: MoneyContainable) {
        if object.isEarned.unsafe {
            self.bankAccount.wrappedValue += object.earnings.wrappedValue
            object.earnings.wrappedValue -= object.earnings.wrappedValue
        }
    }
}
