//
//  OrdersListViewModel.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 18/01/2024.
//

import Foundation

@MainActor
class OrdersListViewModel: ObservableObject {
    @Published var isLoading = false
    @Published private var ordersList: OrdersList<Order>
    
    init() {
        isLoading = true
        let fetchedOrders = DataService.shared.fetchedOrders
        ordersList = OrdersListViewModel.createOrdersList(fetchedOrders)
        isLoading = false
        print("OrdersListVM initialized")
    }
    
    var orders: [OrdersList<Order>.Card] {
        ordersList.ordersCards
    }
    
    func choose(_ order: OrdersList<Order>.Card) {
        ordersList.choose(order)
        print(order.id)
    }
    
    private static func createOrdersList(_ fetchedOrders: [Order]) -> OrdersList<Order> {
        return OrdersList(ordersNumber: fetchedOrders.endIndex) {i in
            return fetchedOrders[i]
        }
    }
    
    func logout() {
            Auth.shared.logout()
        }
}
