//
//  Item.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 04/04/2024.
//

import Foundation
import SwiftData

@Model
final class InventoryItem {
    @Attribute(.unique) var id: Int
    @Attribute var ean: String
    @Attribute var sku: String
    @Attribute var quantity: Int
    @Attribute var box: String
    @Attribute var order: InventoryOrder
    @Attribute var isInventoried: Bool
    
    var eanAsString: String {
        String(ean)
    }
    
    init(
        id: Int,
        ean: String,
        sku: String,
        quantity: Int,
        box: String,
        order: InventoryOrder,
        isInventoried: Bool
    ) {
        self.id = id
        self.ean = ean
        self.sku = sku
        self.quantity = quantity
        self.box = box
        self.order = order
        self.isInventoried = isInventoried
    }
    
    convenience init(from item: Item, order: InventoryOrder) {
        self.init(
            id: item.id,
            ean: String(item.ean),
            sku: item.sku,
            quantity: item.quantity,
            box: item.box,
            order: order,
            isInventoried: item.inventoried)
    }
    
    static let sampleData = [
        InventoryItem(id: 0, ean: "7589679780", sku: "GHJ32547346YUI", quantity: 123, box: "3", order: InventoryOrder.sampleOrders[0], isInventoried: false),
        InventoryItem(id: 2, ean: "980378083", sku: "VBNM546788IO", quantity: 0, box: "79", order: InventoryOrder.sampleOrders[0], isInventoried: true),
        InventoryItem(id: 22, ean: "908969867575", sku: "VBNM5467238IO", quantity: 1, box: "79", order: InventoryOrder.sampleOrders[0], isInventoried: true),
        InventoryItem(id: 3, ean: "890806786", sku: "VBN09788967655WE", quantity: 15, box: "8", order: InventoryOrder.sampleOrders[1], isInventoried: false),
        InventoryItem(id: 4, ean: "98766544342", sku: "TYU67864434755RT", quantity: 0, box: "12", order: InventoryOrder.sampleOrders[2], isInventoried: false)]
}
