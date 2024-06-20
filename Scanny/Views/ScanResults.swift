//
//  ScanResults.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 17/06/2024.
//

import SwiftUI
import SwiftData

struct ScanResults: View {
    @Environment(\.modelContext) private var context
    private var selectedOrderID: Int
    @State private var searchText: String = ""
    
    @Query private var items: [InventoryItem]
    
    @State private var isPresentedEditQuantity = false
    @State private var isPresentedBoxView = false
    
    init(for orderID: Int, searchText: String) {
        self.selectedOrderID = orderID
        let predicate = #Predicate<InventoryItem> {
            $0.eanAsString.contains(searchText)
            &&
            $0.order.id == selectedOrderID
        }
        
        _items = Query(filter: predicate)
        
        if items.count == 1 && items[0].quantity == 0 {
            isPresentedEditQuantity = true
        } else if items.count == 1 {
            isPresentedBoxView = true
        }
        
    }
    
    var body: some View {
        SearchBySKU(searchText: searchText, orderID: selectedOrderID)
            .searchable(text: $searchText)
            .fullScreenCover(isPresented: $isPresentedEditQuantity) {
                EditQuantity(item: items[0])
            }
            .fullScreenCover(isPresented: $isPresentedBoxView) {
                BoxView(item: items[0])
            }
    }
}

#Preview {
    ScanResults(for: 1, searchText: "7589679780")
        .modelContainer(SampleData.shared.modelContainer)
}
