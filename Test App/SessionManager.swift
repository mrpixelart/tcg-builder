import Foundation
import Parse

class SessionManager {
    static let sharedManager = SessionManager()
    
    var currentSession: Session?
    
    func startSession(completion: (session:Session?, error:NSError?)->()) {
        guard currentSession == nil else { return }
        PFAnonymousUtils.logInWithBlock { [unowned self] (user: PFUser?, error: NSError?) -> Void in
            if (error != nil || user == nil) {
                completion(session: nil, error: error)
            } else {
                self.currentSession = Session(user: user!)
                completion(session: self.currentSession, error: nil)
            }
        }
    }
}
