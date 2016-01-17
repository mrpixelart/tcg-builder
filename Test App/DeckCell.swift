import UIKit

class DeckCell: UITableViewCell {
    
    
    @IBOutlet weak var deckName: UILabel!
    @IBOutlet weak var cardCount: UILabel!
    @IBOutlet weak var deckFormat: UILabel!
    
    
    func setCell(name: String) {
        deckName.text = name
    }
    
}