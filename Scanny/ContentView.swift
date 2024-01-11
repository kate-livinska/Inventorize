//
//  ContentView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 09/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State var isValidToken = false
    
    var body: some View {
        if !isValidToken {
            LoginView()
        } else {
            //ScannerView
        }
    }
}

#Preview {
    ContentView()
}
