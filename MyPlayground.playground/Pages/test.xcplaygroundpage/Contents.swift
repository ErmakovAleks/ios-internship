import Foundation
import PlaygroundSupport

//let queue = DispatchQueue(label: "", qos: .background, attributes: [.concurrent])
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

let array = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
var i = 0
print("Start!")
    let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
        print(array[i])
        i += 1
        if i == array.count {
            timer.invalidate()
        }
    }
DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
    print("Finish!")
}
