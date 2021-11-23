import Foundation

public class Building {
    
    // MARK: -
    // MARK: Public variables
    
    public var rooms: [Room]
    
    // MARK: -
    // MARK: Initializations
    
    init(rooms: [Room]) {
        self.rooms = rooms
    }
}
