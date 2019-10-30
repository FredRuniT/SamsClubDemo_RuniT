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
    
    var productListFooter = ProductLoadindFooter()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Products"
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let spashScreenVC = storyBoard.instantiateViewController(withIdentifier: "SplashScreenViewController") as! SplashScreenViewController
        self.navigationController?.view.addSubview(spashScreenVC.view)
        
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
}


