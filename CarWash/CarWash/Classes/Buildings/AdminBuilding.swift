import Foundation

public class AdminBuilding {
    
    // MARK: -
    // MARK: Public variables
    
    public var rooms: [Cabinet]
    public var director: Director
    
    // MARK: -
    // MARK: Initializations

    init(director: Director, rooms: Cabinet...) {
        self.director = director
        self.rooms = rooms
    }
}
