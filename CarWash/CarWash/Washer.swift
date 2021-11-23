import Foundation

public class Washer: Employee {
    
    // MARK: -
    // MARK: Public variables
    
    public var delegate: ActionDelegate?
    public var serviceCost: Double = 20.0
    
    // MARK: -
    // MARK: Initializations
    
    public override init(name: String, gender: Gender, age: Int, salary: Salary = .value(0.15), bankAccount: Double = 0.0, money: Int = 0) {
        super.init(name: name, gender: gender, age: age, salary: salary, bankAccount: bankAccount, money: money)
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func checkQueue<T: CarContainable>(object: T) {
        if !object.cars.isEmpty {
            washing(client: object.cars[0])
            object.cars.remove(at: 0)
        }
    }
    
    public func washing(client: Car) {
        if checkCar(client: client) {
            moneyFromClient(client: client)
            self.delegate?.requestEarnings(object: self)
            client.cleanness = true
            print("Car washed, sir!")
        } else {
            print("I'm sorry, you don't have enough money, sir")
        }
    }
    
    public override func requestEarnings(object: MoneyContainable) {
        fatalError("There is no function implementation in this class")
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func checkCar(client: Car) -> Bool {
        return (Double(client.money) >= serviceCost) && !client.cleanness
    }
    
    private func moneyFromClient(client: Car) {
        client.pay(payment: serviceCost)
        self.money += Int(serviceCost)
    }
}
