import Foundation

protocol DeckModelDelegate {
    func decksChanged()
    func authenticationFailed(error: NSError)
}

class DeckModel: SessionCoordinatorDelegate {
    var delegate: DeckModelDelegate?
    private var session: Session?
    private var deckList = [Deck]()

    private var deckQueryRunner: DeckQueryRunner
    private var deckCrudManager: DeckCrudManager
    
    var deckCount: Int {
        get {
            return deckList.count
        }
    }
    
    required init(deckQueryRunner: DeckQueryRunner, deckCrudManager: DeckCrudManager) {
        self.deckQueryRunner = deckQueryRunner
        self.deckCrudManager = deckCrudManager
    }
        
    func createDeckWithTitle(title: String) {
        let deck = deckCrudManager.createDeckForUser(session!.user, name: title)
        self.deckList.append(deck)
        self.delegate?.decksChanged()
    }
    
    func deleteDeckAtIndex(index: Int) {
        let deck = deckList[index]
        deckCrudManager.destroyDeck(deck) { (complete, error) in
            if (complete) {
                self.deckList.removeAtIndex(index)
                self.delegate?.decksChanged()
            }
        }
    }
    
    func deckAtIndex(index: Int) -> Deck {
        return deckList[index]
    }
    
    func reload() {
        deckQueryRunner.allDecksForUser(session!.user) { (decks, error) -> () in
            if let decks = decks {
                print(decks.count)
                self.deckList = decks
                self.delegate?.decksChanged()
            }
        }
    }
    
    // MARK: SessionCoordinatorDelegate
    func authenticatedWithSession(session: Session) {
        self.session = session
        self.reload()
    }
    
    func authenticationFailedWithError(error: NSError) {
        self.delegate?.authenticationFailed(error)
    }
}
