import Foundation

public class Room {
    
    // MARK: -
    // MARK: Public variables
    
    public var humanCapacity: Int
    public var employees: [Employee]
    
    // MARK: -
    // MARK: Initializations
    
    public init(humanCapacity: Int = 1, employees: [Employee] = []) {
        self.humanCapacity = humanCapacity
        self.employees = employees
    }
}
