import UIKit
import Foundation
import CoreGraphics
import Darwin

var childRegistrator = ChildRegistrator()
let women = Creature.random(count: 5, fabric: Woman.init)

women.forEach {
    $0.delegate = childRegistrator
}

let men = Creature.random(count: 5, fabric: Man.init)
let creatures = women + men

creatures.forEach {
    $0.performGenderOperation()
}
