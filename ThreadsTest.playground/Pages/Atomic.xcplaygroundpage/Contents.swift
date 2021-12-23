import Foundation

class Atomic<T> {
    public var unsafe: T
    private var value: T
    private let lock = NSRecursiveLock()

    init( _ wrappedValue: T) {
        lock.lock()
        defer { lock.unlock() }
        self.value = wrappedValue
        self.unsafe = self.value
    }
    
    var wrappedValue: T {
        get {
            lock.lock()
            defer { lock.unlock() }
            return value
        }
        set {
            self.modify {
                $0 = newValue
            }
        }
    }

    public func modify( _ modification: (inout T) -> Void) {
        lock.lock()
        defer { lock.unlock() }
        modification(&value)
    }
}

let myValue1: Atomic<Bool>
myValue1 = Atomic(false)

myValue1.modify {
    if $0 == false {
        $0 = true
    }
}

let myValue2: Atomic<Bool>
myValue2 = Atomic(false)

print(myValue1)
print(myValue2.self)
type(of: myValue2.unsafe)


//struct Atomic<Value> {
//
//    private var value: Value
//    private let lock = NSLock()
//
//    init(wrappedValue value: Value) {
//        self.value = value
//    }
//
//    var wrappedValue: Value {
//      get { return load() }
//      set { store(newValue: newValue) }
//    }
//
//    func load() -> Value {
//        lock.lock()
//        defer { lock.unlock() }
//        return value
//    }
//
//    mutating func store(newValue: Value) {
//        lock.lock()
//        defer { lock.unlock() }
//        value = newValue
//    }
//}




