import Foundation

let wallet = [100, 200, 500, 1000, 100, 50, 10, 50, 200, 20, 1000, 500, 200, 500]

func handle(wallet: [Int], closure: (Int) -> Bool) -> [Int] {
    var returnWallet = [Int]()
    for banknote in wallet {
        if closure(banknote) {
            returnWallet.append(banknote)
        }
    }
    return returnWallet
}

func compare100(banknote: Int) -> Bool {
    return banknote == 100
}

func compareMore1000(banknote: Int) -> Bool {
    return banknote >= 1000
}

let resultWalletOne = handle(wallet: wallet, closure: compare100)
let resultWalletTwo = handle(wallet: wallet, closure: compareMore1000)

print(resultWalletOne)
print(resultWalletTwo)

print(handle(wallet: wallet, closure: {(banknote: Int) -> Bool in
        return banknote >= 1000}))


class PracticeClass {
    var favoriteFood: String
    var numberfOfSkateboards: Int
    var hasBrokenBone: Bool
    
    init() {
        favoriteFood = String()
        numberfOfSkateboards = Int()
        hasBrokenBone = Bool()
    }
}

var sampleInstance = PracticeClass()
print(sampleInstance.favoriteFood)
print(sampleInstance.numberfOfSkateboards)
print(sampleInstance.hasBrokenBone)

var x = sampleInstance.numberfOfSkateboards + 15
print(x)


let array = [122, 17, 34, 95, 81, 128, 37, 177, 69, 19, 56]
var sortedArray = array.sorted(by: {$0 < $1})
print(sortedArray)
