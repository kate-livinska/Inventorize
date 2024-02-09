//
//  OrdersListViewModel.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 18/01/2024.
//

import Foundation

class OrdersListViewModel: ObservableObject {
    @Published var isLoading = false
    //@Published var fetchedOrders = [Order]()
    private var ordersList: OrdersList<Order>
    
    init() {
        isLoading = true
        OrdersListViewModel.fetchOrders()
        let fetched = DataService.shared.fetchedOrders
        ordersList = OrdersListViewModel.createOrdersList(fetched)
        isLoading = false
        print("OrdersListVM initialized")
    }
    
    deinit {
        print("OrdersListVM deinitialized")
    }
    
    var orders: [OrdersList<Order>.Card] {
        ordersList.ordersCards
    }
    
    func choose(_ order: OrdersList<Order>.Card) {
        ordersList.choose(order)
        print(order.id)
    }
    
    static private func createOrdersList(_ fetchedOrders: [Order]) -> OrdersList<Order> {
        return OrdersList(ordersNumber: fetchedOrders.endIndex) {i in
            return fetchedOrders[i]
        }
    }
    
    static private func fetchOrders() {
        let dataService = DataService()
        
        Task {
            do {
                let orders = try await dataService.fetch(
                    OrderResults.self,
                    endpoint: .orders,
                    request: .orders
                )
                dataService.fetchedOrders = orders.data.results
                //FIXME: - Publishing changes from background threads
                DataService.shared.fetchedOrders = dataService.fetchedOrders
                
                
                switch orders.response {
                case 401:
                    Auth.shared.logout()
                    print("Authorization Error (401)")
                case 200:
                    print("OK")
                default:
                    print("Error while fetching data")
                }
            } catch {
                print("Error: Data request failed. \(error.localizedDescription)")
            }
        }
    }
    
    func logout() {
            Auth.shared.logout()
        }
}



