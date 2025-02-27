




import Foundation
import CoreData

extension ShoppingItem: Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingItem> {
        return NSFetchRequest<ShoppingItem>(entityName: "ShoppingItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String
    @NSManaged public var category: String
    @NSManaged public var price: Double
    @NSManaged public var quantity: Int16
    @NSManaged public var tax: Double
    
    static func getAllItems() -> NSFetchRequest<ShoppingItem> {
            let request: NSFetchRequest<ShoppingItem> = ShoppingItem.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            return request
        }
}
