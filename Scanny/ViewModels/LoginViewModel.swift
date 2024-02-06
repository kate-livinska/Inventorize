//
//  LoginViewModel.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 09/01/2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username = "admin@x.com"
    @Published var password = "password"
    
    func login() {
        Login(
            parameters: LoginRequest(
                username: username,
                password: password
            )
        ).call { response in
            Auth.shared.setToken(token: response.token)
        }
    }
}

//func login() {
//    KeychainManager.saveToKeychain(key: username, password: password)
//    print("Saved to keychain: \(password)")
//    
//    guard let loginRequest = Auth.createLoginRequest(
//        username: username,
//        password: password
//    ) else {
//        print("Error creating request while sending login data.")
//        return
//    }
//    
//    if let token = Auth.receiveToken(with: loginRequest) {
//        print("LoginVM token to save in Keychain: \(token)")
//        KeychainManager.saveToKeychain(key: K.Keychain.tokenKey, password: token)
//    }
//    
//}
