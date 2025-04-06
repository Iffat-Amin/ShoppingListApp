// Iffat Amin Nabila- 101429832
// Camile Lee - 100974597

import SwiftUI

struct SettingsView: View {
    @State private var taxRate: String = ""

    var body: some View {
        Form {
            Section(header: Text("Default Tax Rate (%)")) {
                TextField("Enter tax rate", text: $taxRate)
                    .keyboardType(.decimalPad)
            }
        }
        .navigationTitle("Settings")
    }
}
