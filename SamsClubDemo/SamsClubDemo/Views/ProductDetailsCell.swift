//
//  ProductDetailsCell.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/23/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import UIKit

class ProductDetailsCell: UICollectionViewCell {
    
    lazy var productImageView = UIImageView(cornerRadius: 0)
    
    lazy var productNameLabel = UILabel(text: "Product Name", font: .preferredFont(forTextStyle: .subheadline), numberOfLines: 2)
    
    lazy var productPriceLabel = UILabel(text: "$500", font: .systemFont(ofSize: 14, weight: .semibold), textColor: .gray)
    
    lazy var productInstockLabel = UILabel(text: "In Stock", font: .preferredFont(forTextStyle: .caption1))
    
    lazy var productRatingLabel = UILabel(text: "Rating", font: .preferredFont(forTextStyle: .caption1))
    
    lazy var productBrandLabel = UILabel(text: "Sony", font: .preferredFont(forTextStyle: .callout), textColor: .blue)
    
    lazy var productRatingCountLabel = UILabel(text: "10", font: .preferredFont(forTextStyle: .caption1))
    
    lazy var productShortDescription = UILabel(text: "White Glove Delivery Included", font: .preferredFont(forTextStyle: .caption1))
    
    lazy var productSizeDecriptionLabel = UILabel(text: "Size", font: .preferredFont(forTextStyle: .caption1))
    
    lazy var productSizeLabel = UILabel(text: "50 Inch", font: .preferredFont(forTextStyle: .headline))
    
    lazy var productLongDescriptionLabel = UILabel(text: "The Ellerton media console is well-suited for today&rsquo;s casual lifestyle. Its elegant style and expert construction will make it a centerpiece in any home. Soundly constructed, the Ellerton uses hardwood solids &amp; cherry veneers elegantly finished in a rich dark cherry finish. &nbsp;With ample storage for electronics &amp; media, it also cleverly allows for customization with three choices of interchangeable door panels", font: .preferredFont(forTextStyle: .caption1), textColor: .blue)
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let productDetailStackView = VerticalStackView(arrangedSubviews: [productImageView, productNameLabel, productPriceLabel, productInstockLabel, productRatingLabel, productBrandLabel , productRatingCountLabel, productShortDescription, productSizeLabel, productLongDescriptionLabel,  starRatingStackView], spacing: 10)
        
        addSubview(productDetailStackView)
        productDetailStackView.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
