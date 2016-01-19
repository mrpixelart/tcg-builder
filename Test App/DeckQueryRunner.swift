import Foundation
import Parse

class DeckQueryRunner {
    func allDecksForUser(user: PFUser, completion: (decks: [Deck]?, error: NSError?) -> ()) {
        let query = Deck.query()
        query?.whereKey("user", equalTo: user)
        query?.findObjectsInBackgroundWithBlock({ (decks, error) -> Void in
            completion(decks: decks as? [Deck], error: error)
        })
    }
}
