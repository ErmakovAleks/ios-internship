import UIKit
import Foundation
import CoreGraphics
import Darwin

var childRegistrator = ChildRegistrator()
let women: [Woman] = Woman.random(5)

women.forEach {
    $0.delegate = childRegistrator
}

let men: [Man] = Man.random(5)
let creatures = women + men

creatures.forEach {
    $0.performGenderOperation()
}


