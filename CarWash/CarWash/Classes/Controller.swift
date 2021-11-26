import Foundation

public class Controller {
    let view: FeedbackView
    let directorModel: Director
    let accountantModel: Accountant
    let washerModel: Washer
    
    init(view: FeedbackView, directorModel: Director, accountantModel: Accountant, washerModel: Washer) {
            self.view = view
            self.directorModel = directorModel
            self.accountantModel = accountantModel
            self.washerModel = washerModel
        }
}
