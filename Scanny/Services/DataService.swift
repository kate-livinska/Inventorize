//
//  DataService.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 25/01/2024.
//

import Foundation
import SwiftData

@MainActor
class DataService: NetworkBase, ObservableObject {
    static let shared = DataService()
    @Published var fetchedOrders = [Order]()
    @Published var fetchedItems = [Item]()
    @Published var isLoading = true

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
                self.fetchedOrders = orders.results
            } catch {
                print("Error: Data request failed. \(error.localizedDescription)")
            }
        }
    }
    
    func fetchItems(id: Int) async -> [Item]? {
        let directoryStr = "/\(String(id))"
        do {
            let orderDetails = try await self.fetch(
                OrderDetails.self,
                endpoint: .orders,
                directory: directoryStr,
                request: .orders
            )
            self.isLoading = false
            return orderDetails.results
            
        } catch {
            print("Error: Data request failed. \(error.localizedDescription)")
        }
        return nil
    }
}

//MARK: - Transfer data to local Database
extension DataService {
    func updateLocalDatabase(modelContext: ModelContext, id: Int) async {
        
        guard let items = await fetchItems(id: id) else { return }
        do {
            try modelContext.transaction {
                for eachItem in items {
                    let itemToStore = InventoryItem(eachItem, orderId: id)
                    modelContext.insert(itemToStore)
                }
            }
        } catch {
            print("Error saving data to database")
        }
    }
}
