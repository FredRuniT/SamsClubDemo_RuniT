//
//  ProductListCollectionViewController.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/21/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import UIKit
import SDWebImage

fileprivate let reuseIdentifier = "productlistcell"
fileprivate let footerID = "loadingfooterID"

class ProductListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate var serviceManager = ServiceManager()
    fileprivate var inventory: Inventory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchData()
        
        collectionView.backgroundColor = .white

        // Register cell classes
        self.collectionView!.register(ProductListCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        //Register Footer
        collectionView.register(ProductLoadindFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchData() {
        serviceManager.fetchProductInventory { (result) in
            switch result {
                
            case .success(let inventoryItems):
                self.inventory = inventoryItems
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            case.failure(let err):
                //TODO Show Meaningful Message
                print("Failed to fetch products", err)
            }
        }
    }
    

    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let loadingFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerID, for: indexPath)
        return loadingFooter
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return inventory?.products.count ?? 0
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductListCell
        //TODO: REFactor Out
        
        if let inventory = self.inventory?.products  {
            
             let productResult = inventory[indexPath.row]
            
            let baseUrl = "https://mobile-tha-server.firebaseapp.com/"
            let imageUrl = URL(string: baseUrl + productResult.productImage)
            
            cell.productNameLabel.text = productResult.productName
            cell.productPriceLabel.text = productResult.price
            cell.productImageView.sd_setImage(with: imageUrl, completed: nil)
            
            if productResult.inStock ?? false {
                cell.productInstockLabel.text = "In Stock"
            } else {
                cell.productInstockLabel.text = "Out of Stock"
            }
            
            for (index, view) in cell.starRatingStackView.arrangedSubviews.enumerated() {
                if productResult.reviewCount == 0 {
                    cell.starRatingStackView.isHidden = true
                }
                view.alpha = index >= productResult.reviewCount ?? 0 ? 0 : 1
            }
            
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productInventory = inventory?.products[indexPath.item]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        detailsVC.product = productInventory
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         if let inventory = self.inventory  {
        //TODO: REFactor Out
        let productResult = inventory.products[indexPath.row]
        let cell = ProductListCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 150))
        
        let baseUrl = "https://mobile-tha-server.firebaseapp.com/"
        let imageUrl = URL(string: baseUrl + productResult.productImage)
        
        cell.productNameLabel.text = productResult.productName
        cell.productPriceLabel.text = productResult.price
        cell.productImageView.sd_setImage(with: imageUrl, completed: nil)
        
            if productResult.inStock ?? false {
            cell.productInstockLabel.text = "In Stock"
        } else {
            cell.productInstockLabel.text = "Out of Stock"
            cell.productInstockLabel.font = UIFont.italicSystemFont(ofSize: 14)
        }
        for (index, view) in cell.starRatingStackView.arrangedSubviews.enumerated() {
            view.alpha = index >= productResult.reviewCount ?? 0 ? 0 : 1
        }
        cell.layoutIfNeeded()
        let estimatedSize = cell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 150))
        
        return .init(width: view.frame.width, height: estimatedSize.height)
        }
        return CGSize()
    }
}
