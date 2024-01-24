//
//  OrderList.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 12/01/2024.
//

import Foundation

struct OrdersList<CardContent> {
    private(set) var ordersCards: [Card]
    
    init(ordersNumber: Int, contentFactory: (Int) -> CardContent) {
        ordersCards = []
        for i in 0..<ordersNumber {
            let content = contentFactory(i)
            ordersCards.append(Card(id: i, content: content))
        }
        print(ordersCards)
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = ordersCards.firstIndex(where: { $0.id == card.id}) {
            ordersCards[chosenIndex].wasOpened = true
            
        }
    }
    
    struct Card: Identifiable {
        let id: Int
        let content: CardContent
        var wasOpened = false
    }
}

