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


//for i in 0..<100 {
//    let f = tasks[i % 9]
//    if i % 9 == 3 {
//        serialQueue.asyncAfter(deadline: .now() + 2) {
//            print(i)
//            f()
//        }
//        continue
//    } else if i % 9 == 6 {
//        serialQueue.asyncAfter(deadline: .now() + 1) {
//            print(i)
//            f()
//        }
//        continue
//    }
//    f()
//}

//------------------------------------------------------------

//var value = "angel"
//
//func changeValue(variant: Int) {
//    sleep(1)
//    value = value + "chicken"
//    print("\(value) - \(variant)")
//}
//
//serialQueue.async {
//    changeValue(variant: 1)
//}
//value
//
//value = "fox"
//
//serialQueue.sync {
//    changeValue(variant: 2)
//}
//value

//-------------------------------------------------------------

//public class ThreadSafeString {
//    private var internalString = ""
//    let isolationQueue = DispatchQueue(label:"com.bestkora.isolation",
//                                       attributes: .concurrent)
//
//    public func addString(string: String) {
//        isolationQueue.async(flags: .barrier) {
//            self.internalString = self.internalString + string
//        }
//    }
//    public func setString(string: String) {
//        isolationQueue.async(flags: .barrier) {
//            self.internalString = string
//        }
//    }
//
//    public init (_ string: String){
//        isolationQueue.async(flags: .barrier) {
//            self.internalString = string
//        }
//    }
//
//    public var text: String {
//        var result = ""
//        isolationQueue.sync {
//            result = self.internalString
//        }
//        return result
//    }
//}

//----------------------------------------------------------------

//class AsyncVsSyncTest {
//    private let serQueue = DispatchQueue(label: "ser")
//
//    func testConcurrent() {
//        serQueue.async {
//            print("test1")
//        }
//
//        serQueue.async {
//            sleep(1)
//            print("test2")
//        }
//
//        serQueue.async {
//            sleep(1)
//            print("test3")
//        }
//
//        serQueue.sync {
//            print("test4")
//        }
//    }
//}
//
//let test = AsyncVsSyncTest()
//
//test.testConcurrent()

//--------------------------------------------------------------------

//let sQueue = DispatchQueue(label: "sQueue")
//let item = DispatchWorkItem {
//     print("test")
//}
//item.notify(queue: sQueue) {
//     print("finish")
//}
//sQueue.async {
//     sleep(1)
//}
//sQueue.async(execute: item)
//item.cancel()

//---------------------------------------------------------------------

//class SemaphoreTest {
//
//    private let semaphore = DispatchSemaphore(value: 0)
//
//    func test() {
//
//        DispatchQueue.global().async {
//            sleep(3)
//            print("1")
//            self.semaphore.signal()
//        }
//        semaphore.wait()
//        print("2")
//    }
//}
//
//let semaphoreTest = SemaphoreTest()
//semaphoreTest.test()

//---------------------------------------------------------------------

class DispatchGroupTest {
    private let group = DispatchGroup()
    private let queue = DispatchQueue(label: "DispatchGroupTest")
    
    func testWait() {
        group.enter()
        queue.async {
            sleep(5)
            print("1")
            self.group.leave()
        }
        group.enter()
        queue.async {
            sleep(5)
            print("2")
            self.group.leave()
        }
        group.wait()
        print("finish all")
    }
}

let dgTest = DispatchGroupTest()

dgTest.testWait()
