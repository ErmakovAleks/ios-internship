import Foundation

public class Premises: Room, CarContainable {
    
    // MARK: -
    // MARK: Public variables
    
    public var carCapacity: Int
    public var cars: Queue<Car?>
    
    // MARK: -
    // MARK: Initializations
    
    public init(humanCapacity: Int = 1, employees: [Employee], carCapacity: Int = 1) {
        self.carCapacity = carCapacity
        self.cars = Queue()
        
        super.init(humanCapacity: humanCapacity, employees: employees)
    }
}
