import Foundation

let john = Washer(name: "John", gender: .male, salary: .value(0.15))
let paul = Accountant(name: "Paul", gender: .male, salary: .value(0.2))
let ringo = Director(name: "Ringo", gender: .male)

let washingPremises = Premises(humanCapacity: 1, employees: [john], carCapacity: 1)
let washingBuilding = Building(rooms: [washingPremises])

let adminCabinet = Room(humanCapacity: 1, employees: [paul])
let adminBuilding = Building(rooms: [adminCabinet])

let view = View()
let controller = Controller(view: view, director: ringo, accountant: paul, washer: john)

while(true) {
    washingPremises.cars.add(Car())
    controller.checkQueue(object: washingPremises)
}
