import Foundation

public class Premises: Room {

    // MARK: -
    // MARK: Public variables
    
    public var employees: [Employee]
    public var cars: [Car]
    
    // MARK: -
    // MARK: Initializations
    
    public init() {
        self.employees = []
        self.cars = []
    }
}
