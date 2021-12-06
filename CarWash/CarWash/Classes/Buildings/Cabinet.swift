import Foundation

public class Cabinet: Room {
    
    // MARK: -
    // MARK: Public variables
    
    public var employees: Queue<Employee>
    public var director: Director!
    
    // MARK: -
    // MARK: Initializations
    
    public init(directorName: String, directorGender: Gender) {
        self.director?.name = directorName
        self.director?.gender = directorGender
        self.employees = Queue()
    }
    
    public init(director: Director) {
        self.director = director
        self.employees = Queue()
    }
}
