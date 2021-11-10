//: [Previous](@previous)

import Foundation

enum Person{
     
    case Human(String, Int)
    case Elf(String)
    case Gnome
}

var hero = Person.Human("Trogvar", 5)
hero = Person.Elf("Feonor")

switch(hero){
    case .Human:
        print("Вы играете человеком")
    case .Elf:
        print("Вы играете эльфом")
    case .Gnome:
        print("Вы играете гномом")
}


enum DayOfWeek: Int{
     
    case Monday=1, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
}
 
if let day = DayOfWeek(rawValue: 7){
     
    print(day)
}
