//
//  SwiftUIView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 18/01/2024.
//

import SwiftUI

struct OrdersListView: View {
    @ObservedObject var orderListVM = OrdersListViewModel()
    @State private var isShowingScannerView = false
    
    var body: some View {
        VStack {
            Text("OrdersListView.Orders.Title".localized)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            if orderListVM.isLoading {
                ProgressView("ProgressView.Text".localized)
            } else {
                List(orderListVM.orders) { order in
                    OrderView(order)
                        .padding(1)
                        .onTapGesture {
                            orderListVM.choose(order)
                            isShowingScannerView.toggle()
                        }
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
        .sheet(isPresented: $isShowingScannerView) {
            OrderDetailsView(order: orderListVM.chosen)
        }
    }
    
    var ordersList: some View {
        List(orderListVM.orders) { order in
            OrderView(order)
                .padding(1)
                .onTapGesture {
                    orderListVM.choose(order)
                    isShowingScannerView.toggle()
                }
        }
    }
}
                        
struct OrderView: View {
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
        .foregroundStyle(order.wasOpened ? .gray : .primaryColor)
        .fontWeight(order.wasOpened ? .light : .bold)
        .padding()
    }
}

#Preview {
    OrdersListView()
}
