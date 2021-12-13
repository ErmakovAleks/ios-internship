import Foundation

public class Cabinet: Room {
    
    // MARK: -
    // MARK: Public variables
    
    public var employees: [Employee]
    public var director: Director
    
    // MARK: -
    // MARK: Initializations
    
    public init(directorName: String, directorGender: Gender) {
        self.director = Director.init(name: directorName, gender: directorGender)
        self.employees = []
    }
    
    public init(director: Director) {
        self.director = director
        self.employees = []
    }
}
