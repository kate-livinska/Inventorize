//
//  LoginService.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 06/02/2024.
//

import Foundation

class LoginService: NetworkBase {
    
    static var host: String { K.Networking.host }
    
    enum Endpoint: EndpointProtocol {
        case login
        
        var path: String {
            switch self {
            case .login: K.Networking.loginPath
            }
        }
    }
    
    enum Request: RequestProtocol {
        case login
        
        var method: String {
            switch self {
            case .login: "post"
            }
        }
        
        var value: String {
            switch self {
            case .login: ""
            }
        }
        
        var header: String {
            switch self {
            case .login: ""
            }
        }
    }
    
    
}
