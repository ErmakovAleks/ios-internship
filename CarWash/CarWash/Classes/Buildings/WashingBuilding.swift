import Foundation

public class WashingBuilding {
    
    // MARK: -
    // MARK: Public variables
    
    public var rooms: [Premises]
    public var cars: Queue<Car?>?
    
    // MARK: -
    // MARK: Initializations
    
    init(rooms: [Premises]) {
        self.rooms = rooms
        if !rooms[0].cars.isEmpty {
            self.cars = rooms[0].cars
        }
    }
}
