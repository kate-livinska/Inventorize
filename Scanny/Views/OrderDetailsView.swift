//
//  OrderDetailsView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 13/02/2024.
//

import SwiftUI

struct OrderDetailsView: View {
    @Environment(\.modelContext) private var context
    @ObservedObject var itemService = DataService()
    var order: Order
    
    var body: some View {
        VStack {
            ScannerView()
            ItemsInventoryView()
            //Temporary test button to delete all persistent data
            Button(action: {
                do {
                    try context.delete(model: InventoryItem.self)
                } catch {
                    print("Failed to delete all schools.")
                }
            }, label: {
                Text("Delete Data")
            })
//            if itemService.isLoading {
//                VStack {
//                    Spacer()
//                    ProgressView()
//                        .progressViewStyle(CircularProgressViewStyle())
//                        .scaleEffect(5)
//                    Spacer()
//                }
//            } else {
//                VStack {
//                    ScannerView()
//                    ItemsInventoryView()
//                }
//                .refreshable {
//                    //itemService.fetchItems(id: order.id)
//                }
//            }
        }
        .onAppear {
            Task {
                await itemService.updateLocalDatabase(modelContext: context, id: order.id)
            }
            if !OrderState.shared.openedOrders.contains(order.id) {
                OrderState.shared.openedOrders.append(order.id)
            }
            print("openedOrders: \(OrderState.shared.openedOrders)")
        }
    }
}



#Preview {
    OrderDetailsView(itemService: DataService(), order: Scanny.Order(id: 80429, name: "Order f037qVAbOiHCLA"))
        .modelContainer(for: [InventoryItem.self])
}
