import Foundation
import Parse

class Deck: PFObject, PFSubclassing  {
    
    @NSManaged var name: String
    @NSManaged var cardCount: Int
    @NSManaged var format: String
    @NSManaged var user: PFUser
    
    static func parseClassName() -> String {
        return "Deck"
    }
    
}
