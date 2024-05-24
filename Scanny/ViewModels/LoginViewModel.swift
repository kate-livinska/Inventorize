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
        Task {
            do {
                let response = try await LoginService.post(
                    LoginResponse.self,
                    body: LoginRequest(username: username, password: password),
                    endpoint: .login,
                    request: .login
                )
                Auth.shared.setToken(token: response.token)
                print(response.token)
            } catch {
                print("Error: API request failed. \(error.localizedDescription)")
            }
        }
        
    }
}
