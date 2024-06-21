//
//  ScanResults.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 17/06/2024.
//

import SwiftUI
import SwiftData

struct ScanResults: View {
    //@Environment(\.modelContext) private var context
    @EnvironmentObject var navigationManager: NavigationManager
    
    private var selectedOrderID: Int
    @State private var searchText: String = ""
    
    @Query private var items: [InventoryItem]
    
    init(for orderID: Int, searchText: String) {
        self.selectedOrderID = orderID
        let predicate = #Predicate<InventoryItem> {
            $0.eanAsString.contains(searchText)
            &&
            $0.order.id == selectedOrderID
        }
        
        _items = Query(filter: predicate)
    }
    
    var body: some View {
        SearchBySKU(searchText: searchText, orderID: selectedOrderID)
            .searchable(text: $searchText)
            .task {
                if items.count == 1 && items[0].quantity == 0 {
                    navigationManager.path.append(.editQuantity(items[0]))
                } else if items.count == 1 {
                    navigationManager.path.append(.boxView(items[0]))
                }
            }
//            .navigationDestination(for: String.self) { destination in
//                switch destination {
//                case "EditQuantity":
//                    EditQuantity(item: items[0])
//                        .environmentObject(navigationManager)
//                case "BoxView":
//                    BoxView(item: items[0])
//                        .environmentObject(navigationManager)
//                default:
//                    OrdersList()
//                }
//            }
        
//            .task {
//                if items.count == 1 && items[0].quantity == 0 {
//                    navigationManager.path.append("EditQuantity")
//                } else if items.count == 1 {
//                    navigationManager.path.append("BoxView")
//                }
//            }
//            .navigationDestination(for: String.self) { id in
//                if id == "EditQuantity" {
//                   EditQuantity(item: items[0])
//                }
//                if id == "BoxView" {
//                    BoxView(item: items[0])
//                }
//            }
        
        
//            .fullScreenCover(isPresented: $isPresentedEditQuantity) {
//                EditQuantity(item: items[0])
//            }
//            .fullScreenCover(isPresented: $isPresentedBoxView) {
//                BoxView(item: items[0])
//            }
    }
}

#Preview {
    ScanResults(for: 1, searchText: "7589679780")
        .modelContainer(SampleData.shared.modelContainer)
        .environmentObject(NavigationManager())
}
