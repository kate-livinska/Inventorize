//
//  Order.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 11/01/2024.
//

import Foundation

struct OrderResults: Codable {
    let results: [Order]
}

struct Order: Codable, Identifiable {
    let id: String
}

struct OrdeDetails: Codable {
    var results: [Item]
}

struct Item: Codable, Identifiable {
    let itemName: String
    let id: String
    let SKU: String
    var quantity: Int
    let boxNumber: String
}
