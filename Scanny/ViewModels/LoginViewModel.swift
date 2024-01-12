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
    @Published var token = ""
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
        
        networkManager.fetchData(request: request) { response in
            switch response {
            case .success(let response):
                let token = response.accessToken
                self.token = token
                print(token)
                self.fetchOrdersData(with: token)
            case .failure(let error):
                print("Error: Invalid credentials - \(error.localizedDescription)")
            }
        }
    }
    
    func fetchOrdersData(with token: String) {
        let networkManager = NetworkManager<OrderResults>()
        
        guard let request = networkManager.createRequest(
            path: K.Networking.ordersPath,
            method: "get",
            value: token,
            header: K.Networking.ordersHeader
        ) else {
            return
        }
        networkManager.fetchData(request: request) { response in
            switch response {
            case .success(let orders):
                self.orders = orders.results
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
