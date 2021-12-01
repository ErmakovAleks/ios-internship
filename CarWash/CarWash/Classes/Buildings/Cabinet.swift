import Foundation

public class Cabinet: Room {
    
    // MARK: -
    // MARK: Public variables
    
    public var director: Director
    public var accountant: Accountant
    
    // MARK: -
    // MARK: Initializations
    
    public override init(humanCapacity: Int = 4) {
        self.director = employees.extract() as! Director
        self.accountant = employees.extract() as! Accountant
        
        super.init(humanCapacity: humanCapacity)
    }
}
