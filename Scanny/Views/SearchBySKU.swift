//
//  SearchBySKU.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 14/06/2024.
//

import SwiftUI
import SwiftData

struct SearchBySKU: View {
    //@Environment(\.modelContext) private var context
    @EnvironmentObject var navigationManager: NavigationManager
    
    @Query private var items: [InventoryItem]
    
    @State private var currentItem: InventoryItem?
    
    init(
        searchText: String,
        orderID: Int
    ) {
        let predicate = #Predicate<InventoryItem> {
            $0.sku.contains(searchText)
            &&
            $0.order.id == orderID
            &&
            !$0.isInventoried
        }
        _items = Query(filter: predicate)
    }
    
    var body: some View {
        VStack {
            Text("Search by SKU")
            List(selection: $currentItem) {
                ForEach(items) { item in
                    if item.quantity == 0 {
                        NavigationLink(value: Destination.editQuantity(item)) {
                            ItemSKU(item)
                        }
                    } else {
                        NavigationLink(value: Destination.boxView(item)) {
                            ItemSKU(item)
                        }
                    }
            }
//                NavigationLink {
//                    if item.quantity == 0 {
//                        EditQuantity(item: item)
//                    } else {
//                        BoxView(item: item)
//                    }
//                } label: {
//                    ItemSKU(item)
//                        .padding(1)
//                }
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
        .environmentObject(NavigationManager())
}
