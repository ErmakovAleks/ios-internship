import Foundation

var message: (String) -> Void = { print($0) }

message("Random text")

func action() -> (()->Int){
     
    var val = 0
    return {
        val = val+1
        return val
    }
}
let inc = action()
print(inc())
print(inc())
print(inc())
print(inc())
print(inc())
print(inc())
print(inc())
print(inc())
print(inc())


var a = 14
var b = 2
 
let myClosure: (Int, Int) -> Int = { + }
print(myClosure(a, b))
 
a = 5
b = 6
