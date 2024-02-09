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
}

enum NetworkServiceError: Error {
    case urlError
    case networkError
}

extension NetworkBase {

    static var host: String { K.Networking.host }
    
    func post<Result: Codable>(
        _ type: Result.Type,
        body: Codable,
        endpoint: Endpoint,
        request: Request
    ) async throws -> (data: Result, response: Int) {
        let url = try url(for: endpoint)
        let urlRequest = urlRequest(with: url, request, body)
        let result: (data: Result, response: Int) = try await getData(urlRequest)
        
        return result
    }
    
    func fetch<Result: Codable>(
        _ type: Result.Type,
        endpoint: Endpoint,
        request: Request
    ) async throws -> (data: Result, response: Int) {
       
        let urlString = "\(Self.host)/\(endpoint.path)"
        print(urlString)
        guard let url = URL(string: urlString) else {
            throw NetworkServiceError.urlError
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "get"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue(request.value, forHTTPHeaderField: request.header)
        
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        let str = String(decoding: data, as: UTF8.self)
        print(str)
        
        //FIXME: - Error handling
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkServiceError.networkError}
        //return only data
        let result = try JSONDecoder().decode(Result.self, from: data)
        let message = response as? HTTPURLResponse
    
        return (result, message?.statusCode ?? 0)
    }
    
    func url(for endpoint: Endpoint, directory: String = "") throws -> URL {
        let urlString = "\(Self.host)/\(endpoint.path)\(directory)"
        print(urlString)
        guard let url = URL(string: urlString) else {
            throw NetworkServiceError.urlError
        }
        return url
    }
    
    func urlRequest(with url: URL, _ request: Request) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue(request.value, forHTTPHeaderField: request.header)
        
        return urlRequest
    }
    
    func urlRequest(with url: URL, _ request: Request, _ body: Codable) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue(request.value, forHTTPHeaderField: request.header)
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(body)
        } catch {
            print("Error: unable to encode request parameters")
        }
        
        return urlRequest
    }
    
    func getData<Result: Codable>(_ urlRequest: URLRequest) async throws -> (data: Result, response: Int) {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        let str = String(decoding: data, as: UTF8.self)
        print(str)
        
        //FIXME: - Error handling
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkServiceError.networkError}
        //return only data
        let result = try JSONDecoder().decode(Result.self, from: data)
        let message = response as? HTTPURLResponse
    
        return (result, message?.statusCode ?? 0)
    }
}

//    func fetch<Result: Codable>(
//        _ type: Result.Type,
//        endpoint: Endpoint,
//        request: Request
//    ) async throws -> Result {
//
//        let urlString = "\(Self.host)/\(endpoint.path)"
//        print(urlString)
//        guard let url = URL(string: urlString) else {
//            throw NetworkServiceError.urlError
//        }
//
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = request.method
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
//        urlRequest.addValue(request.value, forHTTPHeaderField: request.header)
//
//        let (data, _) = try await URLSession.shared.data(for: urlRequest)
//        let result = try JSONDecoder().decode(Result.self, from: data)
//
//        return result
//    }
