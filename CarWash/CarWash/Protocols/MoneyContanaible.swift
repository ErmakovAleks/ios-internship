import Foundation

public protocol MoneyContainable: AnyObject {
    
    // MARK: -
    // MARK: Public variables
    
    var earnings: Atomic<Double> { get set }
    var bankAccount: Atomic<Double> { get set }
    var isBusy: Atomic<Bool> { get set }
    var message: String { get }
    var serviceCost: Double { get }
    
    // MARK: -
    // MARK: Public functions
    
    func salaryCoefficient() -> Double
    func action()
}
