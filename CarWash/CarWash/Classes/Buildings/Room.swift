import Foundation

public class Room {
    
    // MARK: -
    // MARK: Public variables
    
    public var humanCapacity: Int
    //public var employees: [Employee]
    public var employees: Queue<Employee?>
    
    // MARK: -
    // MARK: Initializations
    
    public init(humanCapacity: Int = 4/*, employees: [Employee] = []*/) {
        self.humanCapacity = humanCapacity
        //self.employees = employees
        self.employees = Queue()
    }
}
