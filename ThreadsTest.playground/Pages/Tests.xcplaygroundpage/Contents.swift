import Foundation
import PlaygroundSupport

let serialQueue = DispatchQueue(label: "SerialQueue")
let concurrentQueue = DispatchQueue(label: "ConcurrentQueue")

func task1() {
    (11...15).forEach { _ in print(1)}
}

func task2() {
    (21...25).forEach { _ in print(2)}
}

func task3() {
    (31...35).forEach { _ in print(3)}
}

func task4() {
    (41...45).forEach { _ in print(4)}
}

func task5() {
    (51...55).forEach { _ in print(5)}
}

func task6() {
    (61...65).forEach { _ in print(6)}
}

func task7() {
    (71...75).forEach { _ in print(7)}
}

func task8() {
    (81...85).forEach { _ in print(8)}
}

//task1()
//task2()
//serialQueue.sync {
//    task3()
//}
//task4()
//task5()
//task6()
//serialQueue.async {
//    task7()
//}
//task8()

var array = [10, 20, 30, 40, 50]
var x = array.removeFirst()

print(array)
print(x)
