import UIKit
import SDWebImage
import Cosmos

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
    @IBOutlet weak var reviewRatings: CosmosView!
    
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
        
        setUpReviewUi()
        productBrandLabel.text = product.productName?.components(separatedBy: " ").first
        productNameLabel.attributedText = product.productName?.htmlToAttributedString
        productPriceLabel.text = product.price
        productImageView.sd_setImage(with: imageUrl, completed: nil)
        productLongDescriptionLabel.attributedText = product.longDescription?.htmlToAttributedString
        productShortDescription.attributedText = product.shortDescription?.htmlToAttributedString
        productInstockLabel.text = product.inStock! ? "In Stock" :"Out of Stock"
        setUpReviewUi()
    }
    
    fileprivate func setUpReviewUi() {
        reviewRatings.settings.updateOnTouch = false
        reviewRatings.settings.totalStars = 5
        reviewRatings.rating = Double(product?.reviewRating ?? 0.0)
        reviewRatings.text = "\(product?.reviewCount ?? 0)"
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
