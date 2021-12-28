import Foundation

public struct Queue<T> {
    
    // MARK: -
    // MARK: Public variables
    
    public var isEmpty: Bool {
        return self.lock.do {
            return self.array.isEmpty
        }
    }
    
    // MARK: -
    // MARK: Private variablers
    
    private var array: [T] = []
    
    private let lock = NSRecursiveLock()
    
    // MARK: -
    // MARK: Public functions
    
    public mutating func add(_ item: T) {
        self.lock.do {
            array.append(item)
        }
    }
    
    public mutating func extract() -> T? {
        return self.lock.do {
            return !self.array.isEmpty
                ? self.array.removeFirst()
                : nil
        }
    }
    
    public mutating func clear() {
        self.lock.do {
            array.removeAll()
        }
    }
}
