import Foundation

public protocol CarContainable: AnyObject, Collection {
    var cars: [Car] { get set }
}
