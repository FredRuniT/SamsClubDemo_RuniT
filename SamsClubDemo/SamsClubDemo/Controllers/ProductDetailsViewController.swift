//
//  ProductDetailsViewController.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/24/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import UIKit
import SDWebImage

class ProductDetailsViewController: UIViewController {

    var product: Products?
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productInstockLabel: UILabel!
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBOutlet weak var productRatingCountLabel: UILabel!
    //@IBOutlet weak var productShortDescription: UILabel!
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
        
        productBrandLabel.text = product.productName.components(separatedBy: " ").first
        productNameLabel.text = product.productName
        productPriceLabel.text = product.price
        productRatingCountLabel.text = "\(product.reviewCount)"
        print(product)
        productImageView!.sd_setImage(with: imageUrl, completed: nil)
        productLongDescriptionLabel.text = product.longDescription
        
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
            if self.productLongDescriptionLabel.isHidden {
                self.productLongDescriptionLabel.alpha = 0
            } else {
                 self.productLongDescriptionLabel.alpha = 1
            }
        }
    }
}
