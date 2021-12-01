import Foundation

public class AdminBuilding: Building {
    public var rooms: [Room]
    public var director: Director?

    init(rooms: [Cabinet]) {
        self.rooms = rooms
        if !rooms.isEmpty {
            self.director = rooms[0].director
        }
    }
}
