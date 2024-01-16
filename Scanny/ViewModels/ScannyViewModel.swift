//
//  ScannyViewModel.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 15/01/2024.
//

import Foundation

class ScannyViewModel: ObservableObject {
    @Published var isTokenAvailable = false
    @Published private var scannyModel = createScanny([])
    
    private static func createScanny(_ fetchedOrders: [Order]) -> Scanny<Order> {
        return Scanny(fetchedOrders: fetchedOrders) { i in
            return fetchedOrders[i]
        }
    }
    
    init() {
        if let token = getToken() {
            if let fetchedOrders = fetchOrdersData(with: token) {
                scannyModel = ScannyViewModel.createScanny(fetchedOrders)
            }
        }
    }
    
    var orders: [Scanny<Order>.Card] {
        scannyModel.ordersCards
    }
    
    func choose(_ order: Scanny<Order>.Card) {
        scannyModel.choose(order)
    }
    
    func getToken() -> String? {
        guard let data = KeychainManager.get(
            service: "Scanny",
            account: "SkannyToken"
        ) else {
            print("Error: Failed to obtain token.")
            return nil
        }
        
        let token = String(decoding: data, as: UTF8.self)
        isTokenAvailable = true
        return token
    }
    
    func fetchOrdersData(with token: String) -> [Order]? {
        var fetchedOrders: [Order] = []
        let networkManager = NetworkManager<OrderResults>()
        
        guard let request = networkManager.createRequest(
            path: K.Networking.ordersPath,
            method: "get",
            value: "Bearer \(token)",
            header: K.Networking.ordersHeader
        ) else {
            return nil
        }
        
        networkManager.fetchData(request: request) { response in
            switch response {
            case .success(let orders):
                fetchedOrders = orders.results
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        return fetchedOrders
    }
    
    
}
