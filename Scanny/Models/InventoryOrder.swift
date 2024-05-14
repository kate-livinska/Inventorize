//
//  InventoryOrder.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 14/05/2024.
//

import Foundation
import SwiftData

@Model
final class InventoryOrder {
    @Attribute(.unique) var id: Int
    var orderItems = [InventoryItem]()
    
    init(id: Int, name: String) {
        self.id = id
    }
    
    init(_ order: Order) {
        self.id = order.id
    }
}
