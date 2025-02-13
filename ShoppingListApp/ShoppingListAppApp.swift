//
//  ShoppingListAppApp.swift
//  ShoppingListApp
//
//  Created by Iffat Nabila on 2025-02-13.
//

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
