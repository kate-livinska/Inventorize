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
            if itemService.isLoading {
                VStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(5)
                    Spacer()
                }
            } else {
                VStack {
                    ScannerView()
                    ItemsInventoryView(items: itemService.fetchedItems)
                }
                .refreshable {
                    itemService.fetchItems(id: order.id)
                }
            }
        }
        .onAppear {
            itemService.fetchItems(id: order.id)
            if !OrderState.shared.openedOrders.contains(order.id) {
                OrderState.shared.openedOrders.append(order.id)
            }
            print("openedOrders: \(OrderState.shared.openedOrders)")
        }
    }
}



#Preview {
    OrderDetailsView(itemService: DataService(), order: Scanny.Order(id: 80429, name: "Order f037qVAbOiHCLA"))
}
