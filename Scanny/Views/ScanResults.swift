//
//  ScanResults.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 17/06/2024.
//

import SwiftUI
import SwiftData

struct ScanResults: View {
    @Environment(ViewModel.self) private var viewModel
    @Environment(\.modelContext) private var context
    @Query private var items: [InventoryItem]
    
    init() {
        let selectedOrderID: Int = viewModel.selectedOrder!.id
        let searchText = viewModel.searchText
        let predicate = #Predicate<InventoryItem> { $0.ean.description.contains(searchText) && $0.order.id == selectedOrderID }
        
        _items = Query(filter: predicate)
    }
    
    var body: some View {
        if items.isEmpty || items.count > 1 {
            SearchBySKU()
        } else if items[0].quantity == 0 {
            //EditQuantity
        } else {
            BoxView()
        }
    }
}

#Preview {
    ScanResults()
        .environment(ViewModel())
        .modelContainer(SampleData.shared.modelContainer)
}
