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
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    let productNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        nameLabel.text = "Samsung 50 Inch TV"
        return nameLabel
    }()
    
    let productPriceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = ""
        priceLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        priceLabel.textColor = .darkGray
        priceLabel.adjustsFontForContentSizeCategory = true
        return priceLabel
    }()
    
    let productInstockLabel: UILabel = {
        let instockLabel = UILabel()
        instockLabel.text = ""
        instockLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return instockLabel
    }()
    
    let productRatingLabel: UILabel = {
        let productRatingLabel = UILabel()
        productRatingLabel.text = ""
        productRatingLabel.adjustsFontForContentSizeCategory = true
        return productRatingLabel
    }()

    let viewProductButton: UIButton = {
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
        
        let productStackView = UIStackView(arrangedSubviews: [productImageView, labelsStackView, viewProductButton,])
        productStackView.spacing = 10
        productStackView.alignment = .center

        addSubview(productStackView)
        productStackView.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
