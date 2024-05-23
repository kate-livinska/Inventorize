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
    var value: String { get }
    var header: String { get }
    var method: String { get }
}

enum NetworkServiceError: Error {
    case urlError
    case networkError
}

extension NetworkBase {

    static var host: String { K.Networking.host }
    
    static func post<Result: Codable>(
        _ type: Result.Type,
        body: Codable,
        endpoint: Endpoint,
        directory: String = "",
        request: Request
    ) async throws -> Result {
        let url = try url(for: endpoint)
        var urlRequest = urlRequest(with: url, request)
        urlRequest.httpBody = try JSONEncoder().encode(body)
        let result: Result = try await getData(urlRequest)
        
        return result
    }
    
    static func fetch<Result: Codable>(
        _ type: Result.Type,
        endpoint: Endpoint,
        directory: String = "",
        request: Request
    ) async throws -> Result {
        let url = try url(for: endpoint, directory: directory)
        let urlRequest = urlRequest(with: url, request)
        let result: Result = try await getData(urlRequest)
        
        return result
    }
    
    static func url(for endpoint: Endpoint, directory: String = "") throws -> URL {
        let urlString = "\(Self.host)/\(endpoint.path)\(directory)"
        print(urlString)
        guard let url = URL(string: urlString) else {
            throw NetworkServiceError.urlError
        }
        return url
    }
    //FIXME: - value header in post request for login not needed
    static func urlRequest(with url: URL, _ request: Request) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue(request.value, forHTTPHeaderField: request.header)
        
        return urlRequest
    }
    
    static func getData<Result: Codable>(_ urlRequest: URLRequest) async throws -> Result {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        let str = String(decoding: data, as: UTF8.self)
        print(str)
        
        //FIXME: - Error handling
        let message = response as? HTTPURLResponse
        guard message?.statusCode == 200 else {
            switch message?.statusCode {
            case 401:
                Auth.shared.logout()
                print("Authorization Error (401)")
            case 200:
                print("OK")
            default:
                print("Error while fetching data")
            }
            throw NetworkServiceError.networkError
        }
        //return only data
        let result = try JSONDecoder().decode(Result.self, from: data)
    
        return (result)
    }
}
