import Foundation

public protocol CarContainable: AnyObject {
    var cars: Queue<Car?> { get set }
}
