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
    @Query(sort: \InventoryOrder.id) private var orders: [InventoryOrder]
    
    var body: some View {
        NavigationSplitView {
            VStack {
                ordersList
                    .navigationTitle("OrdersListView.Orders.Title".localized)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("OrdersListView.LogoutButton.Title".localized) {
                                Auth.shared.logout()
                            }
                        }
                    }
                Button(action: {
                    do {
                        try context.delete(model: InventoryOrder.self)
                        try context.delete(model: InventoryItem.self)
                    } catch {
                        print("Failed to delete.")
                    }
                }, label: {
                    Text("Delete Data")
                })
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
                ContentUnavailableView("Refresh to load orders", systemImage: "globe")
            }
        }
    }
    
    var ordersList: some View {
        List(orders) { order in
            NavigationLink {
                OrderDetailsView(order: order)
                    .navigationTitle("\(order.name) \(String(order.id))")
                    .navigationBarTitleDisplayMode(.inline)
//                    .task {
//                        if !order.wasOpened {
//                            print("Order tapped")
//                            order.wasOpened = true
//                            context.insert(order)
//                            do {
//                                try context.save()
//                            } catch {
//                                print("Sample data context failed to save.")
//                            }
//                            await DataService.saveItems(modelContext: context, order: order)
//                        }
//                    }
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
    NavigationStack {
        OrdersList()
            .modelContainer(SampleData.shared.modelContainer)
    }
}
