import Foundation

public protocol CarContainable: AnyObject {
    
    // MARK: -
    // MARK: Public variables
    
    var cars: Queue<Car?> { get set }
}
