//
//  OrderList.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 12/01/2024.
//

import Foundation

struct Scanny<CardContent> {
    private(set) var ordersCards: [Card]
    
    init(fetchedOrders: [CardContent], cardContentFactory: (Int) -> CardContent) {
        ordersCards = []
        for i in 0..<fetchedOrders.endIndex {
            let content = cardContentFactory(i)
            ordersCards.append(Card(id: "\(i)", content: content))
        }
        print(ordersCards)
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = ordersCards.firstIndex(where: { $0.id == card.id}) {
            ordersCards[chosenIndex].wasOpened = true
        }
    }
    
    struct Card: Identifiable {
        let id: String
        let content: CardContent
        var wasOpened = false
    }
}

