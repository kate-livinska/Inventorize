//
//  OrderList.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 12/01/2024.
//

import Foundation

struct OrdersList<CardContent> {
    private(set) var orders: [Card]
    
    init(cardContentFactory: ([Order]) -> CardContent) {
        orders = []
        let content = cardContentFactory(<#T##[Order]#>)
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = orders.firstIndex(where: { $0.id == card.id}) {
            orders[chosenIndex].wasOpened = true
        }
    }
    
    struct Card {
        let id: String
        let content: CardContent
        var wasOpened = false
    }
}

