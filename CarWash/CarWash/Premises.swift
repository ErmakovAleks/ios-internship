import Foundation

public class Premises: Room, CarContainable {
    
    // MARK: -
    // MARK: Public variables
    
    public var carCapacity: Int
    public var cars: [Car]
    
    // MARK: -
    // MARK: Initializations
    
    public init(humanCapacity: Int = 1, employees: [Employee], carCapacity: Int = 1, cars: [Car]) {
        self.carCapacity = carCapacity
        self.cars = cars
        
        super.init(humanCapacity: humanCapacity, employees: employees)
    }
}
