import UIKit
import Foundation
import CoreGraphics
import Darwin

protocol CreatureProtocol {
    func addChild(mother: Creature, children: [Creature])
    func rollcall(mother: Creature)
}

extension String {
    
    static func random(length: Int) -> String {
        let length = length
        
        return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
            .shuffled()
            .dropFirst(length > 40 ? length : 40)
            .reduce(into: "") { $0 += $1.description }
    }
}

class Creature: Equatable {
    
    static func == (lhs: Creature, rhs: Creature) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.age == rhs.age
    }
    
    let id = UUID()
    
    var name: String
    var weight: Double
    var age: Int
    var children = [Creature]()
    
    init(name: String, weight: Double, age: Int, children: [Creature] = []) {
        self.name = name
        self.weight = weight
        self.age = age
        self.children = children
    }
    
    init() {
        self.name = .random(length: .random(in: 0..<52))
        self.weight = .random(in: 1...5)
        self.age = .random(in: 0...100)
        self.children = []
    }
    
    func performGenderOperation() {}

    func sayHello() {
        print("Hello. I have not decided on my gender")
    }
}

class Man: Creature {
    
    override func performGenderOperation() {
        print("I am a man and I can fight!")
    }
    
    override func sayHello() {
        print("Hi, dude, my name is \(self.name)")
    }
}

class Woman: Creature {
    
    var registryOfficeWorker: CreatureProtocol?
    
    override func performGenderOperation() {
        print("I know how to give birth to new children")
        self.registryOfficeWorker?.addChild(mother: self, children: [Creature(), Creature(), Creature()])
    }
    
    override func sayHello() {
        print("Hello, my name is \(self.name)")
        self.registryOfficeWorker?.rollcall(mother: self)
        /*self.children.forEach {
            print("Hello, my name is \($0.name) and I am a child of \(self.name)")
        }*/
    }
}

class ChildRegistrator: CreatureProtocol {
    
    func addChild(mother: Creature, children: [Creature]) {
        for child in children {
            mother.children.append(child)
        }
    }
    
    func rollcall(mother: Creature) {
        print("HelloHelloHello!")
        for child in mother.children {
            print("My name is \(child.name) and I am child of \(mother.name)")
        }
    }
}

var john = Man(name: "John", weight: 100.3, age: 2)

var jane = Woman(name: "Jane", weight: 52.8, age: 25)

var bob = Man(name: "Bob", weight: 5.7, age: 1)

var childRegistrator = ChildRegistrator()

jane.registryOfficeWorker = childRegistrator
jane.performGenderOperation()
jane.sayHello()
print("")

john.sayHello()
john.performGenderOperation()



