//
//  ProductDetailViewModel.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/29/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import UIKit
import SDWebImage
import Cosmos

class ProductDetailViewModel: ProductDetailsView {
    
    var product: Products?
    var pageIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func configure(withProduct product: Products) {
        self.product = product
        self.configureUIElements()
    }
    
    func configureUIElements() {
        guard let product = self.product else {
            return
        }
        setUpReviewUi()
        
        let baseUrl = "https://mobile-tha-server.firebaseapp.com/"
        let imageUrl = URL(string: baseUrl + product.productImage)
        productImageView.sd_setImage(with: imageUrl, completed: nil)
        productImageView.layer.cornerRadius = 10
        productImageView.clipsToBounds = true
        
        
        productBrandLabel.text = product.productName?.components(separatedBy: " ").first
        productNameLabel.attributedText = product.productName?.htmlToAttributedString
        productLongDescriptionLabel.attributedText = product.longDescription?.htmlToAttributedString
        productShortDescription.attributedText = product.shortDescription?.htmlToAttributedString
        productInstockLabel.text = product.inStock ?? false ? "In Stock" :"Out of Stock"
        productPriceLabel.text = product.price
        
        productShortDescription.textColor = .label
        productLongDescriptionLabel.textColor = .label
        productNameLabel.textColor = .label
        productLongDescriptionLabel.backgroundColor = .secondarySystemBackground
        
        productShortDescription.font = .preferredFont(forTextStyle: .body)
        productPriceLabel.font = .preferredFont(forTextStyle: .headline)
        productInstockLabel.font = .preferredFont(forTextStyle: .callout)
        productNameLabel.font = .preferredFont(forTextStyle: .headline)
        productLongDescriptionLabel.font = .preferredFont(forTextStyle: .body)
        productLongDescriptionLabel.layer.cornerRadius = 10
        productLongDescriptionLabel.clipsToBounds = true
        
    }
    
    fileprivate func setUpReviewUi() {
        reviewRatings.settings.updateOnTouch = false
        reviewRatings.settings.totalStars = 5
        reviewRatings.rating = Double(product?.reviewRating ?? 0.0)
        reviewRatings.text = "\(product?.reviewCount ?? 0)"
        reviewRatings.settings.textFont = .preferredFont(forTextStyle: .callout)
    }
    
}
