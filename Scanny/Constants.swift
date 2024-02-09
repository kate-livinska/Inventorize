//
//  Constants.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 12/01/2024.
//

import Foundation

struct K {
    
    struct Networking {
        static let host = "http://127.0.0.1:5000"
        
        static let loginPath = "login"
        static let ordersPath = "orders"
    }
    
    struct Keychain {
        static let service = "Scanny"
        static let tokenKey = "SkannyToken"
    }
}

