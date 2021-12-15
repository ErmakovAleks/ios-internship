import Foundation

// 1
var value: Int = 0
let serialQueue = DispatchQueue(label: "ru.denisegaluev.serial-queue")

// 2
func increment() { value += 1 }

// 3
serialQueue.sync {
    // 4
    sleep(5)
    print("value = \(value)")
    increment()
}

// 5
print("Here value is \(value)")

// 6
value = 10

// 7
serialQueue.sync {
    print("before sync operation value is \(value)")
    increment()
    print("Done!")
}

// 8
print(value)
