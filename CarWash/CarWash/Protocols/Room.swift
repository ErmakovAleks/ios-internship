import Foundation

public protocol Room {
    
    // MARK: -
    // MARK: Public variables
    
    var employees: Queue<Employee> { get set }
    
}
