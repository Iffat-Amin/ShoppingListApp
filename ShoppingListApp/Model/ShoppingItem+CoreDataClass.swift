

import Foundation
import CoreData

@objc(ShoppingItem)
public class ShoppingItem: NSManagedObject {
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID() // Ensures a unique ID is assigned when a new object is created
    }
}

