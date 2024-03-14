//
//  SwiftUIView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 18/01/2024.
//

import SwiftUI

struct OrdersListView: View {
    @ObservedObject var orderListVM = OrdersListViewModel()
    //@State private var isShowingScannerView = false
    
    var body: some View {
        VStack {
            Text("OrdersListView.Orders.Title".localized)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            if orderListVM.isLoading {
                ProgressView("ProgressView.Text".localized)
            } else {
                NavigationSplitView {
                    ordersList
                        .navigationTitle("OrdersListView.Orders.Title".localized)
                }
            detail: {
                Text("Select an order")
            }
            }
            HStack {
                Button("Log Out") {
                    orderListVM.logout()
                }
                Spacer()
            }
            .padding()
        }
//        .sheet(isPresented: $isShowingScannerView) {
//            OrderDetailsView(order: orderListVM.chosen)
//        }
    }
    
    var ordersList: some View {
        List(orderListVM.orders) { order in
            NavigationLink {
                OrderDetailsView(order: order.content)
            } label: {
                OrderView(order)
                    .padding(1)
//                    .onTapGesture {
//                        orderListVM.choose(order)
//                        //isShowingScannerView.toggle()
//                    }
            }
        }
        .refreshable {
            orderListVM.refresh()
        }
    }
}
                        
struct OrderView: View {
    @ObservedObject var state = OrderState.shared
    let order: OrdersList<Order>.Card
    
    init(_ order: OrdersList<Order>.Card) {
        self.order = order
    }
    
    var body: some View {
        HStack {
            Text(String(order.content.id))
            Text(order.content.name)
        }
        .font(.system(size: 16))
        .foregroundStyle(OrderState.shared.openedOrders.contains(order.content.id) ? .gray : .primaryColor)
        .fontWeight(OrderState.shared.openedOrders.contains(order.content.id) ? .light : .bold)
        .padding()
    }
}

#Preview {
    OrdersListView()
}
