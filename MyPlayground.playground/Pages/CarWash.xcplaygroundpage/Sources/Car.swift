import Foundation

public class Car {
    
    public var money = Double()
    
    public var cleanness = Bool()
    
    public init(money: Double, cleanness: Bool) {
        self.money = money
        self.cleanness = cleanness
    }
    
    public func getMoneyInfo() -> Double { money }
    
    public func pay(payment: Double) { money = self.money - payment }
    
    public func getCleannessInfo() -> Bool { cleanness }
    
    public func setCleanness(clean: Bool) { self.cleanness = clean }
}
