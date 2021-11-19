import Foundation

public class Room {
    public var humanCapacity: Int
    public var employees: [Employee]
    
    public init(humanCapacity: Int = 1, employees: [Employee] = []) {
        self.humanCapacity = humanCapacity
        self.employees = employees
    }
}
