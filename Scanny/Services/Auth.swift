//
//  Auth.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 18/01/2024.
//

import Foundation

class Auth: ObservableObject {
    static let shared = Auth()
    @Published var loggedIn = false
    
    init() {
        loggedIn = hasAccessToken()
    }
    
    func hasAccessToken() -> Bool {
        return getToken() != nil
    }
    
    func getToken() -> String? {
        KeychainManager.getToken()
    }
    
    func setToken(token: String) {
        try? KeychainManager.deleteToken()
        KeychainManager.saveToKeychain(key: K.Keychain.tokenKey, password: token)
        DispatchQueue.main.async {
            self.loggedIn = true
        }
    }
    
    func logout() {
        try? KeychainManager.deleteToken()
        loggedIn = false
    }
}
