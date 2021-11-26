import Foundation

public protocol ActionDelegate: class {
    func report(object: MoneyContainable)
}
