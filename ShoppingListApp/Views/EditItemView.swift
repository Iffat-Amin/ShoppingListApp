import SwiftUI

struct EditItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String
    @State private var category: String
    @State private var price: String
    @State private var quantity: String
    @State private var tax: String

    let categories = ["Food", "Medication", "Cleaning", "Electronics", "Other"]
    var item: ShoppingItem

    init(item: ShoppingItem) {
        _name = State(initialValue: item.name)
        _category = State(initialValue: item.category)
        _price = State(initialValue: "\(item.price)")
        _quantity = State(initialValue: "\(item.quantity)")
        _tax = State(initialValue: "\(item.tax)")
        self.item = item
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Item Name", text: $name)
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Price", text: $price).keyboardType(.decimalPad)
                TextField("Quantity", text: $quantity).keyboardType(.numberPad)
                TextField("Tax %", text: $tax).keyboardType(.decimalPad)

                Button("Save Changes") {
                    updateItem()
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(name.isEmpty || price.isEmpty || quantity.isEmpty || tax.isEmpty)
            }
            .navigationTitle("Edit Item")
        }
    }

    // Function to update item details
    private func updateItem() {
        item.name = name
        item.category = category
        item.price = Double(price) ?? item.price
        item.quantity = Int16(quantity) ?? item.quantity
        item.tax = Double(tax) ?? item.tax

        PersistenceController.shared.save()
    }
}
