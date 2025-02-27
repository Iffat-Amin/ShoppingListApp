
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "ShoppingListApp")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("❌ Core Data error: \(error), \(error.userInfo)")
                fatalError("Unresolved error \(error.localizedDescription)")
            } else {
                print("✅ Core Data successfully loaded.")
            }
        }
    }

    var context: NSManagedObjectContext {
        return container.viewContext
    }

    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("✅ Data saved successfully!")
            } catch {
                let nserror = error as NSError
                print("❌ Error saving Core Data: \(nserror), \(nserror.userInfo)")
                fatalError("Unresolved error \(nserror.localizedDescription)")
            }
        }
    }
}


