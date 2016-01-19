import Foundation
import XCTest
import Parse
@testable import TCG_Builder

class MockDeckQueryRunner: DeckQueryRunner {
    var decks = [Deck]()
    
    init(decks: [Deck]) {
        self.decks = decks
    }
    
    override func allDecksForUser(user: PFUser, completion: (decks: [Deck]?, error: NSError?) -> ()) {
        completion(decks: decks, error: nil)
    }
}

class MockDeckCrudManager: DeckCrudManager {
    override func createDeckForUser(user: PFUser, name: String) -> Deck {
        let deck = Deck()
        deck.name = name
        return deck
    }
    
    override func destroyDeck(deck: Deck, completion: (complete: Bool, error: NSError?) -> ()) {
        completion(complete: true, error: nil)
    }
}

class DelegateVerifier: DeckModelDelegate {
    var decksChangedCalled = false
    var authenticationFailureError: NSError?
    
    func decksChanged() {
        decksChangedCalled = true
    }
    
    func authenticationFailed(error: NSError) {
        authenticationFailureError = error
    }
}

class DeckModelTests: XCTestCase {
    var testObject: DeckModel = DeckModel(deckQueryRunner: DeckQueryRunner(), deckCrudManager: DeckCrudManager()) // requires initialization
    var mockQueryRunner = MockDeckQueryRunner(decks: [])
    let delegateVerifier = DelegateVerifier()
    
    override func setUp() {
        super.setUp()
        let mockQueryRunner = MockDeckQueryRunner(decks: [])
        let mockSession = Session(user: PFUser())

        testObject = DeckModel(deckQueryRunner: mockQueryRunner, deckCrudManager: MockDeckCrudManager())
        testObject.authenticatedWithSession(mockSession)
        testObject.delegate = delegateVerifier
    }
    
    func resetDelegate() {
        delegateVerifier.decksChangedCalled = false
        delegateVerifier.authenticationFailureError = nil
    }
    
    func testWhenCreateingADeckThenNewDeckAdded() {
        testObject.createDeckWithTitle("Test Title")
        
        XCTAssertTrue(delegateVerifier.decksChangedCalled)
        
        XCTAssertEqual(testObject.deckCount, 1)
        
        let actualDeck = testObject.deckAtIndex(0)
        XCTAssertEqual(actualDeck.name, "Test Title")
    }
    
    func testWhenDestroyingADeckThenDeckDestroyed() {
        testObject.createDeckWithTitle("Test Title 2")
        XCTAssertEqual(testObject.deckCount, 1)
        XCTAssertTrue(delegateVerifier.decksChangedCalled)

        testObject.deleteDeckAtIndex(0)
        XCTAssertEqual(testObject.deckCount, 0)
        
        XCTAssertTrue(delegateVerifier.decksChangedCalled)
    }
    
    func testWhenReloadingADeckThenDelegateNotifiedDecksChanged() {
        testObject.createDeckWithTitle("Test Title 3")
        let actualDeck = testObject.deckAtIndex(0)
        mockQueryRunner.decks = [actualDeck]

        resetDelegate()
        XCTAssertFalse(delegateVerifier.decksChangedCalled)

        testObject.reload()
        
        XCTAssertTrue(delegateVerifier.decksChangedCalled)
    }
    
    func testWhenAuthenticationFailsThenDelegateNotifiedAuthenticationFailed() {
        resetDelegate()
        XCTAssertNil(delegateVerifier.authenticationFailureError)
        
        let error = NSError(domain: "TCG", code: 1, userInfo: nil)
        testObject.authenticationFailedWithError(error)

        XCTAssertEqual(delegateVerifier.authenticationFailureError, error)
    }
}
