import Foundation

public class ThreadSafeArray<T> {
    private var array: [T] = []
    private let queue = DispatchQueue(label: "com.ThreadSafeArrayQueue", attributes: .concurrent)
    
    public func append( _ newItem: T) {
        self.queue.async(flags: .barrier) {
            self.array.append(newItem)
        }
    }
    
    public func removeFirst() -> T? {
        var temp: T?
        self.queue.async {
            temp = self.array.removeFirst()
        }
        return temp
    }
    
    public func getItem( _ index: Int) -> T? {
        var temp: T?
        self.queue.sync {
            temp = self.array[index]
        }
        return temp
    }
    
    public var isEmpty: Bool {
        var temp: Bool = true
        self.queue.sync {
            temp = self.array.isEmpty
        }
        return temp
    }
}
