import Foundation

public protocol CarContainable: AnyObject {
    var cars: [Car] { get set }
}
