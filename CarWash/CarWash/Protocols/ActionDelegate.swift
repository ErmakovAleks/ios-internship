import Foundation

public protocol ActionDelegate: class {
    
    // MARK: -
    // MARK: Public functions
    
    func report(object: MoneyContainable)
    
}
