import UIKit

class DeckCell: UITableViewCell {
    
    
    @IBOutlet weak var deckName: UILabel!
    @IBOutlet weak var cardCount: UILabel!
    @IBOutlet weak var deckFormat: UILabel!
    
    
    func setCell(deck: Deck) {
        deckName.text = deck.name
        cardCount.text =  String(format: "%d/60", deck.cardCount)
        deckFormat.text = deck.format
        
        if (deck.cardCount == 60) {
            cardCount.textColor = UIColor.greenColor()
        }
        
        if (deck.cardCount > 60) {
            cardCount.textColor = UIColor.redColor()
        }
        
        if (deck.cardCount < 60) {
            cardCount.textColor = UIColor.orangeColor()
        }
    }
    
}