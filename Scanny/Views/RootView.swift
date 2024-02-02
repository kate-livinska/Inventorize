//
//  ContentView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 09/01/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var auth: Auth
    
    var body: some View {
        if auth.loggedIn {
            OrdersListView()
        } else {
            LoginView()
        }
    }
}

//#Preview {
//    RootView()
//}
