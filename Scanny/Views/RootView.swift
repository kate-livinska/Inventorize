//
//  ContentView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 09/01/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var auth: Auth
    @EnvironmentObject var dataService: DataService
    
    var body: some View {
        if auth.loggedIn {
            if dataService.ordersAreFetched {
                OrdersListView()
            } else {
                ProgressView("ProgressView.Text".localized)
            }
        } else {
            LoginView()
        }
    }
}

//#Preview {
//    RootView()
//}
