//
//  ProductListViewModel.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/25/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import Foundation
import UIKit

class ProductListView: UIViewController {
    
    @IBOutlet weak var inventoryCollectionView: UICollectionView!
    @IBOutlet weak var errorImageView: UIImageView!
    
    let productListCellId = "productListCellId"
    let footerID = "loadingfooterID"
    var productListFooter = ProductLoadindFooter()
    var layoutOption: LayoutOption = .list {
        didSet {
            setupLayout(with: view.bounds.size)
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "Products"
        
        setUpSplashAnimation()
        
        //MARK - Register Loading Footer
        self.inventoryCollectionView.register(ProductLoadindFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID)
        setupLayout(with: view.bounds.size)
        
        self.inventoryCollectionView.backgroundColor = .systemBackground
        
        //TODO: Provide Use cases
        self.errorImageView.image = UIImage(named: "itsnotYouItsMe")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setUpSplashAnimation() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let spashScreenVC = storyBoard.instantiateViewController(withIdentifier: "SplashScreenViewController") as! SplashScreenViewController
        self.navigationController?.view.addSubview(spashScreenVC.view)
    }
    
    func setupLayout(with containerSize: CGSize) {
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
    }
}


