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
    fileprivate var inventory:  Inventory?
    var didSelectHandler: ((Products) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        // Register cell classes
        self.collectionView!.register(ProductListCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.fetchData()
    }
    
    fileprivate func fetchData() {
        serviceManager.getProducts { (result) in
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
        
        return self.inventory?.products.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let product = inventory?.products[indexPath.item] {
            didSelectHandler?(product)
           didSelectHandler = { [weak self] productResult in
                       
                       let controller = ProductDetailsCollectionViewController()
                       controller.navigationItem.title = productResult.productName
                       self?.navigationController?.pushViewController(controller, animated: true)
                       
                   }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductListCell
        let productResult = inventory?.products[indexPath.item]
        cell.product = productResult
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let productResult = inventory?.products[indexPath.item]
        let listCell = ProductListCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 300))
        listCell.product = productResult
        let estimatedSize = listCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 300))
        
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
}
