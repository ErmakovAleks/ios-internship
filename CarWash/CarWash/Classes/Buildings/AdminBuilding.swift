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
        self.rooms = (rooms)
    }
    
    public init(directorName: String, directorGender: Gender, rooms: Cabinet...) {
        self.director = Director.init(name: directorName, gender: directorGender)
        self.rooms = (rooms)
    }
}
