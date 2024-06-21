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
    @State private var path = [String]()
    
    @Query(sort: \InventoryOrder.id) private var orders: [InventoryOrder]
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                List(orders) { order in
                    NavigationLink(value: String(order.id)) {
                        OrderView(order)
                            .padding(1)
                    }
                }
                .listStyle(.plain)
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
            .navigationTitle("OrdersListView.Orders.Title".localized)
            .navigationDestination(for: String.self) { id in
                if let intID = Int(id), let order = orders.first(where: { $0.id == intID }) {
                    OrderDetailsView(order)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("OrdersListView.LogoutButton.Title".localized) {
                        Auth.shared.logout()
                    }
                }
            }
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
