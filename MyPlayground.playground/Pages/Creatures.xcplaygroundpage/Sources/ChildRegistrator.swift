import Foundation

public class ChildRegistrator: CreatureProtocol {
    
    var cardIndex: [String:[String]] = [:]
    
    public init() {}
    
    public func registration(mother: Creature, children: [Creature]) {
        var childrenArray: [String] = []
        for child in children {
            childrenArray.append(child.name)
        }
        cardIndex[mother.name] = childrenArray
    }
    
    public func rollcall(mother: Creature) {
        if let childrenNames = cardIndex[mother.name] {
            for name in childrenNames {
                print("My name is \(name), I am a child of \(mother.name)")
            }
        }
    }
    
    public func childInfo(mother: Creature) -> [String]? {
        return cardIndex[mother.name]
    }
}
