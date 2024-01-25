//
//  DataService.swift
//  Scanny
//
//  Created by Ekaterina Livinska on 25/01/2024.
//

import Foundation

class DataService: ObservableObject {
    static let shared = DataService()
    @Published var fetchedOrders = [Order]()
    
    init() {
        if let fetchedOrders = fetchOrdersData() {
            self.fetchedOrders = fetchedOrders
            print("Orders fetched by data service")
        }
    }
    
    private func fetchOrdersData() -> [Order]? {
        var fetchedOrders: [Order] = []
        
        guard let token = KeychainManager.getToken() else {
            Auth.shared.logout()
            return nil
        }
        
        guard let request = NetworkManager<OrderResults>.createRequest(
            path: K.Networking.ordersPath,
            method: "get",
            value: "Bearer \(token)",
            header: "Authorization"
        ) else {
            print("Failed to create fetchOrdersData request")
            return nil
        }
        
//        NetworkManager<OrderResults>.fetchData(request: request) { response in
//            switch response {
//            case .success(let orders):
//                fetchedOrders = orders.results
//            case .failure(let error):
//                print("Error: \(error.localizedDescription)")
//            }
//        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                print("Error NWM.fetchdata data: \(error?.localizedDescription ?? "No data received.")")
                return
            }
            guard let response else {
                print("Error NWM.getResponse: \(error?.localizedDescription ?? "No response for token received.")")
                return
            }
            if let response = response as? HTTPURLResponse {
                print("Obtained status code: \(response.statusCode)")
            }
            
            guard let result = try? JSONDecoder().decode(OrderResults.self, from: data) else {
                print("Error NWM.fetchdata result: \(error?.localizedDescription ?? "Data decription failed.")")
                return
            }
            let str = String(decoding: data, as: UTF8.self)
            print(str)
            //interpret fetched data T in a separate func with corresponding data type in ViewModel
            fetchedOrders = result.results
            
        }
        task.resume()
        sleep(2)
        return fetchedOrders
    }
}
