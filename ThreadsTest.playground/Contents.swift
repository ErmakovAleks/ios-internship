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
let array = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

func iterations() {
    for i in 0..<array.count {
        print(array[i])
    }
}


print("Start!")
for _ in 0..<3 {
    let testTimer = TestTimer(handler: iterations, queue: queue)
}
print("Finish!")

