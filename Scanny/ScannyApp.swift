//
//  ScannyApp.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 09/01/2024.
//

import SwiftUI
import SwiftData

@main
struct ScannyApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [InventoryItem.self, InventoryOrder.self])
    }
}
