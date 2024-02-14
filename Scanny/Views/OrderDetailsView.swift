//
//  OrderDetailsView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 13/02/2024.
//

import SwiftUI

struct OrderDetailsView: View {
    var order: OrdersList<Order>.Card
    @ObservedObject var itemService = DataService()
    
    var body: some View {
        VStack {
            Text(order.content.name)
                .font(.title)
            Text(String(order.content.id))
            List(itemService.fetchedItems) {
                ItemView($0)
            }
        }
        .onAppear {
            itemService.fetchItems(id: order.content.id)
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
                Text("Qty: \(String(item.box))")
            }
        }
    }
}

#Preview {
    OrderDetailsView(order: Scanny.OrdersList<Scanny.Order>.Card(id: 0, content: Scanny.Order(id: 80429, name: "Order f037qVAbOiHCLA")))
}
