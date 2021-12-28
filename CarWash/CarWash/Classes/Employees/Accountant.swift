import Foundation

public class Accountant: Employee {
    
    // MARK: -
    // MARK: Public variables
    
    public var didFinishWork: ((Accountant) -> ())?
    
    // MARK: -
    // MARK: Public functions
    
    public func action(object: MoneyContainable) {
        self.distributeEarnings(object: object)
        self.message = "My name is \(self.name), I am an accountant,"
            + " I have \(self.bankAccount.unsafe) on my bank account"
        //sleep(UInt32(Int.random(in: 0...3)))
        self.didFinishWork?(self)
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func distributeEarnings(object: MoneyContainable) {
        let washerCoeff = object.salaryCoefficient()
        object.earnings.lock.lock()
        defer { object.earnings.lock.unlock() }
        
        self.bankAccount.value = self.bankAccount.value + object.earnings.value * self.salaryCoefficient()
        self.earnings.value = object.earnings.value - object.earnings.value * (self.salaryCoefficient() + washerCoeff)
        
        object.bankAccount.value = object.bankAccount.value + object.earnings.value * washerCoeff
        object.earnings.value = object.earnings.value - object.earnings.value
    }
}
