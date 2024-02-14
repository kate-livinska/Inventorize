//
//  Constants.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 12/01/2024.
//

import Foundation

struct K {
    
    struct Networking {
        static let host = "https://82f9935fcf1c.websafety.ninja/api"
        
        static let loginPath = "auth"
        static let ordersPath = "orders"
    }
    
    struct Keychain {
        static let service = "Scanny"
        static let tokenKey = "SkannyToken"
    }
}

