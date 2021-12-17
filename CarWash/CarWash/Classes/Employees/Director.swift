import Foundation

public class Director: Employee {
    
    // MARK: -
    // MARK: Public variables
    
    public var didFinishWork: ((Director) -> ())?
    private let queue = DispatchQueue(label: "", qos: .background)
    
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
        position = "director"
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func action(object: MoneyContainable) {
        self.takeProfit(object: object)
        self.message = "My name is \(self.name), I am a \(self.position), " +
        "I have \(self.bankAccount) on my bank account"
        sleep(UInt32(Int.random(in: 0...2)))
        self.didFinishWork!(self)
    }
    
    public func takeProfit(object: MoneyContainable) {
        if object.isEarned {
            self.bankAccount += object.earnings
            object.earnings -= object.earnings
        }
    }
}
