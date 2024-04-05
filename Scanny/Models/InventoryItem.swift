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
    var inventoried: Bool
    
//    init(id: Int, ean: Int, sku: String, quantity: Int, box: String, inventoried: Bool) {
//        self.id = id
//        self.ean = ean
//        self.sku = sku
//        self.quantity = quantity
//        self.box = box
//        self.inventoried = inventoried
//    }
//    
//    convenience init(_ item: Item) {
//        self.init(
//            id: item.id,
//            ean: item.ean,
//            sku: item.sku,
//            quantity: item.quantity,
//            box: item.box,
//            inventoried: item.inventoried)
//    }
    
    init(_ item: Item) {
        self.id = item.id
        self.ean = item.ean
        self.sku = item.sku
        self.quantity = item.quantity
        self.box = item.box
        self.inventoried = item.inventoried
    }
}
