import Foundation

public class Room {
    var humanCapacity: Int
    var employees: [Employee]
    
    init(humanCapacity: Int = 1, employees: [Employee] = []) {
        self.humanCapacity = humanCapacity
        self.employees = employees
    }
}
