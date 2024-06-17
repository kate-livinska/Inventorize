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
    @State private var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }
        .modelContainer(for: [InventoryItem.self, InventoryOrder.self])
    }
}
