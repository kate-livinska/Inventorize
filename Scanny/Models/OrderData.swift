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
    let id: Int
    let name: String
}

struct OrderDetails: Codable {
    var results: [Item]
}

struct Item: Codable, Identifiable {
    let id: Int
    let ean: Int
    let sku: String
    var quantity: Int
    let box: String
}
