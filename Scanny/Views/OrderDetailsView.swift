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
    
    var sortedItems: [InventoryItem] {
        order.orderItems.sorted { first, second in
            (first.isInventoried, first.id) < (second.isInventoried, second.id)
        }
    }
    
    init(_ order: InventoryOrder) {
        self.order = order
    }
    
    var body: some View {
        VStack {
            ScannerView(orderID: order.id)
            Divider()
                .frame(maxHeight: 2)
                .overlay(Color.teal)
            if sortedItems.count == 0 {
                Text("No items")
            }
            List(sortedItems) {
                ItemView($0)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.linearGradient(colors: [.teal.opacity(0.15), .white], startPoint: .top, endPoint: .bottom)))
            Button(action: {
                //Send items to server
            }, label: {
                Text("Send to Server".localized)
            })
        }
        .navigationTitle("\(order.name) \(String(order.id))")
        .navigationBarTitleDisplayMode(.inline)
        
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
                Text("\(String(item.id)) EAN: \(item.eanAsString)")
                Text("SKU: \(String(item.sku))")
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Qty: \(String(item.quantity))")
                Text("Box: \(String(item.box))")
                    .fontWeight(.bold)
            }
        }
        .listRowBackground(RoundedRectangle(cornerRadius: 4)
            .background(.clear)
            .foregroundColor(item.isInventoried ? Color.green.opacity(0.4) : Color.clear))
    }
}

#Preview {
    NavigationStack {
        OrderDetailsView(SampleData.shared.order)
            .modelContainer(SampleData.shared.modelContainer)
    }
}
