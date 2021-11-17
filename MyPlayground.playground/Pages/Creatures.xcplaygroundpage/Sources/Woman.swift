import Foundation

public class Woman: Creature {
    
    public var delegate: WomanDelegate?
    
    override public func performGenderOperation() {
        print("I know how to give birth to new children")
        let childs = [Creature()]
        self.delegate?.registration(mother: self, children: childs)
    }
    
    override public func sayHello() {
        print("Hello, my name is \(self.name)")
        self.delegate?.rollcall(mother: self)
    }
}

/*extension Woman {
    
    public static func random(_ copies: Int) -> [Woman] {
         return (0..<copies).map{ _ in Woman()}
    }
}*/
