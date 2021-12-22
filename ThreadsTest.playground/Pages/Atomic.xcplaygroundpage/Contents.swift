import Foundation

class Atomic<T> {
    private let atomicQueue = DispatchQueue(label: "com.car-wash.atomic-queue")
    private var value: T
    
    init( _ wrappedValue: T) {
        self.value = wrappedValue
    }
    
    var projectedValue: Atomic<T> {
        return self
    }
    
    var wrappedValue: T {
        get {
            return atomicQueue.sync { value }
        }
        set {
            atomicQueue.sync { value = newValue }
        }
    }
    
    public func modify( _ modification: (inout T) -> Void) {
        return atomicQueue.sync {
            modification(&value)
        }
    }
}

let myValue = Atomic(false)

myValue.modify {
    if $0 == false {
        $0 = true
    }
}

print(myValue)
