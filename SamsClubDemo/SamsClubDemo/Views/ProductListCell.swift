//
//  ProductListCell.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/21/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class ProductListCell: UICollectionViewCell {
    
    var product: Products?
    let productDetailsVC = ProductDetailsViewController()
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productInstockLabel: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var productNameLabel: UILabel!
    
    
    func configure(withProductResult product: Products) {
        self.product = product
        configureProductCell()
    }
    
    func configureProductCell() {
        guard let product = self.product else {
            return
        }
        
        let baseUrl = ServiceManager.shared.getbaseUrlString(imagId: product.productImage)
        let imageUrl = URL(string: baseUrl + product.productImage)
        
        self.productImageView.sd_setImage(with: imageUrl, completed: nil)
        

        self.productNameLabel.attributedText = product.productName?.htmlToAttributedString
        self.productNameLabel.textColor = .label
        self.productNameLabel.numberOfLines = 0
        
        self.productNameLabel.adjustsFontForContentSizeCategory = true
        self.productPriceLabel.text = product.price
        self.productInstockLabel.text = product.inStock ?? false ? "In Stock" :"Out of Stock"
        
        self.productPriceLabel.font = .preferredFont(forTextStyle: .callout)
        self.productNameLabel.font = .preferredFont(forTextStyle: .subheadline)
        self.productInstockLabel.font = .preferredFont(forTextStyle: .footnote)
    }
}
