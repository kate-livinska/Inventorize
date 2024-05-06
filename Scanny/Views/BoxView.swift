//
//  BoxView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 06/05/2024.
//

import SwiftUI

struct BoxView: View {
    var scannedCode: String
    
    var body: some View {
        VStack {
            Text("Here goes box number and item quantity from DB for \(scannedCode)")
            Text("Box #")
            Text("Qty")
        }
    }
}

#Preview {
    BoxView(scannedCode: "123456789")
}
