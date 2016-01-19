import UIKit
import Parse

class DeckViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SessionCoordinatorDelegate {
    
    var deckList = [Deck]()
    var sessionCoordinator: SessionCoordinator?
    var session: Session?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sessionCoordinator = SessionCoordinator(navigationController: self.navigationController!, sessionCoordinatorDelegate: self)
        sessionCoordinator!.startSession()
    }
    
    func authenticatedWithSession(session: Session) {
        self.session = session
        self.reload()
    }
    
    func authenticationFailedWithError(error: NSError) {
        let alert = UIAlertController(title: "Error", message: "Failed to authenticate: \(error.localizedDescription)", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Cancel , handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: Actions
    @IBAction func addDeck(sender: AnyObject) {
        let alert = UIAlertController(title: "Enter Deck Name", message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default , handler: { alertAction in
            if let text = alert.textFields?.first?.text{
                let deck = Deck()
                deck.name = text
                deck.cardCount = 0
                deck.format = "Standard"
                deck.user = self.session!.user
                deck.saveInBackground()
                self.reload()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel , handler: nil))
        alert.addTextFieldWithConfigurationHandler { textField in
            
        }
        presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("deckCell") as! DeckCell
        //setup cell
        cell.setCell(deckList[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deckList.count
    }
    
    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let deck = deckList[indexPath.row]
        deck.deleteInBackgroundWithBlock { (complete, error) in
            if (complete) {
                self.deckList.removeAtIndex(indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    //MARK: PrepareForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? DeckDetailVC {
            if let row = tableView.indexPathForSelectedRow?.row {
                vc.deck = deckList[row]
                tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: true)
            }
        }
    }
    
    //MARK: Helpers
    func reload() {
        let query = Deck.query()
        query?.whereKey("user", equalTo: session!.user)
        
        query?.findObjectsInBackgroundWithBlock({ (decks, error) in
            if let decks = decks as? [Deck] {
                print(decks.count)
                self.deckList = decks
                self.tableView.reloadData()
            }
        })
    }
}

