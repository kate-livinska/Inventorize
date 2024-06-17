//
//  SearchBySKU.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 14/06/2024.
//

import SwiftUI
import SwiftData

struct SearchBySKU: View {
    @Environment(\.modelContext) private var context
    @Query private var items: [InventoryItem]
    
    init(
        searchText: String,
        orderID: Int
    ) {
        let predicate = #Predicate<InventoryItem> {
            $0.sku.contains(searchText)
            &&
            $0.order.id == orderID
        }
        _items = Query(filter: predicate)
    }
    
    var body: some View {
        VStack {
            Text("Search by SKU")
            List(items) {
                ItemView($0)
            }
        }
        
        
    }
}

#Preview {
    SearchBySKU(searchText: "VBN", orderID: 1)
        .modelContainer(SampleData.shared.modelContainer)
}
