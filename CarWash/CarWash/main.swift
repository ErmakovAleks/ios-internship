import Foundation

let john = Washer(name: "John", gender: .male, salary: .coefficient(0.15))
let george = Washer(name: "George", gender: .male, salary: .coefficient(0.15))
let jack = Washer(name: "Jack", gender: .male, salary: .coefficient(0.15))
let paul = Accountant(name: "Paul", gender: .male, salary: .coefficient(0.2))
let ringo = Director(name: "Ringo", gender: .male)

let washingPremises = Premises()
washingPremises.employees.append(john)
washingPremises.employees.append(george)
washingPremises.employees.append(jack)
let washingBuilding = WashingBuilding(rooms: [washingPremises])

let adminCabinet = Cabinet(director: ringo)
adminCabinet.employees.append(paul)
let adminBuilding = AdminBuilding(rooms: [adminCabinet])

let complex = CarWashComplex(adminBuilding: adminBuilding, washingBuilding: washingBuilding)

let view = View()
let controller = Controller(view: view, complex: complex)

while(true) {
    washingPremises.cars.append(Car())
    controller.checkQueue()
}
