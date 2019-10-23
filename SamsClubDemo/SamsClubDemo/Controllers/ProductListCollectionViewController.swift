//
//  ProductListCollectionViewController.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/21/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import UIKit

private let reuseIdentifier = "productlistcell"

class ProductListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate var serviceManager = ServiceManager()
    fileprivate var productResults = [Products]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        serviceManager.getProducts { (result) in
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
        
        let productResult = productResults[indexPath.row]
        cell.productNameLabel.text = productResult.productName
        cell.productPriceLabel.text = productResult.price
        cell.productRatingLabel.text = String(productResult.reviewCount)
        
        if productResult.inStock {
            cell.productInstockLabel.text = "In Stock"
            cell.productInstockLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        } else {
            cell.productInstockLabel.text = "Out of Stock"
            cell.productInstockLabel.font = UIFont.italicSystemFont(ofSize: 14)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 120)
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
