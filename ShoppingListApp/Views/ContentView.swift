
import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: ShoppingItem.getAllItems()) private var shoppingItems: FetchedResults<ShoppingItem>

    @State private var showAddItemView = false

    var body: some View {
        NavigationView {
            VStack {
                // If shopping list is empty, show a message
                if shoppingItems.isEmpty {
                    Text("No items found. Try adding some!")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(shoppingItems) { item in
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



