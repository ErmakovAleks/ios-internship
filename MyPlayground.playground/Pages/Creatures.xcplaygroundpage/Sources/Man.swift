import Foundation
import Creature

public class Man: Creature {
    
    override func performGenderOperation() {
        print("I am a man and I can fight!")
    }
    
    override func sayHello() {
        print("Hi, dude, my name is \(self.name)")
    }
}
