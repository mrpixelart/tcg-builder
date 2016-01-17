import UIKit

class DeckDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var deck = Deck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = deck.name
    }
    
    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cardDetailCell") as! CardDetailCell
        cell.setCell("pickachoo")
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    //MARK: UITableViewDelegate
    
}

