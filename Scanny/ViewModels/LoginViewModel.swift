//
//  LoginViewModel.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 09/01/2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username = "kate@gmail.com"
    @Published var password = "QnyUl42TEn2DsWxs"
    
    func login() {
        let loginService = LoginService()
        let temporaryUsername = "kate"
        print(temporaryUsername, password)
        //FIXME: - Fix username format to email on backend?
        Task {
            do {
                let response = try await loginService.post(
                    LoginResponse.self,
                    body: LoginRequest(username: temporaryUsername, password: password),
                    endpoint: .login,
                    request: .login
                )
                Auth.shared.setToken(token: response.token)
                print(response.token)
                DataService.shared.fetchOrders()
            } catch {
                print("Error: API request failed. \(error.localizedDescription)")
            }
        }
        
    }
}
