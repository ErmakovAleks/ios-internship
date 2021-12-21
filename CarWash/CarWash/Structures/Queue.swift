import Foundation

public struct Queue<T> {
    
    private var array: [T] = []
    private let lock = NSLock()
    private let concurrentQueue = DispatchQueue(label: "com.concurrentQueue", attributes: .concurrent)
    
    public mutating func add(_ item: T) {
        self.lock.do {
            array.append(item)
        }
    }
    
    public mutating func extract() -> T? {
        var temp: T?
        self.lock.do {
            if !array.isEmpty {
                temp = array.removeFirst()
            } else {
                temp = nil
            }
        }
        return temp
    }
    
    public mutating func clear() {
        array.removeAll()
    }
    
    public var isEmpty: Bool { return array.isEmpty }
}
