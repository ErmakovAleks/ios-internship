//: [Previous](@previous)

import Foundation

mainLoop: for i in 1...5 {
    for y in i...5 {
        if y == 4  && i == 2 {
            break mainLoop
        }
        print("\(i) - \(y)")
    }
}
