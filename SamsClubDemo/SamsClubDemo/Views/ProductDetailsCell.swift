//
//  ProductDetailsswift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/23/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import UIKit
import SDWebImage

class ProductDetailsCell: UICollectionViewCell {
    
    var product: Products?

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productInstockLabel: UILabel!
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBOutlet weak var productRatingCountLabel: UILabel!
    //@IBOutlet weak var productShortDescription: UILabel!
    @IBOutlet weak var productSizeDecriptionLabel: UILabel!
    @IBOutlet weak var productSizeLabel: UILabel!
    @IBOutlet weak var productLongDescriptionLabel: UITextView!
    
    
    @IBOutlet var starRatingStackView: UIStackView! = {
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.resetView()
    }
    func resetView() {
        //productImageView.image = nil
    }
    func configure(withProduct product: Products) {
        self.product = product
        self.update()
    }
    
    func update() {
        guard let product = self.product else {
            return
        }
        print("This is the productName \(product.productName)")
        
        
        let baseUrl = "https://mobile-tha-server.firebaseapp.com/"
        let imageUrl = URL(string: baseUrl + product.productImage)
        self.productImageView?.sd_setImage(with: imageUrl?.absoluteURL, completed: nil)
        
        productBrandLabel.text = product.productName
        productNameLabel.text = product.productName
        productPriceLabel.text = product.productName
        productRatingCountLabel.text = "\(product.reviewCount)"
        productImageView!.sd_setImage(with: imageUrl, completed: nil)
        productSizeLabel.text = ""
        productSizeDecriptionLabel.text = "Size"
        productSizeLabel.text = "TV Size"
        productLongDescriptionLabel.text = product.longDescription
        
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
    }
}
