import Foundation

public enum Gender {
    case male
    case female
}

public enum Salary {
    case value(Double)
    case none
}

var clientCar: Car = Car(money: 50.0, cleanness: false)


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


