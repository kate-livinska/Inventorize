//
//  OrderList.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 12/01/2024.
//

//import Foundation
//
//struct OrdersList<CardContent> where CardContent: Equatable {
//    private(set) var ordersCards: [Card] = []
//    
//    init(ordersNumber: Int, contentFactory: (Int) -> CardContent) {
//        for i in 0..<ordersNumber {
//            let content = contentFactory(i)
//            ordersCards.append(Card(id: i, content: content))
//        }
//        print(ordersCards)
//    }
//    
//    var chosenOrderId: CardContent?
//    
//    mutating func choose(_ card: Card) {
//        if let chosenIndex = ordersCards.firstIndex(where: { $0.id == card.id}) {
//            ordersCards[chosenIndex].wasOpened = true
//            chosenOrderId = ordersCards[chosenIndex].content
//            print(ordersCards[chosenIndex])
//        }
//    }
//    
//    struct Card: Identifiable {
//        let id: Int
//        let content: CardContent
//        var wasOpened = false
//    }
//}

