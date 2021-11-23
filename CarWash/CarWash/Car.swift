import Foundation

public class Car {
    
    // MARK: -
    // MARK: Public variables
    
    public var money = Int()
    public var cleanness = Bool()
    
    // MARK: -
    // MARK: Initializations
    
    public init(money: Int, cleanness: Bool) {
        self.money = money
        self.cleanness = cleanness
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func pay(payment: Double) {
        money = Int(Double(self.money) - payment)
    }
}
