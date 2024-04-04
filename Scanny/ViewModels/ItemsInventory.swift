//
//  ItemsInventory.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 15/03/2024.
//

import Foundation

class ItemsInventory: ObservableObject {
    @Published var items = [Item]()
    
    
    init() {
        self.items = DataService.shared.fetchedItems
        print(DataService.shared.fetchedItems.count)
    }
}
