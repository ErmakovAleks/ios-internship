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

public class ThreadSafeString {
    private var internalString = ""
    let isolationQueue = DispatchQueue(label:"com.bestkora.isolation",
                                       attributes: .concurrent)
    
    public func addString(string: String) {
        isolationQueue.async(flags: .barrier) {
            self.internalString = self.internalString + string
        }
    }
    public func setString(string: String) {
        isolationQueue.async(flags: .barrier) {
            self.internalString = string
        }
    }
    
    public init (_ string: String){
        isolationQueue.async(flags: .barrier) {
            self.internalString = string
        }
    }
    
    public var text: String {
        var result = ""
        isolationQueue.sync {
            result = self.internalString
        }
        return result
    }
}
