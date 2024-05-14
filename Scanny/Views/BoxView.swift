//
//  BoxView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 06/05/2024.
//

import SwiftUI
import SwiftData

struct BoxView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Query private var item: [InventoryItem]
    
    init(scannedCode: String) {
        let predicate = #Predicate<InventoryItem> { item in
            item.sku == scannedCode
        }
        
        _item = Query(filter: predicate)
    }
    
    var body: some View {
        if item.count == 1 {
            if item[0].quantity == 0 {
                Text("Show QuantityEditorView here")
            } else {
                VStack {
                    Text("Box #\(item[0].box)")
                    Text("Qty: \(item[0].quantity)")
                    Spacer()
                    Button("OK".localized) {
                        withAnimation {
                            dismiss()
                        }
                    }
                }
                .padding(25)
            }
        } else if item.count > 1 {
            Text("Show SearchBySKUView here")
        }
    }
}

#Preview {
    BoxView(scannedCode: "VBN09788967655WE")
        .modelContainer(SampleData.shared.modelContainer)
}
