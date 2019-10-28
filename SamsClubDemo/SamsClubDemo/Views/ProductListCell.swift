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
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productInstockLabel: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!

    
    
//    lazy var productImageView = UIImageView(cornerRadius: 0)
//
//    lazy var productNameLabel = UILabel(text: "", font: .preferredFont(forTextStyle: .subheadline), numberOfLines: 2)
//
//    lazy var productPriceLabel = UILabel(text: "", font: .systemFont(ofSize: 14, weight: .semibold), textColor: .label)
//
//    lazy var productInstockLabel = UILabel(text: "", font: .preferredFont(forTextStyle: .caption1))
    

    
    lazy var viewProductImage: UIImageView = {
        let viewProductImage = UIImageView()
        viewProductImage.image = (UIImage(systemName: "cart.badge.plus"))
        viewProductImage.contentMode = .scaleAspectFit
        viewProductImage.constrainWidth(constant: 30)
        viewProductImage.constrainHeight(constant: 30)
        return viewProductImage
    }()
    
    func configure(withProductResult product: Products) {
        self.product = product
        configureUI()
    }
    
    func configureUI() {
        guard let product = self.product else {
            return
        }
        
        cosmosView.settings.updateOnTouch = false
               cosmosView.settings.totalStars = 5
               cosmosView.settings.starSize = 16
               cosmosView.settings.starMargin = 3
               cosmosView.settings.fillMode = .precise
               cosmosView.settings.textMargin = 5
               cosmosView.settings.textColor = .label
        
        let baseUrl = ServiceManager.shared.getbaseUrlString(imagId: product.productImage)
        let imageUrl = URL(string: baseUrl + product.productImage)
        
        self.productImageView.sd_setImage(with: imageUrl, completed: nil)
        

        
        self.productNameLabel.text = product.productName
        self.productPriceLabel.text = product.price
        self.productInstockLabel.text = product.inStock ?? false ? "In Stock" :"Out of Stock"
        
        productPriceLabel.textColor = .label
        productPriceLabel.font = .preferredFont(forTextStyle: .callout)
        productNameLabel.font = .preferredFont(forTextStyle: .callout)
        productInstockLabel.font = .preferredFont(forTextStyle: .footnote)
        

    }
}
