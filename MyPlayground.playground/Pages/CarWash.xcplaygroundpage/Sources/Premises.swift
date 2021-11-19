import Foundation

public class Premises: Room {
    public var carCapacity: Int
    
    public init(humanCapacity: Int = 1,
         employees: [Employee],
         carCapacity: Int = 1) {
        
        self.carCapacity = carCapacity
        
        super.init(humanCapacity: humanCapacity,
                   employees: employees)
    }
}
