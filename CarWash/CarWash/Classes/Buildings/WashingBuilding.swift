import Foundation

public class WashingBuilding {
    
    // MARK: -
    // MARK: Public variables
    
    public var rooms: [Premises]
    
    // MARK: -
    // MARK: Initializations
    
    init(rooms: [Premises]) {
        self.rooms = rooms
    }
}
