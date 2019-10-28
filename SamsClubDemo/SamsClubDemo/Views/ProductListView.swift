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
    var productListFooter = ProductLoadindFooter()
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Products"
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let spashScreenVC = storyBoard.instantiateViewController(withIdentifier: "SlashViewController") as! SlashViewController
        self.navigationController?.view.addSubview(spashScreenVC.view)
        
        //loadingErrorImageView.fillSuperview()
        self.inventoryCollectionView.backgroundColor = .systemBackground
//        productListFooter.configureLoadingFooter()
        //TODO: Provide Use cases
//        self.clintErorrImageVIew.image = UIImage(named: "errorImage.jpg")
//        self.serverErorrImageVIew.image = UIImage(named: "itsnotYouItsMe.jpeg")
//        self.poorConnectionImageView.image = UIImage(named: "no_internet.jpg")
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
}


