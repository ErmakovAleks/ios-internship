import Foundation

public struct Queue<T>{
    
    private var array: [T?] = []
    
    public mutating func add(_ item: T) {
        array.append(item)
    }
    
    public mutating func extract() -> T? {
        !array.isEmpty ? array.removeFirst() : nil
    }
    
    public mutating func clear() {
        array.removeAll()
    }
    
    public var isEmpty: Bool { return array.isEmpty }
}
