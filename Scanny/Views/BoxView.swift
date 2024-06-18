//
//  BoxView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 06/05/2024.
//

import SwiftUI
import SwiftData

struct BoxView: View {
    @Environment(\.modelContext) private var context
    @State private var showOrderDetails = false
    
    var item: InventoryItem
    
    init(item: InventoryItem) {
        self.item = item
    }
    
    var body: some View {
        VStack {
            Text("Box #\(item.box)")
            Text("Qty: \(item.quantity)")
            Spacer()
            Button("OK".localized) {
                showOrderDetails = true
            }
        }
        .navigationDestination(isPresented: $showOrderDetails) {
            OrderDetailsView(order: item.order)
        }
        .padding(25)
    }
}

#Preview {
    BoxView(item: SampleData.shared.item)
        .modelContainer(SampleData.shared.modelContainer)
}
