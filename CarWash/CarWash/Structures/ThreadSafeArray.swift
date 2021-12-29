import Foundation

public class ThreadSafeArray<T> {
    
    // MARK: -
    // MARK: Public variables
    
    public var isEmpty: Bool {
        return self.queue.sync {
            self.array.isEmpty
        }
    }
    
    // MARK: -
    // MARK: Private variables
    
    private var array: [T] = []
    private let queue = DispatchQueue(label: "com.car-wash.thread-safe-array", attributes: .concurrent)
    
    // MARK: -
    // MARK: Public functions
    
    public func append(contentsOf arr: [T]) {
        self.queue.sync(flags: .barrier) {
            self.array.append(contentsOf: arr)
        }
    }
    
    public func append( _ newItem: T) {
        self.queue.sync(flags: .barrier) {
            self.array.append(newItem)
        }
    }
    
    public func removeFirst() -> T? {
        return self.queue.sync(flags: .barrier) {
            !self.array.isEmpty
                ? self.array.removeFirst()
                : nil
        }
    }
    
    subscript ( _ index: Int) -> T? {
        return self.queue.sync {
            !self.array.isEmpty
                ? self.array[index]
                : nil
        }
    }
}
