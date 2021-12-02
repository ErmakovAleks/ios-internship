import Foundation

public protocol MoneyContainable: AnyObject {
    
    // MARK: -
    // MARK: Public variables
    
    var money: Double { get set }
    var bankAccount: Double { get set }
    var position: String { get }
    var isSuccess: Bool { get set }
    var message: String { get }
    
    // MARK: -
    // MARK: Public functions
    
    func salaryCoefficient() -> Double
    func action()
}
