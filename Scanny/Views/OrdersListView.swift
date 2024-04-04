//
//  SwiftUIView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 18/01/2024.
//

import SwiftUI

struct OrdersListView: View {
    @ObservedObject var dataService = DataService()
    
    var body: some View {
        VStack {
            NavigationSplitView {
                ordersList
                    .navigationTitle("OrdersListView.Orders.Title".localized)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Log Out") {
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
    }
    
    var ordersList: some View {
        List(dataService.fetchedOrders) { order in
            NavigationLink {
                OrderDetailsView(order: order)
                    .navigationTitle("\(order.name) \(order.id)")
                    .navigationBarTitleDisplayMode(.inline)
            } label: {
                OrderView(order)
                    .padding(1)
            }
        }
        .onAppear {
            dataService.fetchOrders()
        }
        .refreshable {
            dataService.fetchOrders()
        }
    }
}
                        
struct OrderView: View {
    @ObservedObject var state = OrderState.shared
    let order: Order
    
    init(_ order: Order) {
        self.order = order
    }
    
    var body: some View {
        HStack {
            Text(String(order.id))
            Text(order.name)
        }
        .font(.system(size: 15))
        .foregroundStyle(state.openedOrders.contains(order.id) ? .gray : .primaryColor)
        .fontWeight(state.openedOrders.contains(order.id) ? .light : .bold)
    }
}

#Preview {
    OrdersListView()
}
