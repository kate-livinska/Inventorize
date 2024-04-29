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
    var ean: Int
    var sku: String
    var quantity: Int
    var box: String
    var orderId: Int
    var isInventoried: Bool
    
    init(_ item: Item, orderId: Int) {
        self.id = item.id
        self.ean = item.ean
        self.sku = item.sku
        self.quantity = item.quantity
        self.box = item.box
        self.orderId = orderId
        self.isInventoried = item.inventoried
    }
    
    init(id: Int, ean: Int, sku: String, quantity: Int, box: String, orderId: Int, isInventoried: Bool) {
        self.id = id
        self.ean = ean
        self.sku = sku
        self.quantity = quantity
        self.box = box
        self.orderId = orderId
        self.isInventoried = isInventoried
    }
    
    static let sampleData = [
        InventoryItem(id: 0, ean: 7589679780, sku: "GHJ32547346YUI", quantity: 123, box: "3", orderId: 0, isInventoried: false),
        InventoryItem(id: 2, ean: 980378083, sku: "VBNM546788IO", quantity: 0, box: "79", orderId: 0, isInventoried: true),
        InventoryItem(id: 22, ean: 908969867575, sku: "VBNM5467238IO", quantity: 1, box: "79", orderId: 0, isInventoried: true),
        InventoryItem(id: 3, ean: 890806786, sku: "VBN09788967655WE", quantity: 15, box: "8", orderId: 1, isInventoried: false),
        InventoryItem(id: 4, ean: 98766544342, sku: "TYU67864434755RT", quantity: 0, box: "12", orderId: 1, isInventoried: false)]
}
