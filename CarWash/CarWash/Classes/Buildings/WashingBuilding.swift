import Foundation

public class WashingBuilding: Building {
    public var rooms: [AnyObject]
    
    init(rooms: [Premises]) {
        self.rooms = rooms
    }
}
