//
//  DBRequestsManager.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 11/01/2024.
//

import Foundation

class NetworkManager<T: Codable> {
    
    static func createRequest(path: String, method: String, value: String, header: String) -> URLRequest? {
        let host = K.Networking.host
        let requestURL = "\(host)/\(path)"
        print(requestURL)
        
        guard let url = URL(string: requestURL) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(value, forHTTPHeaderField: header)
        
        return request
    }
    
    static func fetchData(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        let request = request
    
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                print("Error NWM.fetchdata data: \(error?.localizedDescription ?? "No data received.")")
                return
            }
            
            guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                print("Error NWM.fetchdata result: \(error?.localizedDescription ?? "Data decription failed.")")
                return
            }
            //interpret fetched data T in a separate func with corresponding data type in ViewModel
            completion(.success(result))
        }
        task.resume()
    }
}

//    static func getResponse(request: URLRequest, completion: @escaping (Result<URLResponse, Error>) -> Void) {
//        let request = request
//
//        let task = URLSession.shared.dataTask(with: request) { _, response, error in
//            guard let response else {
//                print("Error NWM.getResponse: \(error?.localizedDescription ?? "No response for token received.")")
//                return
//            }
//            completion(.success(response))
//        }
//        task.resume()
//    }
