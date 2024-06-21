//
//  OrderDetailsView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 13/02/2024.
//

import SwiftUI
import SwiftData

struct OrderDetailsView: View {
    var order: InventoryOrder
    @Environment(\.modelContext) private var context
    
    init(_ order: InventoryOrder) {
        self.order = order
    }
    
    var body: some View {
        VStack {
            ScannerView(orderID: order.id)
            Divider()
                .frame(maxHeight: 2)
                .overlay(Color.teal)
            ItemsList(order)
            Button(action: {
                //Send items to server
            }, label: {
                Text("Send to Server".localized)
            })
        }
        .navigationTitle("\(order.name) \(String(order.id))")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if !order.wasOpened {
                print("Order tapped")
                order.wasOpened = true
                await DataService.saveItems(modelContext: context, order: order)
            }
        }
        //make the view not refreshable
        .environment(\EnvironmentValues.refresh as! WritableKeyPath<EnvironmentValues, RefreshAction?>, nil)
    }
}

#Preview {
    NavigationStack {
        OrderDetailsView(SampleData.shared.order)
            .modelContainer(SampleData.shared.modelContainer)
            .environmentObject(NavigationManager())
    }
}
