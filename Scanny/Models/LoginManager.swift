//
//  LoginManager.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 09/01/2024.
//

import Foundation

struct LoginManager {
    var parameters: LoginRequest
    
    func call(completion: @escaping (LoginResponse) -> Void) {
        let host = "base_url"
        let loginURL = "https://\(host)/login"
        
        guard let url = URL(string: loginURL) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "post"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch {
            //Error: unable to encode request parameters
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let data {
                let response = try? JSONDecoder().decode(LoginResponse.self, from: data)
                
                if let response {
                    completion(response)
                } else {
                    // Error: unable to decode response JSON
                }
            } else {
                //Error: API request failed
                if let error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
