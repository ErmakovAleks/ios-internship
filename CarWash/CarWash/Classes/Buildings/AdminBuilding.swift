import Foundation

public class AdminBuilding {
    
    // MARK: -
    // MARK: Public variables
    
    public var rooms: [Cabinet]
    public var director: Director?
    
    // MARK: -
    // MARK: Initializations

    init(rooms: [Cabinet]) {
        self.rooms = rooms
        if !rooms.isEmpty {
            self.director = rooms[0].director
        }
    }
}
