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
    @Environment(ViewModel.self) private var viewModel
    
    var sortedItems: [InventoryItem] {
        order.orderItems.sorted { first, second in
            (first.isInventoried, first.id) < (second.isInventoried, second.id)
        }
    }
    
    init(order: InventoryOrder) {
        self.order = order
        viewModel.selectedOrder = order
    }
    
    var body: some View {
        VStack {
            ScannerView()
            Divider()
            if sortedItems.count == 0 {
                Text("No items")
            }
            List(sortedItems) {
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
        .task {
            if !order.wasOpened {
                print("Order tapped")
                order.wasOpened = true
                await DataService.saveItems(modelContext: context, order: order)
            }
        }
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
            .environment(ViewModel())
    }
}
