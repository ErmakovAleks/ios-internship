import Foundation

public class Controller {
    
    // MARK: -
    // MARK: Public variables
    
    let view: FeedbackView
    let complex: CarWashComplex
    let adminBuilding: AdminBuilding
    let washingBuilding: WashingBuilding
    var director: Director?
    var accountant: Accountant?
    var washer: Washer?
    
    var accountants: [Accountant]
    var washers: [Washer]
    var cars: [Car]?
    let queue = DispatchQueue(label: "")
    
    // MARK: -
    // MARK: Initializations
    
    init(view: FeedbackView, complex: CarWashComplex) {
        self.view = view
        self.complex = complex
        self.adminBuilding = complex.adminBuilding
        self.washingBuilding = complex.washingBuilding
        self.director = complex.adminBuilding.director
        //self.accountant = complex.adminBuilding.rooms[0].employees.extract() as? Accountant
        //self.washer = complex.washingBuilding.rooms[0].employees.extract() as? Washer
        
        self.accountants = complex.adminBuilding.rooms
            .compactMap { $0.employees.extract() as? Accountant }
        self.washers = complex.washingBuilding.rooms
            .compactMap { $0.employees.extract() as? Washer }
        print(washers.count)
//        self.cars = complex.washingBuilding.rooms
//            .compactMap { $0.cars.extract() }
        
        director?.didFinishWork = { [weak self] worker in
            self?.report(object: worker)
        }
        
        accountant?.didFinishWork = { [weak self] worker in
            self?.report(object: worker)
        }
        
        washer?.didFinishWork = { [weak self] worker in
            self?.report(object: worker)
        }
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func checkQueue() {
        self.cars = complex.washingBuilding.rooms.compactMap { $0.cars.extract() }
        if var cars = cars {
            if !washers.isEmpty && !cars.isEmpty {
                washer = washers.removeFirst()
                washer?.action(car: cars.removeFirst())
                if let washer = washer {
                    washers.append(washer)
                }
            }
        }
//        if let washer = washer, let car = complex.washingBuilding.rooms[0].cars.extract() {
//            washer.action(car: car)
//        }
    }
    
    public func report(object: MoneyContainable) {
        if object is Washer {
            view.show(message: object.message)
            if object.isSuccess {
                accountant?.action(object: object)
            } else {
                object.isSuccess = true
            }
        } else if object is Accountant {
            view.show(message: object.message)
            director?.action(object: object)
        } else if object is Director {
            director.map {
                view.show(message: $0.message)
            }
        }
    }
}
