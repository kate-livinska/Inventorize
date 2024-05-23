//
//  SwiftUIView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 18/01/2024.
//

import SwiftUI
import SwiftData

struct OrdersList: View {
    @Environment(\.modelContext) private var context
    @Query private var orders: [InventoryOrder]
    
    //FIXME: - DB as source of truth for opened orders
    @State private var openedOrders = [Int]()
    
    var body: some View {
        NavigationSplitView {
            ordersList
                .navigationTitle("OrdersListView.Orders.Title".localized)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("OrdersListView.LogoutButton.Title".localized) {
                            Auth.shared.logout()
                        }
                    }
                }
        }
        detail: {
            Text("Select an order")
        }
        .padding()
        .refreshable {
            await DataService.refreshOrders(modelContext: context)
        }
        .overlay {
            if orders.isEmpty {
                ContentUnavailableView("Refrresh to load orders", systemImage: "globe")
            }
        }
    }
    
    var ordersList: some View {
        List(orders) { order in
            NavigationLink {
                OrderDetailsView(order: order)
                    .navigationTitle("\(order.name) \(String(order.id))")
                    .navigationBarTitleDisplayMode(.inline)
                    .task {
                        print("Order tapped")
                        if !order.wasOpened {
                            order.wasOpened.toggle()
                        }
                    }
            } label: {
                OrderView(order)
                    .padding(1)
            }
        }
        .listStyle(.plain)
    }
}
                        
struct OrderView: View {
    let order: InventoryOrder
    
    init(_ order: InventoryOrder) {
        self.order = order
    }
    
    var body: some View {
        HStack {
            Text(String(order.id))
            Text(order.name)
        }
        .font(.system(size: 15))
        .foregroundStyle(order.wasOpened ? .gray : .primaryColor)
        .bold(!order.wasOpened)
    }
}

#Preview {
    OrdersList()
}
