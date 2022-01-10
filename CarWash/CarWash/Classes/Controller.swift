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
    
    let accountants: [Accountant]
    let washers: [Washer]
    var cars: ThreadSafeArray<Car> = ThreadSafeArray()
    let queue = DispatchQueue(label: "com.car-wash.controller-queue", attributes: .concurrent)
    let lock = NSRecursiveLock()
    
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
        
        complex.washingBuilding.rooms.forEach { room in
            while !room.cars.isEmpty {
                if let car = room.cars.extract() {
                    self.cars.append(car)
                }
            }
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
        
        self.complex.washingBuilding.rooms.forEach { room in
            var tempCarArray = [Car]()
            
            while !room.cars.isEmpty {
                if let car = room.cars.extract() {
                    tempCarArray.append(car)
                }
            }
            cars.append(contentsOf: tempCarArray)
        }
        
        self.queue.async {
            for washer in self.washers {
                washer.isBusy.modify {
                    if !$0 {
                        if let car = self.cars.removeFirst() {
                            $0 = true
                            washer.action(car: car)
                        }
                    }
                }
            }
        }
    }
    
    public func report(object: MoneyContainable) {
        queue.async {
            self.view.show(message: object.message)
            switch object {
            case is Washer:
                if object.earnings.value > 0 {
                    var inLoop = true
                    while(inLoop) {
                        for accountant in self.accountants {
                            accountant.isBusy.modify {
                                if !$0 {
                                    $0 = true
                                    accountant.action(object: object)
                                    object.isBusy.value = false
                                    inLoop = false
                                }
                            }
                        }
                    }
                }
                break
            case is Accountant:
                if object.earnings.value > 0 {
                    self.director?.isBusy.modify {
                        if !$0 {
                            self.director?.action(object: object)
                            object.isBusy.value = false
                        }
                    }
                }
                break
            default:
                break
            }
        }
    }
}

