//
//  OrderDetailsView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 13/02/2024.
//

import SwiftUI

struct OrderDetailsView: View {
    var order: Order
    @ObservedObject var itemService = DataService()
    
    var body: some View {
        VStack {
            Text(order.name)
                .font(.title)
            Text(String(order.id))
            List(itemService.fetchedItems) {
                ItemView($0)
            }
        }
        .onAppear {
            itemService.fetchItems(id: order.id)
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
            VStack {
                Text("EAN: \(item.ean)")
                Text("SKU: \(item.sku)")
            }
            VStack {
                Text("Qty: \(String(item.quantity))")
                Text("Box: \(String(item.box))")
            }
        }
    }
}

#Preview {
    OrderDetailsView(order: Scanny.Order(id: 80429, name: "Order f037qVAbOiHCLA"))
}
