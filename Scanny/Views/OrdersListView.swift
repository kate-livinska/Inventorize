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
            }
            detail: {
                Text("Select an order")
            }
            HStack {
                Button("Log Out") {
                    Auth.shared.logout()
                }
                Spacer()
            }
            .padding()
        }
    }
    
    var ordersList: some View {
        List(dataService.fetchedOrders) { order in
            NavigationLink {
                OrderDetailsView(order: order)
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
        .font(.system(size: 16))
        .foregroundStyle(OrderState.shared.openedOrders.contains(order.id) ? .gray : .primaryColor)
        .fontWeight(OrderState.shared.openedOrders.contains(order.id) ? .light : .bold)
        .padding()
    }
}

#Preview {
    OrdersListView()
}
