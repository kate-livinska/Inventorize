//
//  SwiftUIView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 18/01/2024.
//

import SwiftUI

struct OrdersListView: View {
    @Environment(\.modelContext) private var context
    
    @ObservedObject var dataService = DataService()
    
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
    }
    
    var ordersList: some View {
        List(dataService.fetchedOrders) { order in
            NavigationLink {
                OrderDetailsView()
                    .navigationTitle("\(order.name) \(order.id)")
                    .navigationBarTitleDisplayMode(.inline)
                    .task {
                        print("Order tapped")
                        if !openedOrders.contains(order.id) {
                            openedOrders.append(order.id)
                            await dataService.updateLocalDatabase(modelContext: context, id: order.id)
                        }
                    }
            } label: {
                OrderView(order, openedOrders)
                    .padding(1)
            }
        }
        .listStyle(.plain)
        .onAppear {
            dataService.fetchOrders()
        }
        .refreshable {
            dataService.fetchOrders()
        }
    }
}
                        
struct OrderView: View {
    var opened: [Int]
    let order: Order
    
    init(_ order: Order, _ state: [Int]) {
        self.order = order
        self.opened = state
    }
    
    var body: some View {
        HStack {
            Text(String(order.id))
            Text(order.name)
        }
        .font(.system(size: 15))
        .foregroundStyle(opened.contains(order.id) ? .gray : .primaryColor)
        .bold(!opened.contains(order.id))
    }
}

#Preview {
    OrdersListView()
}
