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
    @StateObject private var navigationManager = NavigationManager()
    
    @Query(sort: \InventoryOrder.id) private var orders: [InventoryOrder]
    
    @State var selectedOrder: InventoryOrder? = nil
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            VStack {
                List(selection: $selectedOrder) {
                    ForEach(orders) { order in
                        NavigationLink(value: Destination.details(order)) {
                            OrderView(order)
                                .padding(1)
                        }
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
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .details(let order):
                    OrderDetailsView(order)
                case .boxView(let item):
                    BoxView(item: item)
                case .editQuantity(let item):
                    EditQuantity(item: item)
                case .scanner(let id):
                    ScannerView(orderID: id)
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
        .environmentObject(navigationManager)
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
