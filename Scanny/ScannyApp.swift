//
//  ScannyApp.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 09/01/2024.
//

import SwiftUI

@main
struct ScannyApp: App {
    //@StateObject var ordersList = OrdersListViewModel()
    @StateObject var auth = Auth()
    @StateObject var dataService = DataService()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(auth)
                .environmentObject(dataService)
        }
    }
}
