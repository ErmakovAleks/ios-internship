import Foundation

public class Woman: Creature {
    
    public var registryOfficeWorker: CreatureProtocol?
    
    public func performGenderOperation(child: [Creature]) {
        print("I know how to give birth to new children")
        self.registryOfficeWorker?.registration(mother: self, children: child)
    }
    
    override public func sayHello() {
        print("Hello, my name is \(self.name)")
        self.registryOfficeWorker?.rollcall(mother: self)
    }
}
