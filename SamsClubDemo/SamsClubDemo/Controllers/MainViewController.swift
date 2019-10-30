//
//  MainViewController.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/21/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import UIKit
import SDWebImage
import Cosmos

fileprivate let productListCellId = "productListCellId"
fileprivate let footerID = "loadingfooterID"

class MainViewController: ProductListView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    fileprivate var serviceManager = ServiceManager()
    fileprivate var inventoryResults: Inventory?
    fileprivate var inventoryProducts = [Products]()
    fileprivate var productListView = ProductListView()
    fileprivate var isPaginating = false
    fileprivate var isDonePaginating = false
    var productPageNumber = 1
    private var layoutOption: LayoutOption = .list {
        didSet {
            setupLayout(with: view.bounds.size)
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.fetchData()
        
        //MARK - Register Loading Footer
        self.inventoryCollectionView.register(ProductLoadindFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID)
        setupLayout(with: view.bounds.size)
        
        self.layoutOption = .list
    }
    
    private func fetchData() {
        serviceManager.fetchInventoryData(pageNumber:  self.productPageNumber, pageItems: 15)
        { (result: Result<Inventory, APIServiceError>) in
            
            switch result {
                
            case .success(let inventoryItems):
                //TODO: Move this to network class!
                if inventoryItems.statusCode != 200 {
                    DispatchQueue.main.async {
                        self.inventoryCollectionView.backgroundView = self.errorImageView
                    }
                } 
                self.inventoryResults = inventoryItems
                self.inventoryProducts = inventoryItems.products
                
                DispatchQueue.main.async {
                self.inventoryCollectionView.reloadData()
                }
                
            case.failure(let err):
                print(err.localizedDescription)
                DispatchQueue.main.async {
                    self.inventoryCollectionView.backgroundView = self.errorImageView
    
                }
            }
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupLayout(with: size)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupLayout(with: view.bounds.size)
    }
    
    
    private func setupLayout(with containerSize: CGSize) {
        guard let flowLayout = self.inventoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        switch layoutOption {
        case .list:
            flowLayout.minimumInteritemSpacing = 10
            flowLayout.minimumLineSpacing = 10
            flowLayout.sectionInset = UIEdgeInsets(top: 8.0, left: 0, bottom: 8.0, right: 0)
            
            if traitCollection.horizontalSizeClass == .regular {
                let minItemWidth: CGFloat = 300
                let numberOfCell = containerSize.width / minItemWidth
                let width = floor((numberOfCell / floor(numberOfCell)) * minItemWidth)
                flowLayout.itemSize = CGSize(width: width, height: 130)
            } else {
                flowLayout.itemSize = CGSize(width: containerSize.width, height: 120)
            }
            
        }
        
        DispatchQueue.main.async {
            self.inventoryCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let loadingFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerID, for: indexPath)
        return loadingFooter
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let height: CGFloat = isDonePaginating ? 0 : 100
        return .init(width: view.frame.width, height: height)
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return inventoryProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productListCellId, for: indexPath) as! ProductListCell
        
        let productResult = inventoryProducts[indexPath.row]
        
        cell.configure(withProductResult: productResult)
        cell.cosmosView.rating = Double(productResult.reviewRating ?? 0.0)
        cell.backgroundColor = .secondarySystemBackground
        cell.layer.cornerRadius = 5
        
        
        //MARK: - Pagination Implementation
        if indexPath.item == (inventoryProducts.count) - 1 && !isPaginating {
            isPaginating = true
            serviceManager.fetchInventoryData(pageNumber:  self.productPageNumber, pageItems: 15) { (result: Result<Inventory, APIServiceError>) in
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
                        self.inventoryCollectionView.reloadData()
                    }
                    self.isPaginating = false
                    
                case.failure(let err):
                    print("Failed to fetch products", err)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productInventory = inventoryProducts[indexPath.item]
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        detailsVC.product = productInventory
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 20, height: 130)
    }
}
