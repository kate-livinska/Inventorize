//
//  EditQuantity.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 17/06/2024.
//

import SwiftUI

struct EditQuantity: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var navigationManager: NavigationManager
    
    private var item: InventoryItem
    @State private var newQuantity: Int?
    
    init(item: InventoryItem) {
        self.item = item
    }
    
    var body: some View {
        VStack {
            Form {
                TextField("Enter correct quantity", value: $newQuantity, format: .number)
                    .keyboardType(.decimalPad)
            }
        }
        .navigationTitle("Edit Quantity")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    if let newQuantity {
                        item.quantity = newQuantity
                    }
                    navigationManager.path.append(.boxView(item))
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    navigationManager.path = [.details(item.order)]
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditQuantity(item: SampleData.shared.item)
            .modelContainer(SampleData.shared.modelContainer)
            .environmentObject(NavigationManager())
    }
}
