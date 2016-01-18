import Foundation
import Parse

class Card : PFObject, PFSubclassing {
    
    @NSManaged var name: String
    @NSManaged var setName: String
    @NSManaged var setNumber: Int
    @NSManaged var rarity: String
    @NSManaged  var type: String
    @NSManaged  var stage: String
    @NSManaged var image: PFFile
    
    static func parseClassName() -> String {
        return "Card"
    }
}

