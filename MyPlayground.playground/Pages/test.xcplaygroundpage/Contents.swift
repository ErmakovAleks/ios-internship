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

var randomArray = Array(0..<9)
print(randomArray)
var arraySlice = randomArray[randomArray.count-4...randomArray.count-2]
print(arraySlice)
print(arraySlice[5])
print(randomArray)
var newArray = Array(arraySlice)
print(newArray)

var countryDict = ["RUS": "Russia", "BEL": "Belorussia", "UKR": "Ukraine"]
var testDict: String? = countryDict.updateValue("Estony", forKey: "EST")
print(testDict!
)
print(countryDict)
