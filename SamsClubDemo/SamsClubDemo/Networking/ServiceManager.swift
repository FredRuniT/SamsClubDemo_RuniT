//
//  ServiceManager.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/22/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import Foundation


class ServiceManager {
    
    //MARK - Reusable Service Manager
    static let shared = ServiceManager()
    let BASE_URL = "https://mobile-tha-server.firebaseapp.com/walmartproducts"
    
    func fetchInventoryData<T: Decodable>(pageNumber: Int, pageItems: Int, completion: @escaping (Result<T, APIServiceError>) -> ()) {
        guard let apiUrl = URL(string: "\(BASE_URL)/\(pageNumber)/\(pageItems)") else {return}
        print(apiUrl)
        
        URLSession.shared.dataTask(with: apiUrl) { (result) in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                self.statusCodeChecker(responseStatus: statusCode)
                
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
    
    func getBaseImageUrl(imagId: String) -> String {
        //REMOTE CONFIG
        let baseImageUrl = "https://mobile-tha-server.firebaseapp.com/"
        return baseImageUrl
    }
    
    func statusCodeChecker(responseStatus: Int) {
        
        if responseStatus != 200  {
            DispatchQueue.main.async {
                
                let productListView = ProductListView()
                productListView.inventoryCollectionView.backgroundView = productListView.errorImageView
            }
        }
    }
}
