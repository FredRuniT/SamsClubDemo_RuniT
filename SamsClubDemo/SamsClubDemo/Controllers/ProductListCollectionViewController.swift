//
//  ProductListCollectionViewController.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/21/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "productlistcell"

class ProductListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate var serviceManager = ServiceManager()
    fileprivate var productResults = [Products]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        serviceManager.fetchProductInventory { (result) in
            switch result {
                
            case .success(let inventoryItems):
                self.productResults = inventoryItems.products
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            case.failure(let err):
                //TODO Show Meaningful Message
                print("Failed to fetch products", err)
            }
        }
        
        // Register cell classes
        self.collectionView!.register(ProductListCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.productResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductListCell
        //TODO: REFactor Out
        let productResult = productResults[indexPath.row]
        let baseUrl = "https://mobile-tha-server.firebaseapp.com/"
        let imageUrl = URL(string: baseUrl + productResult.productImage)
        
        cell.productNameLabel.text = productResult.productName
        cell.productPriceLabel.text = productResult.price
        cell.productImageView.sd_setImage(with: imageUrl, completed: nil)
        
        if productResult.inStock {
            cell.productInstockLabel.text = "In Stock"
        } else {
            cell.productInstockLabel.text = "Out of Stock"
            cell.productInstockLabel.font = UIFont.italicSystemFont(ofSize: 14)
        }
        
        for (index, view) in cell.starRatingStackView.arrangedSubviews.enumerated() {
            if productResult.reviewCount == 0 {
                cell.starRatingStackView.isHidden = true
            }
            view.alpha = index >= productResult.reviewCount ? 0 : 1
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //TODO: REFactor Out
        let productResult = productResults[indexPath.row]
        let cell = ProductListCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 150))
        
        let baseUrl = "https://mobile-tha-server.firebaseapp.com/"
        let imageUrl = URL(string: baseUrl + productResult.productImage)
        
        cell.productNameLabel.text = productResult.productName
        cell.productPriceLabel.text = productResult.price
        cell.productImageView.sd_setImage(with: imageUrl, completed: nil)
        
        if productResult.inStock {
            cell.productInstockLabel.text = "In Stock"
        } else {
            cell.productInstockLabel.text = "Out of Stock"
            cell.productInstockLabel.font = UIFont.italicSystemFont(ofSize: 14)
        }
        for (index, view) in cell.starRatingStackView.arrangedSubviews.enumerated() {
            view.alpha = index >= productResult.reviewCount ? 0 : 1
        }
        cell.layoutIfNeeded()
        let estimatedSize = cell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 150))
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
}
