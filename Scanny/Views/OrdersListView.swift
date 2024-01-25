//
//  SwiftUIView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 18/01/2024.
//

import SwiftUI

struct OrdersListView: View {
    @ObservedObject var orderListVM = OrdersListViewModel()
    
    var body: some View {
        VStack {
            Text("OrdersListView.Orders.Title".localized)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            if orderListVM.isLoading {
                ProgressView("ProgressView.Text".localized)
            } else {
                ordersList
            }
        }
    }
    
    var ordersList: some View {
        ForEach(orderListVM.orders) { order in
            OrderView(order)
                .padding(1)
                .onTapGesture {
                    orderListVM.choose(order)
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
        ZStack {
            let base = RoundedRectangle(cornerRadius: 5)
            base.strokeBorder(lineWidth: 1)
            Text(order.content.id)
                .font(.system(size: 17))
                .foregroundStyle(order.wasOpened ? .gray : .blue)
                .fontWeight(order.wasOpened ? .light : .bold)
                .padding()
        }
    }
}

#Preview {
    OrdersListView()
}
