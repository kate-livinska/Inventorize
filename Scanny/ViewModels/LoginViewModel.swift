//
//  LoginViewModel.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 09/01/2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    
    func login() {
        LoginManager(
            parameters: LoginRequest(
                username: username,
                password: password)
        ).call {response in
        //Login successful, navigate to Home screen
            print("Access token", response.data.accessToken)
        }
    }
}
