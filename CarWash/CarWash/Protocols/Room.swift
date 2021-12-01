import Foundation

public protocol Room {
    
    // MARK: -
    // MARK: Public variables
    
    //public var humanCapacity: Int
    //public var employees: [Employee]
    var employees: Queue<Employee?> { get set }
}
