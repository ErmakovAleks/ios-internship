import Foundation

public class Washer: Employee, TransferDelegate {
    
    public var delegate: TransferDelegate?
    
    public var serviceCost: Double = 20.0
    
    public override init(name: String,
                  gender: Gender,
                  age: Int,
                  salary: Salary = .value(2000.0),
                  bankAccount: Double = 0.0) {
        
        super.init(name: name,
                   gender: gender,
                   age: age,
                   salary: salary,
                   bankAccount: bankAccount)
    }
    
    private func checkCar(client: Car) -> Bool {
        return (client.getMoneyInfo() >= serviceCost) && client.getCleannessInfo()
    }
    
    private func moneyFromClient(client: Car) {
        client.pay(payment: serviceCost)
    }
    
    public func washing(client: Car) {
        if checkCar(client: client) {
            client.pay(payment: serviceCost)
            self.delegate?.requestEarnings(sum: serviceCost)
            client.setCleanness(clean: true)
            print("Car washed, sir!")
        } else {
            print("I'm sorry, you don't have enough money, sir")
        }
    }
    
    public func requestEarnings(sum: Double) {
        bankAccount += sum
    }
}
