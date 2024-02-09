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
        let loginService = LoginService()
        Task {
            do {
                let response = try await loginService.post(
                    LoginResponse.self,
                    body: LoginRequest(username: username, password: password),
                    endpoint: .login,
                    request: .login
                ).data
                Auth.shared.setToken(token: response.token)
            } catch {
                print("Error: API request failed. \(error.localizedDescription)")
            }
        }
        
    }
}

//class LoginViewModel: ObservableObject {
//    @Published var username = "admin@x.com"
//    @Published var password = "password"
//    
//    func login() {
//        Login(
//            parameters: LoginRequest(
//                username: username,
//                password: password
//            )
//        ).call { response in
//            Auth.shared.setToken(token: response.token)
//        }
//    }
//}
