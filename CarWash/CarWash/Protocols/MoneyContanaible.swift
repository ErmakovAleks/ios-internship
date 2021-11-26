import Foundation

public protocol MoneyContainable: AnyObject {
    var money: Double { get set }
    var bankAccount: Double { get set }
    var position: String { get }
    var isSuccess: Bool { get set }
    var message: String { get }
    
    func salaryCoefficient() -> Double
    func action()
}
