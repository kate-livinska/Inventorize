//
//  OrderDetailsView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 13/02/2024.
//

import SwiftUI
import SwiftData

struct OrderDetailsView: View {
    @Environment(\.modelContext) private var context //temp for Delete Data button
    
    var body: some View {
        VStack {
            ScannerView()
            ItemsInventoryView()
            //Temporary test button to delete all persistent data
            Button(action: {
                do {
                    try context.delete(model: InventoryItem.self)
                } catch {
                    print("Failed to delete.")
                }
            }, label: {
                Text("Delete Data")
            })
        }
    }
}

#Preview {
    OrderDetailsView()
}
