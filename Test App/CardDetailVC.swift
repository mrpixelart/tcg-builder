import UIKit

class CardDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cardMetaCell")!
        //setup cell
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    //MARK: UITableViewDelegate

    
}

