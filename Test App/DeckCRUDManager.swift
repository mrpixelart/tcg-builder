import Foundation
import Parse

class DeckCrudManager {
    func createDeckForUser(user: PFUser, name: String) -> Deck {
        let deck = Deck()
        deck.name = name
        deck.cardCount = 0
        deck.format = "Standard"
        deck.user = user
        deck.saveInBackground()
        return deck
    }
    
    func destroyDeck(deck: Deck, completion: (complete: Bool, error: NSError?) -> ()) {
        deck.deleteInBackgroundWithBlock { (complete, error) in
            completion(complete: complete, error: error)
        }
    }
}