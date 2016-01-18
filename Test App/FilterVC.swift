import UIKit


class FilterVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Actions
 
    @IBAction func filter(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}