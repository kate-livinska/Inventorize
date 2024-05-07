//
//  BoxView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 06/05/2024.
//

import SwiftUI

struct BoxView: View {
    var scannedCode: String
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Here goes box number and item quantity from DB for \(scannedCode)")
            Text("Box #")
            Text("Qty")
            Spacer()
            Button("OK".localized) {
                withAnimation {
                    dismiss()
                }
            }
        }
        .padding(25)
    }
}

#Preview {
    BoxView(scannedCode: "123456789")
}
