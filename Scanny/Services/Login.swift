//
//  Login.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 19/01/2024.
//

import Foundation

struct Login {
    var parameters: LoginRequest
    
    func call(completion: @escaping (LoginResponse) -> Void) {
        //create request with username, password
        guard var request = NetworkManager<LoginResponse>.createRequest(
            path: K.Networking.loginPath,
            method: "post",
            value: "",
            header: ""
        ) else {
            return
        }
        
        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch {
            print("Error: unable to encode request parameters")
        }
        
        //create task
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let data {
                let response = try? JSONDecoder().decode(LoginResponse.self, from: data)
                
                if let response {
                    completion(response)
                } else {
                    print("Error: unable to decode request parameters")
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
