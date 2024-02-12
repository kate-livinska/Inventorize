//
//  DataService.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 25/01/2024.
//

import Foundation

class DataService: NetworkBase, ObservableObject {
    static let shared = DataService()
    @Published var fetchedOrders = [Order]()
    
    init() {
        fetchOrders()
    }
   
    enum Endpoint: EndpointProtocol {
        case orders
        //case items
        
        var path: String {
            switch self {
            case .orders: K.Networking.ordersPath
            //case .items:
            }
        }
    }
    
    enum Request: RequestProtocol {
        case orders
        
        var method: String {
            switch self {
            case .orders: "get"
            }
        }
        
        var value: String {
            switch self {
            case .orders:
                guard let token = KeychainManager.getToken() else {
                    print("Could not obtain token from Keychain")
                    return "0"
                }
                return "Bearer \(token)"
            }
        }
        
        var header: String {
            switch self {
            case .orders: "Authorization"
            }
        }
    }
    
    func fetchOrders() {
        Task {
            do {
                let orders = try await self.fetch(
                    OrderResults.self,
                    endpoint: .orders,
                    request: .orders
                )
                DispatchQueue.main.async {
                    self.fetchedOrders = orders.results
                }
            } catch {
                print("Error: Data request failed. \(error.localizedDescription)")
            }
        }
    }
}
