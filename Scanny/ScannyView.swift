//
//  ContentView.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 09/01/2024.
//

import SwiftUI

struct ScannyView: View {
    @ObservedObject var scannyVM: ScannyViewModel
    
    var body: some View {
        if !scannyVM.isTokenAvailable {
            LoginView()
        } else {
            orders
        }
    }
    
    var orders: some View {
        ForEach(scannyVM.orders) { order in
            OrderView(order)
                .padding(4)
                .onTapGesture {
                    scannyVM.choose(order)
                }
        }
    }
}

struct OrderView: View {
    let order: Scanny<Order>.Card
    
    init(_ order: Scanny<Order>.Card) {
        self.order = order
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 5)
            base.strokeBorder(lineWidth: 1)
            Text(order.content.id)
                .font(.system(size: 17))
                .foregroundStyle(order.wasOpened ? .gray : .blue)
                .fontWeight(order.wasOpened ? .light : .bold)
                .padding()
        }
    }
}

#Preview {
    ScannyView(scannyVM: ScannyViewModel())
}
