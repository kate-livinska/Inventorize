//
//  DataService.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 25/01/2024.
//

import Foundation
import SwiftData

class DataService: NetworkBase {
   
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
    
    static func fetchOrders() async throws -> [Order] {
        do {
            let orders = try await self.fetch(
                OrderResults.self,
                endpoint: .orders,
                request: .orders
            )
            return orders.results
        } catch {
            print("Error: Data request failed. \(error.localizedDescription)")
            throw error
        }
    }
    
    static func fetchItems(id: Int) async -> [Item]? {
        let directoryStr = "/\(String(id))"
        do {
            let orderDetails = try await self.fetch(
                OrderDetails.self,
                endpoint: .orders,
                directory: directoryStr,
                request: .orders
            )
            return orderDetails.results
            
        } catch {
            print("Error: Data request failed. \(error.localizedDescription)")
        }
        return nil
    }
}

//MARK: - Transfer data to local Database

extension DataService {
    @MainActor
    static func refreshOrders(modelContext: ModelContext) async {
        do {
            let orders = try await fetchOrders()
            
            for order in orders {
                let inventoryOrder = InventoryOrder(from: order)
                modelContext.insert(inventoryOrder)
            }
        } catch let error {
            print("Error: refreshing orders failed. \(error.localizedDescription)")
        }
    }
    
    @MainActor
    static func saveItems(modelContext: ModelContext, order: InventoryOrder) async {
        
        guard let items = await fetchItems(id: order.id) else { return }
        do {
            try modelContext.transaction {
                for eachItem in items {
                    let itemToPersist = InventoryItem(from: eachItem, order: order)
                    modelContext.insert(itemToPersist)
                }
            }
        } catch let error {
            print("Error saving data to database. \(error.localizedDescription)")
        }
    }
}
