import UIKit
import Foundation
import CoreGraphics
import Darwin

protocol RegistrationOfNewbornProtocol {
    func newChild()
}

extension String {
    
    static func random(length: Int) -> String {
        let length = Int.random(in: 0...length)
        
        return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
            .shuffled()
            .dropFirst(length)
            .reduce(into: "") { $0 += $1.description }
    }
}

class Creature: Equatable {
    
    static func == (lhs: Creature, rhs: Creature) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.age == rhs.age
    }
    
    let id = UUID()
    
    //var gender: Gender
    var name: String
    var weight: Double
    var age: Int
    var children = [Creature]()
    
    init(/*gender: Gender,*/ name: String, weight: Double, age: Int, children: [Creature] = []) {
        //self.gender = gender
        self.name = name
        self.weight = weight
        self.age = age
        self.children = children
    }
    
    init() {
        //self.gender = .random()
        self.name = .random(length: .random(in: 1..<8))
        self.weight = .random(in: 1...5)
        self.age = .random(in: 0...100)
        self.children = []
    }
    
    func performGenderOperation() {}

    func sayHello() {
        print("Hello. I have not decided on my gender")
    }
    
    /*func isFemale() -> Bool {
        return self.gender == .female
    }*/
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
    
    var registryOfficeWorker: RegistrationOfNewbornProtocol?
    registryOfficeWorker.newChild(self)
    
    override func performGenderOperation() {
        print("I know how to give birth to new children")
        registryOfficeWorker?.newChild()
    }
    
    override func sayHello() {
        print("Hello, my name is \(self.name)")
        self.children.forEach {
            print("Hello, my name is \($0.name) and I am a child of \(self.name)")
        }
    }
}

class ChildRegistrator: RegistrationOfNewbornProtocol {
    
    func newChild() {
        congratulations()
    }
    
    func congratulations() {
        print("We have a newborn!")
        print("We register it!")
    }
    
    func creation() -> Creature {
        return Creature()
    }
    
    func registration(motherCreature: Creature) {
        let child = Creature()
        motherCreature.children.append(child)
    }
}

var john = Man(name: "John", weight: 100.3, age: 2)

var jane = Woman(name: "Jane", weight: 52.8, age: 25)

var bob = Man(name: "Bob", weight: 5.7, age: 1)

var childRegistrator = ChildRegistrator()

jane.sayHello()
jane.registryOfficeWorker = childRegistrator
jane.performGenderOperation()
print("")

john.sayHello()
john.performGenderOperation()



