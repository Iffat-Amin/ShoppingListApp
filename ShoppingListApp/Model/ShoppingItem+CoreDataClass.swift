//Iffat Amin Nabila- 101429832
//Camile Lee - 100974597
//Edited by Iffat

// Core Data entity class for ShoppingItem
import Foundation
import CoreData

@objc(ShoppingItem)
public class ShoppingItem: NSManagedObject {
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        self.id = UUID() // Ensures a unique ID is assigned when a new object is created
    }
}

