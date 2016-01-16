import UIKit

class DeckVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var deckList = ["fun1", "fun2", "fun3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Actions
    @IBAction func addDeck(sender: AnyObject) {
        let alert = UIAlertController(title: "Enter Deck Name", message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default , handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel , handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("deckCell")!
        //setup cell
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deckList.count
    }
    
    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        deckList.removeAtIndex(indexPath.row)
        tableView.reloadData()
        
    }
    
    
}

