import Foundation

public class Premises: Room {
    var carCapacity: Int
    
    init(carCapacity: Int = 1) {
        self.carCapacity = carCapacity
        super.init()
    }
}
