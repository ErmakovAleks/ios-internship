import Foundation

public class Atomic<T> {
    
    // MARK: -
    // MARK: Public variables
    
    public var unsafe: T {
        get { self.value }
        set { self.value = newValue }
    }
    
    // MARK: -
    // MARK: Private variables
    
    private var value: T
    private let lock: NSLocking
    
    // MARK: -
    // MARK: Initializations

    init( _ value: T, lock: NSLocking = NSRecursiveLock()) {
        self.value = value
        self.lock = lock
    }
    
    var wrappedValue: T {
        get {
            self.modify { $0 }
        }
        set {
            self.modify {
                $0 = newValue
            }
        }
    }
    
    // MARK: -
    // MARK: Public functions

    public func modify<Result>( _ modification: (inout T) -> Result) -> Result {
        self.lock.do {
            modification(&value)
        }
    }
}

