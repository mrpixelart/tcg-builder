import Foundation
import Parse

class Session {
    let user: PFUser
    
    init(user: PFUser) {
        self.user = user
    }
}
