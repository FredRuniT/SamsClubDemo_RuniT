//
//  Products.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/22/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import Foundation

//MARK - Inventory
struct Inventory: Decodable {
    let products: [Products]
    let totalProducts: Int
    let pageNumber: Int
    let pageSize: Int
    let statusCode: Int
}

//MARK: - Products
struct Products: Decodable {
    let productId: String
    let productName: String
    let shortDescription: String
    let longDescription: String
    let price: String
    let productImage: String
    var reviewRating: Float?
    let reviewCount: Int
    let inStock: Bool
}
