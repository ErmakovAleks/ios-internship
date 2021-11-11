import UIKit

protocol InterchangeViaElevatorProtocol {
    func cookOrder(order: String) -> Bool
}

class Waiter {

    // Далее официанту добаим свойство "получатель заказа через лифт". Официанту известно, что этот получатель знает правила и приготовит то, что в записке.
    var receiverOfOrderViaElevator: InterchangeViaElevatorProtocol?

    var order: String?

    func takeOrder(_ food: String) {
        print("What would you like?")
        print("Yes, of course!")
        order = food
        sendOrderToCook()
    }

    private func sendOrderToCook() {
        receiverOfOrderViaElevator?.cookOrder(order: order!)
    }

    private func serveFood() {
        print("Your \(order!). Enjoy your meal!")
    }

}

// Создаем класс повара
class Cook: InterchangeViaElevatorProtocol {

    private let pan: Int = 1
    private let stove: Int = 1

    private func cookFood(_ food: String) -> Bool {
        print("Let's take a pan")
        print("Let's put \(food) on the pan")
        print("Let's put the pan on the stove")
        print("Wait a few minutes")
        print("\(food) is ready!")
        return true
    }

    // Необходимый метод, согласно правилу(протоколу):
    func cookOrder(order: String) -> Bool {
        cookFood(order)
    }
}

// Нанимаем на работу официанта и повара:
let waiter = Waiter()
let cook = Cook()

waiter.receiverOfOrderViaElevator = cook

// Добавим официанту заказ:
waiter.takeOrder("Chiken")

