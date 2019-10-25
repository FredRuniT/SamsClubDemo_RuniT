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
    //TODO: Comment
    static let shared = ServiceManager()
    
    func fetchInventoryData<T: Decodable>(urlString: String, completion: @escaping (Result<T, APIServiceError>) -> ()) {
        
        guard let apiUrl = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: apiUrl) { (result) in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let inventory = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(inventory))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure( _):
                completion(.failure(.apiError))
            }
        }.resume()
    }
}
