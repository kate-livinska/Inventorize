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
    }
    
    var body: some View {
        VStack {
            ScannerView(orderID: order.id)
            Divider()
                .frame(maxHeight: 2)
                .overlay(Color.secondary)
            if sortedItems.count == 0 {
                Text("No items")
            }
            List(sortedItems) {
                ItemView($0)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.linearGradient(colors: [.white, .teal.opacity(0.5)], startPoint: .center, endPoint: .bottom)))
//            .background(.linearGradient(colors: [.white, .teal.opacity(0.5)], startPoint: .center, endPoint: .bottom), ignoresSafeAreaEdges: .vertical)
            Button(action: {
                //Send items to server
            }, label: {
                Text("Send to Server".localized)
            })
        }
        
        //make the items list not refreshable
        .environment(\EnvironmentValues.refresh as! WritableKeyPath<EnvironmentValues, RefreshAction?>, nil)
        .task {
            if !order.wasOpened {
                print("Order tapped")
                order.wasOpened = true
                await DataService.saveItems(modelContext: context, order: order)
                viewModel.selectedOrder = order
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
        .listRowBackground(RoundedRectangle(cornerRadius: 15)
            .background(.clear)
            .foregroundColor(item.isInventoried ? Color.green.opacity(0.4) : Color.clear))
    }
}

#Preview {
    NavigationStack {
        OrderDetailsView(order: SampleData.shared.order)
            .modelContainer(SampleData.shared.modelContainer)
            .environment(ViewModel())
    }
}
