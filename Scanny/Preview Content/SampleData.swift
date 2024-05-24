//
//  SampleData.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 27/04/2024.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    private init() {
        let schema = Schema([
            InventoryItem.self,
            InventoryOrder.self
                ])
                let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
                
                do {
                    modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
                    
                    insertSampleData()
                } catch {
                    fatalError("Could not create ModelContainer: \(error)")
                }
    }
    
    func insertSampleData() {
        for order in InventoryOrder.sampleOrders {
            context.insert(order)
        }
        
        for item in InventoryItem.sampleData {
            context.insert(item)
        }
        
        InventoryOrder.sampleOrders[0].orderItems.append(InventoryItem.sampleData[0])
        InventoryOrder.sampleOrders[0].orderItems.append(InventoryItem.sampleData[1])
        InventoryOrder.sampleOrders[0].orderItems.append(InventoryItem.sampleData[2])
        InventoryOrder.sampleOrders[1].orderItems.append(InventoryItem.sampleData[3])
        InventoryOrder.sampleOrders[2].orderItems.append(InventoryItem.sampleData[4])
        
        do {
            try context.save()
        } catch {
            print("Sample data context failed to save.")
        }
    }
    
    var order: InventoryOrder {
        InventoryOrder.sampleOrders[0]
    }
}
