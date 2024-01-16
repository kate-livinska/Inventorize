//
//  LoginViewModel.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 09/01/2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    var username = ""
    var password = ""
    @Published var isAuthenticated = false
    @Published var orders = [Order]()
    
    func login() {
        let networkManager = NetworkManager<LoginResponse>()
        
        guard var request = networkManager.createRequest(
            path: K.Networking.loginPath,
            method: "post",
            value: "application/json",
            header: "Content-Type"
        ) else {
            return
        }
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let credentials = LoginRequest(username: username, password: password)
        do {
            request.httpBody = try JSONEncoder().encode(credentials)
        } catch {
            //Error: unable to encode request parameters
            print("Error: unable to encode request parameters")
            
        }
        
        saveToKeychain(key: username, password: password)
        
        networkManager.fetchData(request: request) { response in
            switch response {
            case .success(let response):
                let token = response.token
                self.saveToKeychain(key: "SkannyToken", password: token)
            case .failure(let error):
                print("Error: Invalid credentials - \(error.localizedDescription)")
            }
        }
    }
    
    func saveToKeychain(key: String, password: String) {
        let passwordAsData = password.data(using: .utf8) ?? Data()
        do {
            try KeychainManager.save(
                service: "Scanny",
                account: key,
                password: passwordAsData)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    //must be not in the Login but in scanny model /or orderlist model?
    
}
