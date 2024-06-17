//
//  ContentView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 02/02/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(ViewModel.self) private var viewModel
    
    var body: some View {
        RootView()
            .environmentObject(Auth.shared)
            .environment(viewModel)
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview {
    ContentView()
        .environment(ViewModel())
        .modelContainer(SampleData.shared.modelContainer)
}
