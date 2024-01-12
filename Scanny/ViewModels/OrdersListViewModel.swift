//
//  OrdersListViewModel.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 11/01/2024.
//

import Foundation

class OrdersListViewModel: ObservableObject {
    @Published var orders = [Order]()
    
    init(token: String) {
        let networkManager = NetworkManager<OrderResults>()
        
        guard let request = networkManager.createRequest(path: K.Networking.ordersPath, value: token, header: K.Networking.ordersHeader) else {
            return
        }
        networkManager.fetchData(request: request) { response in
            switch response {
            case .success(let orders):
                self.orders = orders.results
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func choose(_ order: Order) {
        order.choose()
    }
}
