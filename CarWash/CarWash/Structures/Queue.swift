import Foundation

public struct Queue<T>{
    
    private var array: [T?] = []
    
    public mutating func add(_ item: T) {
        array.append(item)
    }
    
    public mutating func extract() -> T? {
        if array.isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    public mutating func clear() {
        array.removeAll()
    }
    
    public var isEmpty: Bool { return array.isEmpty }
}
