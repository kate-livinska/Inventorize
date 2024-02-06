//
//  NetworkBase.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 06/02/2024.
//

import Foundation

protocol NetworkBase {
    associatedtype Endpoint: EndpointProtocol
    associatedtype Request: RequestProtocol
    static var host: String { get }
}

protocol EndpointProtocol {
    var path: String { get }
}

protocol RequestProtocol {
    var method: String { get }
    var value: String { get }
    var header: String { get }
}

enum NetworkServiceError: Error {
    case urlError
}

extension NetworkBase {
    func fetch<Result: Codable>(
        _ type: Result.Type,
        endpoint: Endpoint,
        request: Request
    ) async throws -> Result {
       
        let urlString = "\(Self.host)/\(endpoint.path)"
        print(urlString)
        guard let url = URL(string: urlString) else {
            throw NetworkServiceError.urlError
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue(request.value, forHTTPHeaderField: request.header)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let result = try JSONDecoder().decode(Result.self, from: data)
        
        return result
    }
    
    func fetchToken<Result: Codable>(
        _ type: Result.Type,
        credentials: LoginRequest,
        endpoint: Endpoint,
        request: Request
    ) async throws -> Result {
       
        let urlString = "\(Self.host)/\(endpoint.path)"
        print(urlString)
        guard let url = URL(string: urlString) else {
            throw NetworkServiceError.urlError
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue(request.value, forHTTPHeaderField: request.header)
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(credentials)
        } catch {
            print("Error: unable to encode request parameters")
        }
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let str = String(decoding: data, as: UTF8.self)
        print(str)
        let result = try JSONDecoder().decode(Result.self, from: data)
        
        return result
    }
}
