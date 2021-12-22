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
    
    public func append( _ newItem: T) {
        self.queue.sync(flags: .barrier) {
            self.array.append(newItem)
        }
    }
    
    public func removeFirst() -> T? {
        return self.queue.sync(flags: .barrier) {
            self.array.removeFirst()
        }
    }
    
    public func getItem( _ index: Int) -> T? {
        self.queue.sync {
            if !array.isEmpty {
                return self.array[index]
            } else {
                return nil
            }
        }
    }
}
