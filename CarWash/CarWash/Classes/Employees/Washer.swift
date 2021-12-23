import Foundation

public class Washer: Employee {
    
    // MARK: -
    // MARK: Public variables
    
    public var didFinishWork: ((Washer) -> ())?
    
    // MARK: -
    // MARK: Initializations
    
    public override init(
        name: String,
        gender: Gender,
        salary: Salary = .coefficient(0.15),
        bankAccount: Double = 0.0,
        money: Double = 0
    ) {
        super.init(name: name, gender: gender, salary: salary, bankAccount: bankAccount, money: money)
        serviceCost = 20.0
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func action(car: Car) {
        self.washing(client: car)
    }
    
    public func washing(client: Car) {
        if isPermissible(client: client) {
            moneyFromClient(client: client)
            message = "My name is \(self.name), I am a washer, " +
            "I have \(self.bankAccount) on my bank account"
            client.cleanness = true
            isEarned.wrappedValue = true
        } else {
            isEarned.wrappedValue = false
            message = "I'm sorry, you don't have enough money, sir"
        }
        sleep(UInt32(Int.random(in: 0...5)))
        self.didFinishWork?(self)
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func isPermissible(client: Car) -> Bool {
        return client.money >= serviceCost && !client.cleanness
    }
    
    private func moneyFromClient(client: Car) {
        self.earnings.wrappedValue += client.pay(payment: serviceCost)
    }
}
