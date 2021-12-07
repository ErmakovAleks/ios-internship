import Foundation
import PlaygroundSupport

//let queue = DispatchQueue(label: "", qos: .utility, attributes: [.concurrent])
//
//let mas = Array(0..<10000)
//let res = mas.reduce(0, +)
//
//var res2 = 0
//var count = 0
//var count2 = 0
//mas.forEach { value in
//    count += 1
//    queue.async {
//        count2 += 1
//        res2 += value
//    }
//}
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//    print("end \(res) \(res2) count = \(count) count2 = \(count2)")
//    DispatchQueue.main.async {
//        print("RES2 = \(res2)")
//    }
//}
//
//print("end2 \(res) \(res2) count = \(count) count2 = \(count2)")
//
//DispatchQueue.main.async {
//    print("res2 = \(res2)")
//}

class TestTimer {

    typealias Handler = () -> ()

    private let handler: Handler
    private let queue: DispatchQueue

    init(handler: @escaping Handler, queue: DispatchQueue?) {
        self.queue = DispatchQueue.global(qos: .background)
        self.handler = handler

        self.start()
    }

    private func start() {
        self.queue.asyncAfter(deadline: .now() + 1) {
            self.handler()
        }
    }
}

let queue = DispatchQueue(label: "")
let array = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

func iterations() {
    for i in 0..<array.count {
        print(array[i])
    }
}


print("Start!")
let testTimer = TestTimer(handler: iterations, queue: queue)
print("Finish!")
