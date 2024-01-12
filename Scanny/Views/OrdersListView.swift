//
//  OrdersListView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 11/01/2024.
//

import SwiftUI

struct OrdersListView: View {
    @ObservedObject var ordersListVM = OrdersListViewModel(token: K.Networking.token)
    
    var body: some View {
        
        List(ordersListVM.orders) { order in
            OrderView(order)
                .onTapGesture {
                    
                }
        }
    }
}

struct OrderView: View {
    let orderID: String
    var wasOpened = false
    
    init(_ order: Order) {
        self.orderID = order.id
        self.wasOpened = order.wasOpened
    }
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 5)
            Group {
                base.strokeBorder(lineWidth: 1)
                Text(orderID)
                    .font(.system(size: 17))
                    .foregroundStyle(wasOpened ? .gray : .blue)
                    .fontWeight(wasOpened ? .light : .bold)
            }
            .padding()
        }
    }
}













#Preview {
    OrdersListView()
}
