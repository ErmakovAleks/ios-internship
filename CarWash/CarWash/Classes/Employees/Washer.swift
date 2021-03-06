import Foundation

public class Washer: Employee {
    
    // MARK: -
    // MARK: Public variables
    
    public var didFinishWork: ((Washer) -> ())?
    
    // MARK: -
    // MARK: Initializations
    
    public override init(
        name: String,
        salary: Salary = .coefficient(0.15),
        bankAccount: Double = 0.0,
        money: Double = 0
    ) {
        super.init(name: name, salary: salary, bankAccount: bankAccount, money: money)
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
            message = "My name is \(self.name), I am a washer, "
                + "I have \(self.bankAccount.value) on my bank account"
            client.cleanness = true
        } else {
            message = "I'm sorry, you don't have enough money, sir"
        }
        sleep(UInt32(Int.random(in: 0...1)))
        self.didFinishWork?(self)
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func isPermissible(client: Car) -> Bool {
        return client.money >= serviceCost && !client.cleanness
    }
    
    private func moneyFromClient(client: Car) {
        if let money = client.pay(payment: serviceCost) {
            self.earnings.value = self.earnings.value + money
        }
    }
}
