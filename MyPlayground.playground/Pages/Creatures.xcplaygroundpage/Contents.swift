import UIKit
import Foundation
import CoreGraphics
import Darwin

protocol CreatureProtocol {
    func registration(mother: Creature, children: [Creature])
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
    
    init(name: String, weight: Double, age: Int) {
        self.name = name
        self.weight = weight
        self.age = age
    }
    
    init() {
        self.name = .random(length: .random(in: 0..<52))
        self.weight = .random(in: 1...5)
        self.age = .random(in: 0...100)
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
    
    func performGenderOperation(child: [Creature]) {
        print("I know how to give birth to new children")
        self.registryOfficeWorker?.registration(mother: self, children: child)
    }
    
    override func sayHello() {
        print("Hello, my name is \(self.name)")
        self.registryOfficeWorker?.rollcall(mother: self)
    }
}

class ChildRegistrator: CreatureProtocol {
    
    var cardIndex: [String:[String]] = [:]
    
    func registration(mother: Creature, children: [Creature]) {
        var childrenArray: [String] = []
        for child in children {
            childrenArray.append(child.name)
        }
        cardIndex[mother.name] = childrenArray
    }
    
    func rollcall(mother: Creature) {
        if let childrenNames = cardIndex[mother.name] {
            for name in childrenNames {
                print("My name is \(name), I am a child of \(mother.name)")
            }
        }
    }
    
    func childInfo(mother: Creature) -> [String]? {
        return cardIndex[mother.name]
    }
}

var john = Man(name: "John", weight: 100.3, age: 2)

var jane = Woman(name: "Jane", weight: 52.8, age: 25)

var bob = Man(name: "Bob", weight: 5.7, age: 1)

var stella = Woman(name: "Stella", weight: 56.7, age: 22)

var childRegistrator = ChildRegistrator()

jane.registryOfficeWorker = childRegistrator
jane.performGenderOperation(child: [Creature(), Creature(),Creature(), Creature()])
jane.sayHello()
print(childRegistrator.childInfo(mother: jane) ?? "no children")
print("")

stella.registryOfficeWorker = childRegistrator
print(childRegistrator.childInfo(mother: stella) ?? "no children")
print("")



john.sayHello()
john.performGenderOperation()
