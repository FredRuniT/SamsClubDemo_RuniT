//
//  ProductDetailsCell.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/23/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import UIKit

class ProductDetailsCell: UICollectionViewCell {
    
    
    lazy var productBrandLabel: UILabel = {
        let productBrandLabel = UILabel()
        productBrandLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        productBrandLabel.adjustsFontSizeToFitWidth = true
        productBrandLabel.adjustsFontForContentSizeCategory = true
        productBrandLabel.numberOfLines = 2
        return productBrandLabel
    }()
    
    lazy var productNameLabel: UILabel = {
        let productNameLabel = UILabel()
        productNameLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        //TODO: Refactor into a method
        productNameLabel.adjustsFontSizeToFitWidth = true
        productNameLabel.adjustsFontForContentSizeCategory = true
        productNameLabel.numberOfLines = 2
        return productNameLabel
    }()
    
    lazy var numberOfStarsStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0..<5).forEach({ (_) in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arrangedSubviews.append(imageView)
        })
        
        arrangedSubviews.append(UIView())
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        return stackView
    }()
    
    lazy var productRatingCountLabel: UILabel = {
        let productRatingCountLabel = UILabel()
        productRatingCountLabel.adjustsFontForContentSizeCategory = true
        productRatingCountLabel.adjustsFontSizeToFitWidth = true
        return productRatingCountLabel
    }()
    
    lazy var productImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 2000).isActive = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    lazy var productShortDescriptionLabel: UILabel = {
        let productShortDescriptionLabel = UILabel()
        productShortDescriptionLabel.adjustsFontForContentSizeCategory = true
        productShortDescriptionLabel.adjustsFontSizeToFitWidth = true
        return productShortDescriptionLabel
    }()
    
    lazy var productSizeDecriptionLabel: UILabel = {
        let productSizeDecriptionLabel = UILabel()
        productSizeDecriptionLabel.adjustsFontForContentSizeCategory = true
        productSizeDecriptionLabel.adjustsFontSizeToFitWidth = true
        return productSizeDecriptionLabel
    }()
    
    lazy var productSizeLabel: UILabel = {
        let productSizeLabel = UILabel()
        productSizeLabel.adjustsFontForContentSizeCategory = true
        productSizeLabel.adjustsFontSizeToFitWidth = true
        return productSizeLabel
    }()
    
    lazy var productPriceLabel: UILabel = {
        let productPriceLabel = UILabel()
        productPriceLabel.adjustsFontForContentSizeCategory = true
        productPriceLabel.adjustsFontSizeToFitWidth = true
        return productPriceLabel
    }()
    
    lazy var productInstockLabel: UILabel = {
        let instockLabel = UILabel()
        instockLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        instockLabel.adjustsFontSizeToFitWidth = true
        instockLabel.adjustsFontForContentSizeCategory = true
        return instockLabel
    }()
    
    lazy var productLongDescriptionLabel: UILabel = {
        let productLongDescriptionLabel = UILabel()
        productLongDescriptionLabel.adjustsFontForContentSizeCategory = true
        productLongDescriptionLabel.adjustsFontSizeToFitWidth = true
        return productLongDescriptionLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let nameBrandStackView = UIStackView(arrangedSubviews: [productBrandLabel, productNameLabel])
        nameBrandStackView.spacing = 10
        nameBrandStackView.axis = .vertical
        
        let ratingsStackView = UIStackView(arrangedSubviews: [productRatingCountLabel, numberOfStarsStackView])
        ratingsStackView.spacing = 10
        ratingsStackView.axis = .horizontal
        
        let centerStackView = UIStackView(arrangedSubviews: [productImageView, productShortDescriptionLabel, productSizeDecriptionLabel, productSizeLabel, productPriceLabel, productLongDescriptionLabel])
        centerStackView.axis = .vertical
        centerStackView.spacing = 16
        
        let productDetailsStackView = VerticalStackView(arrangedSubviews: [nameBrandStackView, ratingsStackView, centerStackView], spacing: 10)
        
        addSubview(productDetailsStackView)
        productDetailsStackView.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
