//
//  OrderState.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 14/03/2024.
//

import Foundation

class OrderState: ObservableObject {
    static var shared = OrderState()
    @Published var openedOrders = [Int]()
}
