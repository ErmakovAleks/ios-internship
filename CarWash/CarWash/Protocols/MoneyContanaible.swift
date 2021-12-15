import Foundation

public protocol MoneyContainable: AnyObject {
    
    // MARK: -
    // MARK: Public variables
    
    var money: Double { get set }
    var bankAccount: Double { get set }
    var position: String { get }
    var isBusy: Bool { get set }
    var message: String { get }
    var serviceCost: Double { get }
    var isEarned: Bool{ get set }
    
    // MARK: -
    // MARK: Public functions
    
    func salaryCoefficient() -> Double
    func action()
}
