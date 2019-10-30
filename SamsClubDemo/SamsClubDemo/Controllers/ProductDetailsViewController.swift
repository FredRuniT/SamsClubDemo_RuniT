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
    @IBOutlet weak var productShortDescription: UILabel!
    @IBOutlet weak var productLongDescriptionLabel: UILabel!
    @IBOutlet weak var showFullDescriptonButton: UIButton!
    @IBOutlet weak var reviewRatings: CosmosView!
    
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

    }
    
    fileprivate func setUpReviewUi() {
        reviewRatings.settings.updateOnTouch = false
        reviewRatings.settings.totalStars = 5
        reviewRatings.rating = Double(product?.reviewRating ?? 0.0)
        reviewRatings.text = "\(product?.reviewCount ?? 0)"
        reviewRatings.settings.textFont = .preferredFont(forTextStyle: .callout)
    }
    
    @IBAction func showFullDecription ( _sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.productLongDescriptionLabel.isHidden.toggle()
            if self.productLongDescriptionLabel.isHidden {
                self.showFullDescriptonButton.setTitle("Show Full Product Description", for: .normal)
                self.productLongDescriptionLabel.alpha = 0
                self.productShortDescription.alpha = 1
            } else {
                self.showFullDescriptonButton.setTitle("Hide Product Description", for: .normal)
                self.productLongDescriptionLabel.alpha = 1
            }
        }
    }
}
