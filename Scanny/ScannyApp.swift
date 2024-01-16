//
//  ScannyApp.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 09/01/2024.
//

import SwiftUI

@main
struct ScannyApp: App {
    @StateObject var scanny = ScannyViewModel()
    
    var body: some Scene {
        WindowGroup {
            ScannyView(scannyVM: scanny)
        }
    }
}
