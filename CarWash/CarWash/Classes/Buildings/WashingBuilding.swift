import Foundation

public class WashingBuilding: Building {
    public var rooms: [Room]
    public var cars: Queue<Car?>?
    
    init(rooms: [Premises]) {
        self.rooms = rooms
        if !rooms[0].cars.isEmpty {
            self.cars = rooms[0].cars
        }
    }
}
