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
        
        loggedIn = true
    }
    
    func logout() {
        try? KeychainManager.deleteToken()
        loggedIn = false
    }
}

//    func createLoginRequest(username: String, password: String) -> URLRequest? {
//        guard var request = NetworkManager<LoginResponse>.createRequest(
//            path: K.Networking.loginPath,
//            method: "post",
//            value: "application/json",
//            header: "Content-Type"
//        ) else {
//            return nil
//        }
//
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//        let credentials = LoginRequest(username: username, password: password)
//        do {
//            request.httpBody = try JSONEncoder().encode(credentials)
//        } catch {
//            print("Error: unable to encode request parameters")
//        }
//
//        return request
//    }
//
//
//    //FIXME:
//    static func receiveToken(with request: URLRequest) {
//        NetworkManager<LoginResponse>.fetchData(request: request) { response in
//            switch response {
//            case .success(let response):
//                if let safeToken = response.token {
//                    print("receiveToken \(response.token), \(response.message)")
//                    KeychainManager.saveToKeychain(key: K.Keychain.tokenKey, password: safeToken)
//                    print("Token saved fetchData: \(safeToken)")
//                } else {
//                    print("Error: \(response.message ?? "Token not obtained.")")
//                }
//            case .failure(let error):
//                print("Error: Invalid credentials. \(error.localizedDescription)")
//            }
//        }
//
//        return token
//    }
//
//    static func getAuthorization() {
//        var validToken: String
//
//        guard let token = KeychainManager.getToken() else {
//            print("Failed to obtain token from Keychain")
//            return nil
//        }
//
//        print("Token obtained from Keychain: \(token)")
//
//        if isValidToken(token) {
//            validToken = token
//            print("Token valid")
//        } else {
//            do {
//                try KeychainManager.deleteToken()
//            } catch {
//                print("Error deleting token")
//            }
//            return nil
//        }
//
//        return validToken
//
//        func isValidToken(_ token: String) -> Bool {
//            var isValid = false
//
//            if let request = NetworkManager<OrderResults>.createRequest(
//                path: K.Networking.ordersPath,
//                method: "get",
//                value: "Bearer \(token)",
//                header: K.Networking.ordersHeader
//            ) {
//                NetworkManager<OrderResults>.getResponse(request: request) { response in
//                    var statusCode = 0
//                    switch response {
//                    case .success(let response):
//                        if let response = response as? HTTPURLResponse {
//                            statusCode = response.statusCode
//                            print("Obtained status code: \(statusCode)")
//                        }
//                    case .failure(let error):
//                        print("Error while getting status code: \(error.localizedDescription)")
//                    }
//                    switch statusCode {
//                    case 200:
//                        isValid = true
//                    default:
//                        isValid = false
//                        print("Token is invalid. \(statusCode)")
//                    }
//                }
//            }
//            return isValid
//        }
//    }
