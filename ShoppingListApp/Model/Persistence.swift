//Iffat Amin Nabila- 101429832
//Camile Lee - 100974597

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        //Edited by Camila
        // Initialize the Core Data stack with the data model named "ShoppingListApp"
        container = NSPersistentContainer(name: "ShoppingListApp")
        // Load the persistent stores and handle any loading errors
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                // Log and crash the app if the persistent store fails to load
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

    //Edited by Iffat
    func save() {
        let context = container.viewContext
        if context.hasChanges {
            // Check if there are unsaved changes before attempting to save
            do {
                try context.save()
                print("✅ Data saved successfully!")
            } catch {
                let nserror = error as NSError
                // Log and crash the app if saving fails
                print("❌ Error saving Core Data: \(nserror), \(nserror.userInfo)")
                fatalError("Unresolved error \(nserror.localizedDescription)")
            }
        }
    }
}


