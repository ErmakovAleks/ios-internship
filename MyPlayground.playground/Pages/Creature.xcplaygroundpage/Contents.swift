import UIKit
import Foundation
import CoreGraphics
import Darwin

enum Gender: String {
        
    case female
    case male
}

extension Gender {
    static func generateGender() -> Gender {
        if Bool.random() {
            return Gender.male
        } else {
            return Gender.female
        }
    }
}

extension String {
    static func generateName(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var name = ""
        for _ in 0 ..< length {
            name.append(letters.randomElement()!)
        }
        return name
    }
}

class Creature: Equatable {
    
    static func == (lhs: Creature, rhs: Creature) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.age == rhs.age
    }
    
    let id = UUID()
    
    var gender: Gender
    var name: String
    var weight: Double
    var age: Int
    var children = [Creature]()
    
    init(gender: Gender, name: String, weight: Double, age: Int, children: [Creature] = []) {
        self.gender = gender
        self.name = name
        self.weight = weight
        self.age = age
        self.children = children
    }
    
    init() {
        self.gender = Gender.generateGender()
        self.name = String.generateName(length: Int.random(in: 0..<8))
        self.weight = Double.random(in: 0...5)
        self.age = Int.random(in: 0...100)
        self.children = []
    }
    
    func sayHello() {
        print("Hello, I am \(name)!")
        
        self.children.forEach {
            print("Hello, my name is \($0.name) and I am a child of \(self.name)")
        }
    }
    
    func isFemale() -> Bool {
        return self.gender == .female
    }
}

func performGenderOperation(creature: Creature) -> Creature? {
    if creature.isFemale() {
        return Creature()
    } else {
        print("I am a man and I can fight!")
        return nil
    }
}

var John = Creature(gender: .male, name: "John", weight: 10.3, age: 2)
var Jack = Creature()
var firstCreature = Creature(gender: .female, name: "Jane", weight: 52.8, age: 25)
firstCreature.sayHello()
print("")
firstCreature.children.append(John)
print("")
firstCreature.sayHello()
firstCreature.children.removeAll { $0 == Jack }
print("")
performGenderOperation(creature: firstCreature)
print("")
firstCreature.children.removeAll { $0 == John}
firstCreature.sayHello()

var Ringo = Creature()
Ringo.sayHello()
print(Ringo.gender)

John.sayHello()
print(John.gender)

print(firstCreature.children)
