import Foundation
import Creature

public class Woman: Creature {
    
    var registryOfficeWorker: CreatureProtocol?
    
    func performGenderOperation(child: [Creature]) {
        print("I know how to give birth to new children")
        self.registryOfficeWorker?.registration(mother: self, children: child)
    }
    
    override func sayHello() {
        print("Hello, my name is \(self.name)")
        self.registryOfficeWorker?.rollcall(mother: self)
    }
}
