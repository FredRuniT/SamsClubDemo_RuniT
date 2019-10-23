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
    
    
    lazy var productImageView = UIImageView(cornerRadius: 0)
    
    lazy var productNameLabel = UILabel(text: "Product Name", font: .preferredFont(forTextStyle: .subheadline), numberOfLines: 2)
    
    lazy var productPriceLabel = UILabel(text: "$500", font: .systemFont(ofSize: 14, weight: .semibold), textColor: .gray)
    
    lazy var productInstockLabel = UILabel(text: "In Stock", font: .preferredFont(forTextStyle: .caption1))
    
    lazy var productRatingLabel = UILabel(text: "Rating", font: .preferredFont(forTextStyle: .caption1))
    
    lazy var starRatingStackView: UIStackView = {
        
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
        
        let labelsStackView = UIStackView(arrangedSubviews: [productNameLabel, starRatingStackView,productPriceLabel, productInstockLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 5
        
        let productStackView = UIStackView(arrangedSubviews: [productImageView, labelsStackView])
        productStackView.spacing = 10
        productStackView.alignment = .center
        
        addSubview(productStackView)
        productStackView.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 20))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
