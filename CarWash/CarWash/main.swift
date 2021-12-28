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

//let timer = Timer(timeInterval: 0.2, repeats: true) { _ in
//    print("Timer!")
//    washingPremises.cars.add(Car())
//    controller.checkQueue()
//}

//RunLoop.current.add(timer, forMode: .common)

//while(true) {
//    washingPremises.cars.add(Car())
//    controller.checkQueue()
//}

(0..<3)
    .map { _ in Car(money: 30, cleanness: false) }
    .forEach {
        washingPremises.cars.add($0)
        controller.checkQueue()
    }

sleep(5)

print("john = ", john.earnings.unsafe)
print("john = ", john.bankAccount.unsafe)

print("paul = ", paul.earnings.unsafe)
print("paul = ", paul.bankAccount.unsafe)

print("ringo = ", ringo.earnings.unsafe)
print("ringo = ", ringo.bankAccount.unsafe)

RunLoop.current.run()
