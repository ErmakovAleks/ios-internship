import Foundation

public class Man: Creature {
    
    override public func performGenderOperation() {
        print("I am a man and I can fight!")
    }
    
    override public func sayHello() {
        print("Hi, dude, my name is \(self.name)")
    }
}
