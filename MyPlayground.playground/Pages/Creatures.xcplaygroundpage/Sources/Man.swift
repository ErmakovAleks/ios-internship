import Foundation

public class Man: Creature {
    
    override public func performGenderOperation() {
        print("I am a man and I can fight!")
    }
    
    override public func sayHello() {
        print("Hi, dude, my name is \(self.name)")
    }
}

extension Man {
    
    public static func random(_ copies: Int) -> [Man] {
        var menArray: [Man] = []
        for _ in 0..<copies {
            menArray.append(Man())
        }
        return menArray
    }
}
