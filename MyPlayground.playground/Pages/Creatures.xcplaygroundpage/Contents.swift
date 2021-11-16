import UIKit
import Foundation
import CoreGraphics
import Darwin

var john = Man(name: "John", weight: 100.3, age: 2)

var jane = Woman(name: "Jane", weight: 52.8, age: 25)

var bob = Man(name: "Bob", weight: 5.7, age: 1)

var stella = Woman(name: "Stella", weight: 56.7, age: 22)

var childRegistrator = ChildRegistrator()

jane.registryOfficeWorker = childRegistrator
jane.performGenderOperation(child: [Creature(), Creature(),Creature(), Creature()])
jane.sayHello()
print("")
print("Jane's children:")
print(childRegistrator.childInfo(mother: jane) ?? "no children")
print("")

stella.registryOfficeWorker = childRegistrator
print("Stella's children:")
print(childRegistrator.childInfo(mother: stella) ?? "no children")
print("")



john.sayHello()
john.performGenderOperation()
