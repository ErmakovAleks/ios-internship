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
        queue.asyncAfter(deadline: .now() + 1) {
            self.takeProfit(object: object)
            self.message = "My name is \(self.name), I am a \(self.position), " +
            "I have \(self.bankAccount) on my bank account"
            let randomTime = UInt32(Int.random(in: 0...2))
            sleep(randomTime)
            self.didFinishWork!(self)
        }
    }
    
    public func takeProfit(object: MoneyContainable) {
        if object.isEarned {
            self.bankAccount += object.serviceCost
            object.money -= object.serviceCost
        }
    }
}
