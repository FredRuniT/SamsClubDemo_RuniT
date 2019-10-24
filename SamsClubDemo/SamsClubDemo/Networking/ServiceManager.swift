//
//  ServiceManager.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/22/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import Foundation


class ServiceManager {
    
    //MARK: Singleton
    static let shared = ServiceManager()
    
     func fetchProductInventory(completion: @escaping (Result<Inventory, Error>) -> ()) {
        
        
        let urlString = "https://mobile-tha-server.firebaseapp.com/walmartproducts/1/8"
        guard let apiUrl = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: apiUrl) { (data, response, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            do {
                guard let data = data else {return}
                let inventory = try JSONDecoder().decode(Inventory.self, from: data)
                completion(.success(inventory))
                
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
}
