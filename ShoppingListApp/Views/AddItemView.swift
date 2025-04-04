
//Iffat Amin Nabila- 101429832
//Camile Lee - 100974597
//Edited by Iffat


import SwiftUI

struct AddItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    // State variables for user input
    @State private var name = ""
    @State private var category = ""
    let categorySuggestions = ["Food", "Medication", "Cleaning", "Electronics", "Other"]

    @State private var price = ""
    @State private var quantity = ""
    @State private var tax = ""

    let categories = ["Food", "Medication", "Cleaning", "Electronics", "Other"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Item Name", text: $name)
                TextField("Category", text: $category)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.words)
                    .onSubmit {
                        // Optional: validate category if needed
                    }
                    .overlay(
                        VStack(alignment: .leading) {
                            if !category.isEmpty {
                                ForEach(categorySuggestions.filter {
                                    $0.localizedCaseInsensitiveContains(category)
                                }, id: \.self) { suggestion in
                                    Button(action: {
                                        category = suggestion
                                    }) {
                                        Text(suggestion)
                                            .padding(.horizontal)
                                            .padding(.vertical, 4)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .background(Color(.systemGray6))
                                    }
                                }
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                        .padding(.top, 40),
                        alignment: .topLeading
                    )

                TextField("Price", text: $price).keyboardType(.decimalPad)
                TextField("Quantity", text: $quantity).keyboardType(.numberPad)
                TextField("Tax %", text: $tax).keyboardType(.decimalPad)

                Button("Save") {
                    // Save button to create and store the new item

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
                // Disable the Save button if any required field is empty
                .disabled(name.isEmpty || price.isEmpty || quantity.isEmpty || tax.isEmpty)
            }
            .navigationTitle("Add Item")
        }
    }
}
