import Foundation

public class Premises: Room {

    // MARK: -
    // MARK: Public variables
    
    //public var employees: Queue<Employee>
    public var employees: [Employee]
    //public var cars: Queue<Car>
    public var cars: [Car]
    
    // MARK: -
    // MARK: Initializations
    
    public init() {
        //self.employees = Queue()
        self.employees = []
        //self.cars = Queue()
        self.cars = []
    }
}
