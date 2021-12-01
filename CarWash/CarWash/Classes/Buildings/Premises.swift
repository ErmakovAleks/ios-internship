import Foundation

public class Premises: Room, CarContainable {

    // MARK: -
    // MARK: Public variables
    
    public var employees: Queue<Employee?>
    public var cars: Queue<Car?>
    
    // MARK: -
    // MARK: Initializations
    
    public init() {
        self.employees = Queue()
        self.cars = Queue()
    }
}
