import Foundation

public class CarWashComplex {
    public var adminBuilding: AdminBuilding
    public var washingBuilding: WashingBuilding
    
    init(adminBuilding: AdminBuilding, washingBuilding: WashingBuilding) {
        self.adminBuilding = adminBuilding
        self.washingBuilding = washingBuilding
    }
}
