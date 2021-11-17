import Foundation


public protocol WomanDelegate {
    
    func registration(mother: Creature, children: [Creature])
    func rollcall(mother: Creature)
}

public class Creature: Equatable {
    
    public static func == (lhs: Creature, rhs: Creature) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.age == rhs.age
    }
    
    let id = UUID()
    
    var name: String
    var weight: Double
    var age: Int
    
    public init(name: String, weight: Double, age: Int) {
        self.name = name
        self.weight = weight
        self.age = age
    }
    
    public init() {
        self.name = .random(length: .random(in: 0..<52))
        self.weight = .random(in: 1...5)
        self.age = .random(in: 0...100)
    }
    
    public func performGenderOperation() {}

    public func sayHello() {
        print("Hello. I have not decided on my gender")
    }
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
