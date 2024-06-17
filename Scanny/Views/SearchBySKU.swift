//
//  SearchBySKU.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 14/06/2024.
//

import SwiftUI
import SwiftData

struct SearchBySKU: View {
    @Environment(ViewModel.self) private var viewModel
    @Environment(\.modelContext) private var context
    @Query private var items: [InventoryItem]
    
    init() {
        let selectedOrderID: Int = viewModel.selectedOrder!.id
        let searchText = viewModel.searchText
        let predicate = #Predicate<InventoryItem> { $0.sku.contains(searchText) && $0.order.id == selectedOrderID }
        
        _items = Query(filter: predicate)
    }
    
    var body: some View {
       Text("Search by SKU")
        
    }
}

#Preview {
    SearchBySKU()
        .environment(ViewModel())
        .modelContainer(SampleData.shared.modelContainer)
}
