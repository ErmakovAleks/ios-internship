import Foundation

public class Atomic<T> {
    public var unsafe: T
    private var value: T
    private let lock = NSRecursiveLock()

    init( _ wrappedValue: T) {
        self.lock.lock()
        defer { self.lock.unlock() }
        self.value = wrappedValue
        self.unsafe = self.value
    }
    
    var wrappedValue: T {
        get {
            self.lock.do {
                return value
            }
        }
        set {
            self.modify {
                $0 = newValue
            }
        }
    }

    public func modify( _ modification: (inout T) -> Void) {
        self.lock.do {
            modification(&value)
        }
    }
}

