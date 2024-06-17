//
//  ViewModel.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 14/06/2024.
//

import Foundation

@Observable
class ViewModel {
    var searchText = ""
    var selectedOrder: InventoryOrder?
    var isItemFound = false
    var isQuantity = false
}

