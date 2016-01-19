import UIKit
import Parse

class DeckViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DeckModelDelegate {
    private let deckModel = DeckModel(deckQueryRunner: DeckQueryRunner(), deckCrudManager: DeckCrudManager())
    private var sessionCoordinator: SessionCoordinator?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.deckModel.delegate = self
        
        sessionCoordinator = SessionCoordinator(navigationController: self.navigationController!, sessionCoordinatorDelegate: deckModel)
        sessionCoordinator!.startSession()
    }
    
    func decksChanged() {
        self.tableView.reloadData()
    }
    
    func authenticationFailed(error: NSError) {
        let alert = UIAlertController(title: "Error", message: "Failed to authenticate: \(error.localizedDescription)", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Cancel , handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: Actions
    @IBAction func addDeck(sender: AnyObject) {
        let alert = UIAlertController(title: "Enter Deck Name", message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default , handler: { alertAction in
            if let text = alert.textFields?.first?.text{
                self.deckModel.createDeckWithTitle(text)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel , handler: nil))
        alert.addTextFieldWithConfigurationHandler(nil)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DeckCell") as! DeckCell
        cell.setCell(deckModel.deckAtIndex(indexPath.row))
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deckModel.deckCount
    }
    
    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        deckModel.deleteDeckAtIndex(indexPath.row)        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    //MARK: PrepareForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? DeckDetailVC {
            if let row = tableView.indexPathForSelectedRow?.row {
                vc.deck = deckModel.deckAtIndex(row)
                tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: true)
            }
        }
    }
}
