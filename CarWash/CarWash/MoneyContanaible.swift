import Foundation

public protocol MoneyContainable: AnyObject {
    var money: Int { get set }
    var bankAccount: Double { get set }
    
    func salaryCoefficient() -> Double
}
