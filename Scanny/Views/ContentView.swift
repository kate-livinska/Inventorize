//
//  ContentView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 02/02/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RootView()
            .environmentObject(Auth.shared)
            //.environmentObject(DataService.shared)
    }
}

#Preview {
    ContentView()
}
