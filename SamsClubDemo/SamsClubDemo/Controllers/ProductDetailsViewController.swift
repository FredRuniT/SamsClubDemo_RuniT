//
//  ProductDetailsViewController.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/24/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftSoup

class ProductDetailsViewController: UIViewController {
    
    var product: Products?
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productInstockLabel: UILabel!
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBOutlet weak var productRatingCountLabel: UILabel!
    @IBOutlet weak var productShortDescription: UILabel!
    @IBOutlet weak var productLongDescriptionLabel: UILabel!
    @IBOutlet weak var showFullDescriptonButton: UIButton!
    
    
    
    @IBOutlet weak var starRatingStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func configure(withProduct product: Products) {
        self.product = product
        self.update()
    }
    
    func update() {
        guard let product = self.product else {
            return
        }
        let baseUrl = "https://mobile-tha-server.firebaseapp.com/"
        let imageUrl = URL(string: baseUrl + product.productImage)
        self.productImageView?.sd_setImage(with: imageUrl?.absoluteURL, completed: nil)
        let nonFormatedTextLongDescription = product.longDescription
        guard let longTextDoc: Document = try? SwiftSoup.parse(nonFormatedTextLongDescription) else { return } // parse html
        guard let formatedTextLongDescription = try? longTextDoc.text() else { return }
        
        let nonFormatedShortDescription = product.longDescription
        guard let shortTextDoc: Document = try? SwiftSoup.parse(nonFormatedShortDescription) else { return } // parse html
        guard let formatedShortDescription = try? shortTextDoc.text() else { return }
        
        productBrandLabel.text = product.productName.components(separatedBy: " ").first
        productNameLabel.text = product.productName
        productPriceLabel.text = product.price
        productRatingCountLabel.text = "\(product.reviewCount)"
        productImageView.sd_setImage(with: imageUrl, completed: nil)
        productShortDescription.text = formatedShortDescription
        productLongDescriptionLabel.text = formatedTextLongDescription
        
        
        var arrangedSubviews = [UIView]()
        
        (0..<5).forEach({ (_) in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arrangedSubviews.append(imageView)
        })
        arrangedSubviews.append(UIView())
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        self.starRatingStackView.addSubview(stackView)
        
        for (index, view) in starRatingStackView.arrangedSubviews.enumerated() {
            if product.reviewCount == 0 {
                starRatingStackView.isHidden = true
            }
            view.alpha = index >= product.reviewCount ? 0 : 1
        }
        
        if product.inStock {
            productInstockLabel.text = "In Stock"
        } else {
            productInstockLabel.text = "Out of Stock"
            productInstockLabel.font = UIFont.italicSystemFont(ofSize: 14)
        }
        view.addSubview(starRatingStackView)
    }
    
    @IBAction func showFullDecription ( _sender: UIButton) {
        UIView.animate(withDuration: 0.8) {
            self.productLongDescriptionLabel.isHidden.toggle()
            self.productShortDescription.isHidden.toggle()
            if self.productLongDescriptionLabel.isHidden {
                 self.showFullDescriptonButton.setTitle("Show Full Product Description", for: .normal)
                self.productLongDescriptionLabel.alpha = 0
                self.productShortDescription.alpha = 1
            } else {
                self.showFullDescriptonButton.setTitle("Hide Product Description", for: .normal)
                self.productLongDescriptionLabel.alpha = 1
                self.productShortDescription.alpha = 0
            }
        }
    }
}
