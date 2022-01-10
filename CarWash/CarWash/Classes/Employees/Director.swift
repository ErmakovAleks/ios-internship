import Foundation

public class Director: Employee {
    
    // MARK: -
    // MARK: Public variables
    
    public var didFinishWork: ((Director) -> ())?
    
    // MARK: -
    // MARK: Public functions
    
    public func action(object: MoneyContainable) {
        self.takeProfit(object: object)
        self.message = "My name is \(self.name), I am a director, "
            + "I have \(self.bankAccount.value) on my bank account"
        sleep(UInt32(Int.random(in: 0...2)))
        self.didFinishWork!(self)
    }
    
    public func takeProfit(object: MoneyContainable) {
        self.bankAccount.lock.lock()
        defer { self.bankAccount.lock.unlock() }
        
        if object.earnings.value > 0 {
            self.bankAccount.value = self.bankAccount.value + object.earnings.value
            object.earnings.value = object.earnings.value - object.earnings.value
        }
    }
}
