import Foundation
import PlaygroundSupport

let serialQueue = DispatchQueue(label: "SerialQueue")
let concurrentQueue = DispatchQueue(label: "ConcurrentQueue", attributes: .concurrent)


func task0() {
    (1...5).forEach { _ in print(0)}
}

func task1() {
    (11...15).forEach { _ in print(1)}
}

func task2() {
    (21...25).forEach { _ in print(22)}
}

func task3() {
    (31...35).forEach { _ in print(333)}
}

func task4() {
    (41...45).forEach { _ in print(4444)}
}

func task5() {
    (51...55).forEach { _ in print(55555)}
}

func task6() {
    (61...65).forEach { _ in print(666666)}
}

func task7() {
    (71...75).forEach { _ in print(7777777)}
}

func task8() {
    (81...85).forEach { _ in print(88888888)}
}


var tasks: [() -> ()] = [task0, task1, task2, task3, task4, task5, task6, task7, task8]

var i = 0
while i < 100 {
    let f = tasks[i % 9]
    if i % 9 == 3 {
        serialQueue.async {
            serialQueue.asyncAfter(deadline: .now() + 0.01) {
                f()
            }
        }
        i += 1
        continue
    } else if i % 9 == 6 {
        serialQueue.sync {
            serialQueue.asyncAfter(deadline: .now() + 0.01) {
                f()
            }
        }
        i += 1
        continue
    }
    f()
    i += 1
}

