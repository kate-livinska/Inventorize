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
                ordersList
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
            ScannerView()
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
        Text(order.content.id)
            .font(.system(size: 17))
            .foregroundStyle(order.wasOpened ? .gray : .blue)
            .fontWeight(order.wasOpened ? .light : .bold)
            .padding()
//        ZStack {
//            let base = RoundedRectangle(cornerRadius: 5)
//            base.strokeBorder(lineWidth: 1)
            
//        }
    }
}

#Preview {
    OrdersListView()
}
