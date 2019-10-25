//
//  SwiftExtensions.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/24/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import UIKit


//TODO: Comment

extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
