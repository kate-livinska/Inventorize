//
//  Item.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 04/04/2024.
//

import Foundation
import SwiftData

@Model
class InventoryItem {
    @Attribute(.unique) var id: Int
    var ean: Int
    var sku: String
    var quantity: Int
    var box: String
    var isInventoried: Bool
    
    init(_ item: Item) {
        self.id = item.id
        self.ean = item.ean
        self.sku = item.sku
        self.quantity = item.quantity
        self.box = item.box
        self.isInventoried = item.inventoried
    }
    
    init(id: Int, ean: Int, sku: String, quantity: Int, box: String, isInventoried: Bool) {
        self.id = id
        self.ean = ean
        self.sku = sku
        self.quantity = quantity
        self.box = box
        self.isInventoried = isInventoried
    }
    
    static let sampleData = [
        InventoryItem(id: 1, ean: 7589679780, sku: "GHJ32547346YUI", quantity: 123, box: "3", isInventoried: false),
        InventoryItem(id: 2, ean: 980378083, sku: "VBNM546788IO", quantity: 0, box: "79", isInventoried: true),
    InventoryItem(id: 3, ean: 890806786, sku: "VBN09788967655WE", quantity: 15, box: "8", isInventoried: false),
    InventoryItem(id: 4, ean: 98766544342, sku: "TYU67864434755RT", quantity: 0, box: "12", isInventoried: false)]
}
