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
    fileprivate var inventoryResults: Inventory?
    fileprivate var inventoryProducts = [Products]()
    fileprivate var isPaginating = false
    fileprivate var isDonePaginating = false
    var productPageNumber = 1
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.fetchData()
        
        //TODO: Move to View Model
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
        serviceManager.fetchInventoryData(urlString:  "https://mobile-tha-server.firebaseapp.com/walmartproducts/\(productPageNumber)/15") { (result: Result<Inventory, APIServiceError>) in
            
            switch result {
                
            case .success(let inventoryItems):
                self.inventoryResults = inventoryItems
                self.inventoryProducts = inventoryItems.products
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
        let height: CGFloat = isDonePaginating ? 0 : 100
        return .init(width: view.frame.width, height: height)
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return inventoryProducts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductListCell
        //TODO: REFactor Out
        
        let productResult = inventoryProducts[indexPath.row]
        
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
        
        if indexPath.item == (inventoryProducts.count) - 1 && !isPaginating {
            //TODO: Mark Up
            isPaginating = true
            serviceManager.fetchInventoryData(urlString:  "https://mobile-tha-server.firebaseapp.com/walmartproducts/\(productPageNumber)/15") { (result: Result<Inventory, APIServiceError>) in
                switch result {
                    
                case .success(let inventoryItems):
                    if inventoryItems.products.count == 0 {
                        self.isDonePaginating = true
                    }
                    
                    sleep(2)
                    self.inventoryProducts += inventoryItems.products
                    
                    if (self.inventoryProducts.count > 30) {
                        self.productPageNumber += 1
                    }
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    self.isPaginating = false
                    
                case.failure(let err):
                    //TODO Show Meaningful Message
                    print("Failed to fetch products", err)
                }
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productInventory = inventoryResults?.products[indexPath.item]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        detailsVC.product = productInventory
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //TODO: REFactor Out
        let productResult = inventoryProducts[indexPath.row]
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
}
