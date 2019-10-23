//
//  ProductDetailsCollectionViewController.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/23/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "productdetailscell"

class ProductDetailsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate var serviceManager = ServiceManager()
    fileprivate var inventory:  Inventory?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white

        // Register cell classes
        self.collectionView!.register(ProductDetailsCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.fetchData()

        // Do any additional setup after loading the view.
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

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductDetailsCell
    
        let productDetail = inventory?.products[indexPath.row]
        cell.productNameLabel.text = productDetail?.productName
        let baseUrl = "https://mobile-tha-server.firebaseapp.com/"
        let imageUrl = URL(string: baseUrl + productDetail!.productImage)
        cell.productImageView.sd_setImage(with: imageUrl, completed: nil)
        return cell
    }
}
