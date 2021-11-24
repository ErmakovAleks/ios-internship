import Foundation

let clientOne = Car(money: 50, cleanness: false)
let clientTwo = Car(money: 70, cleanness: false)

let john = Washer(name: "John", gender: .male, age: 20, salary: .value(0.15))
let paul = Accountant(name: "Paul", gender: .male, age: 25, salary: .value(0.2))
let ringo = Director(name: "Ringo", gender: .male, age: 30)

let washingPremises = Premises(humanCapacity: 1, employees: [john], carCapacity: 1)
let washingBuilding = Building(rooms: [washingPremises])

let adminCabinet = Room(humanCapacity: 1, employees: [paul])
let adminBuilding = Building(rooms: [adminCabinet])

john.delegate = paul
paul.delegate = ringo

while(true) {
    washingPremises.cars.add(Car())
    john.checkQueue(object: washingPremises)
    john.balanceInfo()
    paul.balanceInfo()
    ringo.balanceInfo()
}
