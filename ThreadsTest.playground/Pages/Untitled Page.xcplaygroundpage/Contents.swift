import Foundation
import PlaygroundSupport

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
let array = [0, 10, 20, 30]

func iterations() {
    for i in 0..<array.count {
        print(array[i])
    }
}

func finish() {
    queue.asyncAfter(deadline: .now() + 2, qos: .background) {
        print("Finish!")
    }
}


print("Start!")
queue.asyncAfter(deadline: .now() + 1) {
    iterations()
    finish()
}

class DispatchBarrierTest {
    
    private let dbqueue = DispatchQueue(label: "DispatchBarrierTest", attributes: .concurrent)
    private var internalTest: Int = 0
    
    func setTest( _ test: Int) {
        dbqueue.async(flags: .barrier) {
            self.internalTest = test
        }
    }
    
    func test() -> Int {
        var tmp: Int = 0
        dbqueue.sync {
            tmp = self.internalTest
        }
        return tmp
    }
}

