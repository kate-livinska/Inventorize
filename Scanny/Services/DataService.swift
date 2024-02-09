//
//  DataService.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 25/01/2024.
//

import Foundation

class DataService: NetworkBase, ObservableObject {
    static let shared = DataService()
    @Published var fetchedOrders = [Order]()
   
    enum Endpoint: EndpointProtocol {
        case orders
        //case items
        
        var path: String {
            switch self {
            case .orders: K.Networking.ordersPath
            //case .items:
            }
        }
    }
    
    enum Request: RequestProtocol {
        case orders
        
        var method: String {
            switch self {
            case .orders: "get"
            }
        }
        
        var value: String {
            switch self {
            case .orders:
                guard let token = KeychainManager.getToken() else {
                    print("Could not obtain token from Keychain")
                    return "0"
                }
                return "Bearer \(token)"
            }
        }
        
        var header: String {
            switch self {
            case .orders: "Authorization"
            }
        }
    }
}



//private func fetchOrdersData() {
//    guard let token = KeychainManager.getToken() else {
//        Auth.shared.logout()
//        return
//    }
//    
//    guard let request = NetworkManager<OrderResults>.createRequest(
//        path: K.Networking.ordersPath,
//        method: "get",
//        value: "Bearer \(token)",
//        header: "Authorization"
//    ) else {
//        print("Failed to create fetchOrdersData request")
//        return
//    }
//
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        guard let data else {
//            print("Error NWM.fetchdata data: \(error?.localizedDescription ?? "No data received.")")
//            return
//        }
//        guard let response else {
//            print("Error NWM.getResponse: \(error?.localizedDescription ?? "No response for token received.")")
//            return
//        }
//        if let response = response as? HTTPURLResponse {
//            print("Obtained status code: \(response.statusCode)")
//            switch response.statusCode {
//            case 401:
//                Auth.shared.logout()
//            default:
//                print("Data received")
//            }
//        }
//        
//        guard let result = try? JSONDecoder().decode(OrderResults.self, from: data) else {
//            print("Error NWM.fetchdata result: \(error?.localizedDescription ?? "Data decription failed.")")
//            return
//        }
//        let str = String(decoding: data, as: UTF8.self)
//        print(str)
//        //interpret fetched data T in a separate func with corresponding data type in ViewModel
//        DispatchQueue.main.async {
//            self.fetchedOrders = result.results
//            self.ordersAreFetched = true
//        }
//    }
//    task.resume()
//    //sleep(2)
//}
