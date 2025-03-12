
import SwiftUI

struct AddItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @State private var name = ""
    @State private var category = "Food"
    @State private var price = ""
    @State private var quantity = ""
    @State private var tax = ""

    let categories = ["Food", "Medication", "Cleaning", "Electronics", "Other"]

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

                Button("Save") {
                    let newItem = ShoppingItem(context: viewContext)
                    newItem.id = UUID()
                    newItem.name = name
                    newItem.category = category
                    newItem.price = Double(price) ?? 0
                    newItem.quantity = Int16(quantity) ?? 1
                    newItem.tax = Double(tax) ?? 0

                    PersistenceController.shared.save()
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(name.isEmpty || price.isEmpty || quantity.isEmpty || tax.isEmpty)
            }
            .navigationTitle("Add Item")
        }
    }
}
