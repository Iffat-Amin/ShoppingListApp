//Iffat Amin Nabila- 101429832
//Camile Lee - 100974597

import SwiftUI

@main
struct ShoppingListAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
