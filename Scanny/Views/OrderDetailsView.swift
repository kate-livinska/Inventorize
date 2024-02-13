//
//  OrderDetailsView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 13/02/2024.
//

import SwiftUI

struct OrderDetailsView: View {
    var order: OrdersList<Order>.Card
    
    var body: some View {
        VStack {
            Text(order.content.name)
                .font(.title)
        }
        
    }
}

#Preview {
    OrderDetailsView(order: Scanny.OrdersList<Scanny.Order>.Card(id: 0, content: Scanny.Order(id: 80429, name: "Order f037qVAbOiHCLA")))
}
