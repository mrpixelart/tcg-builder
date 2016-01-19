import Foundation
import UIKit

protocol SessionCoordinatorDelegate {
    func authenticatedWithSession(session: Session)
    func authenticationFailedWithError(error: NSError)
}

struct SessionCoordinator {
    let navigationController: UINavigationController
    let sessionCoordinatorDelegate: SessionCoordinatorDelegate
    var loadingViewController: LoadingViewController
    
    init(navigationController: UINavigationController, sessionCoordinatorDelegate: SessionCoordinatorDelegate) {
        self.navigationController = navigationController
        self.sessionCoordinatorDelegate = sessionCoordinatorDelegate
        self.loadingViewController = LoadingViewController()
    }
    
    func startSession() {
        self.navigationController.presentViewController(self.loadingViewController, animated: false, completion: nil)
        SessionManager.sharedManager.startSession { (session: Session?, error: NSError?) -> () in
            if let session = session {
                self.sessionCoordinatorDelegate.authenticatedWithSession(session)
            } else {
                self.sessionCoordinatorDelegate.authenticationFailedWithError(error!)
            }
            self.loadingViewController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}