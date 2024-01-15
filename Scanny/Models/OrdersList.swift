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
    
    func getToken() -> String? {
        guard let data = KeychainManager.get(
            service: "Scanny",
            account: "SkannyToken"
        ) else {
            print("Error: Failed to obtain token.")
            return nil
        }
        let token = String(decoding: data, as: UTF8.self)
        return token
    }
    
    struct Card {
        let id: String
        let content: CardContent
        var wasOpened = false
    }
}

