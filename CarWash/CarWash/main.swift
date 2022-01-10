import Foundation

let john = Washer(name: "John", salary: .coefficient(0.15))
let george = Washer(name: "George", salary: .coefficient(0.15))
let jack = Washer(name: "Jack", salary: .coefficient(0.15))
let paul = Accountant(name: "Paul", salary: .coefficient(0.2))
let ringo = Director(name: "Ringo")

let washingPremises = Premises()
washingPremises.employees.append(john)
washingPremises.employees.append(george)
washingPremises.employees.append(jack)
let washingBuilding = WashingBuilding(rooms: washingPremises)

let adminCabinet = Cabinet(director: ringo)
adminCabinet.employees.append(paul)
let adminBuilding = AdminBuilding(director: ringo, rooms: adminCabinet)

let complex = CarWashComplex(adminBuilding: adminBuilding, washingBuilding: washingBuilding)

let view = View()
let controller = Controller(view: view, complex: complex)

while(true) {
    washingPremises.cars.add(Car())
    controller.checkQueue()
}
