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
        for item in InventoryItem.sampleData {
            context.insert(item)
        }
        do {
            try context.save()
        } catch {
            print("Sample data context failed to save.")
        }
    }
}

let sampleOrders = [Order(id: 1, name: "Order1"), Order(id: 2, name: "Order2"), Order(id: 3, name: "Order3")]

let sampleOrderDetail = [Item(id: 1, ean: 12345, sku: "QWE12345", quantity: 5, box: "5", inventoried: false), Item(id: 2, ean: 234567, sku: "DFG567789GH", quantity: 100, box: "6", inventoried: true), Item(id: 3, ean: 678999090, sku: "VBN435766789GHJ", quantity: 0, box: "89", inventoried: false)]
