
import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: ShoppingItem.getAllItems()) private var shoppingItems: FetchedResults<ShoppingItem>

    @State private var showAddItemView = false
    @State private var searchText = "" // Search text state

    // Filtered items based on search input
    var filteredItems: [ShoppingItem] {
        if searchText.isEmpty {
            return Array(shoppingItems) // Show all items if search is empty
        } else {
            return shoppingItems.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // If shopping list is empty, show a message
                if filteredItems.isEmpty {
                    Text("No items found.")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(filteredItems) { item in
                            NavigationLink(destination: EditItemView(item: item)) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                        Text("Category: \(item.category)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Text("$\(item.price * Double(item.quantity), specifier: "%.2f")")
                                }
                            }
                        }
                        .onDelete(perform: deleteItem) // Swipe to delete
                    }
                }

                // Total Cost Calculation
                Text("Total: $\(calculateTotal(), specifier: "%.2f")")
                    .font(.title)
                    .padding()

                // Add Item Button
                Button("Add Item") {
                    showAddItemView = true
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("Shopping List")
            .searchable(text: $searchText, prompt: "Search items...") // Search Bar Added
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddItemView) {
                AddItemView()
            }
        }
    }

    // Function to delete an item
    private func deleteItem(offsets: IndexSet) {
        for index in offsets {
            let item = shoppingItems[index]
            viewContext.delete(item)
        }
        PersistenceController.shared.save()
    }

    // Function to calculate total cost with tax
    private func calculateTotal() -> Double {
        return shoppingItems.reduce(0) { $0 + ($1.price * Double($1.quantity) * (1 + $1.tax / 100)) }
    }
}



