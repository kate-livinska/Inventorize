//
//  DBRequestsManager.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 11/01/2024.
//

import Foundation

class NetworkManager<T: Codable> {
    
    func createRequest(path: String, method: String, value: String, header: String) -> URLRequest? {
        let host = K.Networking.host
        let requestURL = "https://\(host)/\(path)"
        
        guard let url = URL(string: requestURL) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue(value, forHTTPHeaderField: header)
        
        return request
    }
    
    func fetchData(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        let request = request
    
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                print("Error: \(error?.localizedDescription ?? "No data received.")")
                return
            }
            
            guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                print("Error: \(error?.localizedDescription ?? "Data decription failed.")")
                return
            }
            //interpret fetched data T in a separate func with corresponding data type in ViewModel
            completion(.success(result))
        }
        task.resume()
    }
}

