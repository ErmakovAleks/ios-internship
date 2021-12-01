import Foundation

let john = Washer(name: "John", gender: .male, salary: .value(0.15))
let george = Washer(name: "George", gender: .male, salary: .value(0.15))
let paul = Accountant(name: "Paul", gender: .male, salary: .value(0.2))
let ringo = Director(name: "Ringo", gender: .male)

let washingPremises = Premises(humanCapacity: 1/*, employees: [john]*/, carCapacity: 1)
washingPremises.employees.add(john)
washingPremises.employees.add(george)
let washingBuilding = Building(rooms: [washingPremises])

let adminCabinet = Room(humanCapacity: 1/*, employees: [paul]*/)
adminCabinet.employees.add(paul)
adminCabinet.employees.add(ringo)
let adminBuilding = Building(rooms: [adminCabinet])

let view = View()
//let controller = Controller(view: view, director: ringo, accountant: paul, washer: john)
let controller = Controller(view: view, adminBuilding: adminBuilding, washingBuilding: washingBuilding)

while(true) {
    washingPremises.cars.add(Car())
    controller.checkQueue(object: washingPremises)
}
