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
    
    init(orderID: Int, searchText: String) {
        self.selectedOrderID = orderID
        let predicate = #Predicate<InventoryItem> {
            $0.eanAsString.contains(searchText)
            &&
            $0.order.id == selectedOrderID
        }
        
        _items = Query(filter: predicate)
    }
    
    var body: some View {
        if items.isEmpty || items.count > 1 {
            SearchBySKU(searchText: searchText, orderID: selectedOrderID)
                .searchable(text: $searchText)
        } else if items[0].quantity == 0 {
            //EditQuantity
        } else {
            BoxView(item: items[0])
        }
    }
}

#Preview {
    ScanResults(orderID: 1, searchText: "7589679780")
        .modelContainer(SampleData.shared.modelContainer)
}
