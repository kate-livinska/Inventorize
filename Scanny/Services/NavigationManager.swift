//
//  NavigationManager.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 21/06/2024.
//

import SwiftUI

class NavigationManager: ObservableObject {
    @Published var path = [Destination]()
    
    var currentOrder: InventoryOrder?
    
    var currentItem: InventoryItem?
    
    func goToOrdersList() {
        self.path = [Destination]()
    }
}

enum Destination: Hashable {
    case editQuantity(InventoryItem)
    case boxView(InventoryItem)
    case details(InventoryOrder)
    case scanner(Int)
}
