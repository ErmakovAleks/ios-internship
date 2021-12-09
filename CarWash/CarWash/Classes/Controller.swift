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
        
        self.accountants = complex.adminBuilding.rooms
            .flatMap { $0.employees.compactMap { $0 as? Accountant } }
        
        self.washers = complex.washingBuilding.rooms
            .flatMap { $0.employees.compactMap { $0 as? Washer } }
        
        director?.didFinishWork = { [weak self] worker in
            self?.report(object: worker)
        }
        
        accountants.forEach { worker in
            worker.didFinishWork = { [weak self] worker in
                self?.report(object: worker)
            }
        }
        
        washers.forEach { worker in
            worker.didFinishWork = { [weak self] worker in
                self?.report(object: worker)
            }
        }
        
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func checkQueue() {
        
        self.cars = []
        
        complex.washingBuilding.rooms.forEach { room in
            cars? += room.cars.compactMap { $0 }
            room.cars.removeAll()
        }
 
        if var cars = cars {
            if !washers.isEmpty && !cars.isEmpty {
                washer = washers.removeFirst()
                let car = cars.removeFirst()
                queue.asyncAfter(deadline: .now() + 1) {
                    self.washer?.action(car: car)
                    if let washer = self.washer {
                        self.washers.append(washer)
                    }
                }
            }
        }
    }
    
    public func report(object: MoneyContainable) {
        if object is Washer {
            view.show(message: object.message)
            if object.isSuccess {
                if !accountants.isEmpty {
                    accountant = accountants.removeFirst()
                    queue.asyncAfter(deadline: .now() + 0.5) {
                        self.accountant?.action(object: object)
                        if let accountant = self.accountant {
                            self.accountants.append(accountant)
                        }
                    }
                }
            } else {
                object.isSuccess = true
            }
        } else if object is Accountant {
            view.show(message: object.message)
            queue.asyncAfter(deadline: .now() + 0.5) {
                self.director?.action(object: object)
            }
        } else if object is Director {
            director.map {
                view.show(message: $0.message)
            }
        }
    }
}
