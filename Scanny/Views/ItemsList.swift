//
//  ItemsList.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 21/06/2024.
//

import SwiftUI
import SwiftData

struct ItemsList: View {
    var items: [InventoryItem]
    
    init(_ items: [InventoryItem]) {
        self.items = items
    }
    
    var body: some View {
        if items.count == 0 {
            Text("No items")
        }
        List(items) {
            ItemView($0)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(RoundedRectangle(cornerRadius: 15)
            .foregroundStyle(.linearGradient(colors: [.teal.opacity(0.15), .white], startPoint: .top, endPoint: .bottom)))
        //make the items list not refreshable
        .environment(\EnvironmentValues.refresh as! WritableKeyPath<EnvironmentValues, RefreshAction?>, nil)
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
                Text("\(String(item.id)) EAN: \(item.eanAsString)")
                Text("SKU: \(String(item.sku))")
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Qty: \(String(item.quantity))")
                Text("Box: \(String(item.box))")
                    .fontWeight(.bold)
            }
        }
        .listRowBackground(RoundedRectangle(cornerRadius: 4)
            .background(.clear)
            .foregroundColor(item.isInventoried ? Color.green.opacity(0.4) : Color.clear))
    }
}

#Preview {
    NavigationStack {
        ItemsList(SampleData.shared.order.orderItems)
            .modelContainer(SampleData.shared.modelContainer)
    }
}
