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
    var freeAccountants: [Accountant] = []
    var washers: [Washer]
    var freeWashers: [Washer] = []
    var cars: [Car] = []
    let queue = DispatchQueue(label: "", attributes: .concurrent)
    
    // MARK: -
    // MARK: Initializations
    
    init(view: FeedbackView, complex: CarWashComplex) {
        self.view = view
        self.complex = complex
        self.adminBuilding = complex.adminBuilding
        self.washingBuilding = complex.washingBuilding
        self.director = complex.adminBuilding.director
        
        self.accountants = complex.adminBuilding.rooms
            .flatMap { $0.employees }
            .compactMap { $0 as? Accountant }
        
        self.washers = complex.washingBuilding.rooms
            .flatMap { $0.employees }
            .compactMap { $0 as? Washer }
        
        self.cars = complex.washingBuilding.rooms.flatMap { $0.cars }
        
        complex.washingBuilding.rooms.forEach { room in
            room.cars.removeAll()
        }
        
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
        
        self.cars += complex.washingBuilding.rooms.flatMap { $0.cars }
        
        complex.washingBuilding.rooms.forEach { room in
            room.cars.removeAll()
        }
        
        self.freeAccountants = self.accountants.filter { !($0.isBusy) }
        
        self.freeWashers = self.washers.filter { !($0.isBusy) }
        
        self.freeWashers.forEach { washer in
            if !cars.isEmpty {
                washer.isBusy = true
                washer.action(car: cars.removeFirst())
            }
            print(washers[0].isBusy, washers[1].isBusy, washers[2].isBusy)
        }
    }
    
    public func report(object: MoneyContainable) {
        if object is Washer {
            self.view.show(message: object.message)
            if object.isEarned && !accountants.isEmpty {
                self.accountant = self.freeAccountants.removeFirst()
                self.accountant?.isBusy = true
                self.accountant?.action(object: object)
            }
            object.isBusy = false
        } else if object is Accountant {
            self.view.show(message: object.message)
            if object.isEarned {
                self.director?.action(object: object)
            }
            object.isBusy = false
        } else if object is Director {
            self.view.show(message: object.message)
        }
    }
}

