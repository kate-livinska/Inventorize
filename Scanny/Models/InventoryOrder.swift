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
    var name: String
    var orderItems = [InventoryItem]()
    var wasOpened = false
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    convenience init(from order: Order) {
        self.init(id: order.id, name: order.name)
    }
}
