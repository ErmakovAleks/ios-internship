import Foundation

public protocol MoneyContainable: AnyObject {
    var money: Double { get set }
    var bankAccount: Double { get set }
    
    func salaryCoefficient() -> Double
}
