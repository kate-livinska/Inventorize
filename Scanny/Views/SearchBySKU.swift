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
            List(items) { item in
                NavigationLink {
                    if item.quantity == 0 {
                        EditQuantity(item: item)
                    } else {
                        BoxView(item: item)
                    }
                } label: {
                    ItemSKU(item)
                        .padding(1)
                }
            }
            .listStyle(.plain)
        }
        
        
        
    }
}

struct ItemSKU: View {
    let item: InventoryItem
    
    init(_ item: InventoryItem) {
        self.item = item
    }
    
    var body: some View {
        HStack {
            Text(item.sku)
            Text(item.eanAsString)
        }
    }
}

#Preview {
    SearchBySKU(searchText: "VBN", orderID: 1)
        .modelContainer(SampleData.shared.modelContainer)
}
