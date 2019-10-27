//
//  ProductListViewModel.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/25/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import Foundation
import UIKit

class ProductListViewModel: UIViewController {
    
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    @IBOutlet weak var loadingErrorImageView: UIImageView!
    var productListFooter = ProductLoadindFooter()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadingErrorImageView.fillSuperview()
        self.topRatedCollectionView.backgroundColor = .systemBackground
//        productListFooter.configureLoadingFooter()
        //TODO: Provide Use cases
//        self.clintErorrImageVIew.image = UIImage(named: "errorImage.jpg")
//        self.serverErorrImageVIew.image = UIImage(named: "itsnotYouItsMe.jpeg")
//        self.poorConnectionImageView.image = UIImage(named: "no_internet.jpg")
    }
    
}


