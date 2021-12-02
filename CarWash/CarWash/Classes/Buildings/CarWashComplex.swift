import Foundation

public class CarWashComplex {
    
    // MARK: -
    // MARK: Public variables
    
    public var adminBuilding: AdminBuilding
    public var washingBuilding: WashingBuilding
    
    // MARK: -
    // MARK: Initializations
    
    init(adminBuilding: AdminBuilding, washingBuilding: WashingBuilding) {
        self.adminBuilding = adminBuilding
        self.washingBuilding = washingBuilding
    }
}
