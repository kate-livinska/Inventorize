//
//  OrderDetailsView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 13/02/2024.
//

import SwiftUI

struct OrderDetailsView: View {
    @ObservedObject var itemService = DataService()
    var order: Order
    
    var body: some View {
        VStack {
            HStack {
                Text(order.name)
                Text(String(order.id))
            }
            .font(.subheadline)
            .fontWeight(.bold)
            List(itemService.fetchedItems) {
                ItemView($0)
            }
        }
        .onAppear {
            itemService.fetchItems(id: order.id)
            print("openedOrders: \(OrderState.shared.openedOrders)")
            if !OrderState.shared.openedOrders.contains(order.id) {
                OrderState.shared.openedOrders.append(order.id)
            }
            print("openedOrders: \(OrderState.shared.openedOrders)")
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
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        }
        .background(item.inventoried ? Color.mint : Color.clear)
        
    }
}

#Preview {
    OrderDetailsView(order: Scanny.Order(id: 80429, name: "Order f037qVAbOiHCLA"))
}
