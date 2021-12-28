import Foundation

public class Car {
    
    // MARK: -
    // MARK: Public variables
    
    public var money = Double()
    public var cleanness = Bool()
    
    // MARK: -
    // MARK: Initializations
    
    public init(money: Double, cleanness: Bool) {
        self.money = money
        self.cleanness = cleanness
    }
    
    public init() {
        self.money = Double.random(in: 0...100)
        self.cleanness = Bool.random()
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func pay(payment: Double) -> Double? {
        if payment <= self.money {
            self.money = self.money - payment
            return payment
        } else {
            return nil
        }
    }
}

