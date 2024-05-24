//
//  OrderDetailsView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 13/02/2024.
//

import SwiftUI
import SwiftData

struct OrderDetailsView: View {
    @Environment(\.modelContext) private var context
    
    @Query private var items: [InventoryItem]
    
    init(order: InventoryOrder) {
        let predicate = #Predicate<InventoryItem> { item in
            item.order.id == order.id
        }
        
        _items = Query(filter: predicate, sort: [SortDescriptor(\InventoryItem.isInventoried), SortDescriptor(\InventoryItem.id)])
    }
    
    var body: some View {
        VStack {
            ScannerView()
            Divider()
            List(items) {
                ItemView($0)
            }
            .listStyle(.plain)
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

struct ItemView: View {
    let item: InventoryItem
    
    init(_ item: InventoryItem) {
        self.item = item
    }
    
    var body: some View {
        HStack {
            if item.isInventoried {
                Image(systemName: "checkmark.circle")
            }
            VStack(alignment: .leading) {
                Text("EAN: \(String(item.ean))")
                Text("SKU: \(String(item.sku))")
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Qty: \(String(item.quantity))")
                Text("Box: \(String(item.box))")
                    .fontWeight(.bold)
            }
        }
        .listRowBackground(item.isInventoried ? Color.green : Color.clear)
    }
}

#Preview {
    OrderDetailsView(order: )
        .modelContainer(SampleData.shared.modelContainer)
}
