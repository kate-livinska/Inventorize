//
//  ItemsInventoryView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 16/03/2024.
//

import SwiftUI
import SwiftData

struct ItemsInventoryView: View {
    //var items: [Item]
    //@ObservedObject var inventory = ItemsInventory()
    //@Environment(\.modelContext) private var context
    @Query(sort: \InventoryItem.id) private var items: [InventoryItem]
    
    var body: some View {
        List(items) {
            ItemView($0)
        }
        .listStyle(.plain)
    }
}

struct ItemView: View {
    let item: InventoryItem
    
    init(_ item: InventoryItem) {
        self.item = item
    }
    
    var body: some View {
        HStack {
            if item.inventoried {
                Image(systemName: "checkmark.circle")
            } else {
                Image(systemName: "circle")
            }
            VStack(alignment: .leading) {
                Text("EAN: \(item.ean)")
                Text("SKU: \(item.sku)")
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Qty: \(String(item.quantity))")
                Text("Box: \(String(item.box))")
                    .fontWeight(.bold)
            }
        }
        .listRowBackground(item.inventoried ? Color.green : Color.clear)
    }
}

#Preview {
    ItemsInventoryView()
        .modelContainer(SampleData.shared.modelContainer)
}
