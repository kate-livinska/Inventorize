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
    
    var unsortedItems: [InventoryItem] {
        order.orderItems.sorted {first, second in
            //first.isInventoried < second.isInventoried &&
            first.id < second.id &&
            first.isInventoried < second.isInventoried
        }
    }
    
    init(order: InventoryOrder) {
        self.order = order
        
    }
    
    var body: some View {
        VStack {
            ScannerView()
            Divider()
            if unsortedItems.count == 0 {
                Text("No items - \(order.orderItems.count)")
            }
            List(unsortedItems) {
                ItemView($0)
            }
            .listStyle(.plain)
            Button(action: {
                do {
                    try context.delete(model: InventoryItem.self)
                } catch {
                    print("Failed to delete.")
                }
            }, label: {
                Text("Delete Data")
            })
        }
        //make the items list not refreshable
        .environment(\EnvironmentValues.refresh as! WritableKeyPath<EnvironmentValues, RefreshAction?>, nil)
    }
}


struct ItemView: View {
    let item: InventoryItem
    
    init(_ item: InventoryItem) {
        self.item = item
    }
    
    var body: some View {
        HStack {
            if item.isInventoried {
                Image(systemName: "checkmark.circle")
            }
            VStack(alignment: .leading) {
                Text("\(String(item.id)) EAN: \(String(item.ean))")
                Text("SKU: \(String(item.sku))")
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Qty: \(String(item.quantity))")
                Text("Box: \(String(item.box))")
                    .fontWeight(.bold)
            }
        }
        .listRowBackground(item.isInventoried ? Color.green : Color.clear)
    }
}

#Preview {
    NavigationStack {
        OrderDetailsView(order: SampleData.shared.order)
            .modelContainer(SampleData.shared.modelContainer)
    }
}
