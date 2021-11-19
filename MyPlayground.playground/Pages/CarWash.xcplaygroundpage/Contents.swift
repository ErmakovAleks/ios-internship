import Foundation

public protocol TransferDelegate {
    
    func requestEarnings(sum: Double)
}

public class Building {
    public var rooms: [Room]
    
    init(rooms: [Room]) {
        self.rooms = rooms
    }
}

public class Room {
    var humanCapacity: Int
    var employees: [Employee]
    
    init(humanCapacity: Int = 1, employees: [Employee] = []) {
        self.humanCapacity = humanCapacity
        self.employees = employees
    }
}

public class Premises: Room {
    var carCapacity: Int
    
    init(humanCapacity: Int = 1,
         employees: [Employee],
         carCapacity: Int = 1) {
        
        self.carCapacity = carCapacity
        
        super.init(humanCapacity: humanCapacity,
                   employees: employees)
    }
}

public class Employee {
    public var name: String
    public var gender: Gender
    public var age: Int
    public var salary: Salary
    private var bankAccount: Double
    
    init(name: String,
         gender: Gender,
         age: Int,
         salary: Salary = .value(2000.0),
         bankAccount: Double = 0.0) {
        
        self.name = name
        self.gender = gender
        self.age = age
        self.salary = salary
        self.bankAccount = bankAccount
    }
}

public class Accountant: Employee, TransferDelegate {
    
    public var directorDelegate: TransferDelegate?
    
    public var washerDelegate: TransferDelegate?
    
    override init(name: String,
                  gender: Gender,
                  age: Int,
                  salary: Salary = .value(2200.0),
                  bankAccount: Double = 0.0) {
        
        super.init(name: name,
                   gender: gender,
                   age: age,
                   salary: salary,
                   bankAccount: bankAccount)
    }
    
    public func requestEarnings(sum: Double) {
        calculateProfit(sum: sum)
    }
    
    private func calculateProfit(sum: Double) {
        self.bankAccount += sum * Double(self.salary)!
        self.washerDelegate?.requestEarnings(sum: sum * Double(washerDelegate.salary))
        self.directorDelegate?.requestEarnings(sum: sum - sum * (Double(self.salary) + Double(directorDelegate.salary)))
    }
}

public class Director: Employee, TransferDelegate {
    
    private var profit = Double()
    
    override init(name: String,
                  gender: Gender,
                  age: Int,
                  salary: Salary = .none,
                  bankAccount: Double = 0.0) {
        
        super.init(name: name,
                   gender: gender,
                   age: age,
                   salary: salary,
                   bankAccount: bankAccount)
    }
    
    public func requestEarnings(sum: Double) {
        profit += sum
    }
}

public class Washer: Employee, TransferDelegate {
    
    public var delegate: TransferDelegate?
    
    public var productivity: Int
    
    public var serviceCost: Double = 20.0
    
    private var privateBankAccount = Double()
    
    init(name: String,
                  gender: Gender,
                  age: Int,
                  salary: Salary = .value(2000.0),
                  bankAccount: Double = 0.0,
                  productivity: Int = 1) {
        
        self.productivity = productivity
        
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
        privateBankAccount += sum
    }
}

public class Car {
    
    private var money = Double()
    
    private var cleanness = Bool()
    
    init(money: Double, cleanness: Bool) {
        self.money = money
        self.cleanness = cleanness
    }
    
    public func getMoneyInfo() -> Double { money }
    
    public func pay(payment: Double) { money - payment }
    
    public func getCleannessInfo() -> Bool { cleanness }
    
    public func setCleanness(clean: Bool) { cleanness = clean }
}

public enum Gender {
    case male
    case female
}

public enum Salary {
    case value(Double)
    case none
}

var clientCar: Car = Car(money: 180.0, cleanness: false)


var john: Washer = Washer(name: "John", gender: .male, age: 20, salary: .value(0.15))

var paul: Accountant = Accountant(name: "Paul", gender: .male, age: 25, salary: .value(0.2))

var ringo: Director = Director(name: "Ringo", gender: .male, age: 30)


var washingPremises: Premises = Premises(humanCapacity: 1, employees: [john], carCapacity: 1)

var washingBuilding: Building = Building(rooms: [washingPremises])


var adminCabinet: Room = Room(humanCapacity: 1, employees: [paul])

var adminBuilding: Building = Building(rooms: [adminCabinet])


john.delegate = paul

paul.washerDelegate = john

paul.directorDelegate = ringo


