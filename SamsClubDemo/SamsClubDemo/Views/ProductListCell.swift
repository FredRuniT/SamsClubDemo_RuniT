//
//  ProductListCell.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/21/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import Foundation
import UIKit

class ProductListCell: UICollectionViewCell {

    var product: Products! {
        didSet {
            productNameLabel.text = product.productName
            productPriceLabel.text = product.price
            productRatingLabel.text = String(product.reviewCount)
            let baseUrl = "https://mobile-tha-server.firebaseapp.com/"
            let imageUrl = URL(string: baseUrl + product.productImage)
            productImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "loadingPlaceHolderImageSmall"), options: .avoidAutoSetImage, completed: nil)
            productImageView.sd_setImage(with: imageUrl, completed: nil)
            
            if product.inStock {
                productInstockLabel.text = "In Stock"
            } else {
                productInstockLabel.text = "Out of Stock"
                productInstockLabel.font = UIFont.italicSystemFont(ofSize: 14)
            }
        }
    }
    
    lazy var productImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    lazy var productNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    lazy var productPriceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        priceLabel.textColor = .darkGray
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.adjustsFontForContentSizeCategory = true
        return priceLabel
    }()
    
    lazy var productInstockLabel: UILabel = {
        let instockLabel = UILabel()
        instockLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        instockLabel.adjustsFontSizeToFitWidth = true
        instockLabel.adjustsFontForContentSizeCategory = true
        return instockLabel
    }()
    
    lazy var productRatingLabel: UILabel = {
        let productRatingLabel = UILabel()
        productRatingLabel.adjustsFontSizeToFitWidth = true
        productRatingLabel.adjustsFontForContentSizeCategory = true
        return productRatingLabel
    }()
    
    lazy var viewProductButton: UIButton = {
        let viewProductButton = UIButton(type: .system)
        viewProductButton.setTitle("VIEW", for: .normal)
        viewProductButton.setTitleColor(.blue, for: .normal)
        viewProductButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        viewProductButton.layer.cornerRadius = 10
        viewProductButton.backgroundColor = UIColor(white: 0.90, alpha: 1)
        viewProductButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        viewProductButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return viewProductButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelsStackView = UIStackView(arrangedSubviews: [productNameLabel, productRatingLabel,productPriceLabel, productInstockLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 5
        
        let productStackView = UIStackView(arrangedSubviews: [productImageView, labelsStackView])
        productStackView.spacing = 10
        productStackView.alignment = .center
        
        addSubview(productStackView)
        productStackView.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
