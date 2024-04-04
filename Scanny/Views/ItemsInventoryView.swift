//
//  ItemsInventoryView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 16/03/2024.
//

import SwiftUI

struct ItemsInventoryView: View {
    var items: [Item]
    //@ObservedObject var inventory = ItemsInventory()
    
    var body: some View {
        List(items) {
            ItemView($0)
        }
    }
}

struct ItemView: View {
    let item: Item
    
    init(_ item: Item) {
        self.item = item
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("EAN: \(item.ean)")
                Text("SKU: \(item.sku)")
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Qty: \(String(item.quantity))")
            }
            Text("Box: \(String(item.box))")
                .fontWeight(.bold)
        }
        .listRowBackground(item.inventoried ? Color.mint : Color.clear)
    }
}

#Preview {
    ItemsInventoryView(items: [Item]())
}
