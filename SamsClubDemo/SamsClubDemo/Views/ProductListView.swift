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
    lazy var clintErorrImageVIew: UIImageView = {
        let errorImageView = UIImageView()
        errorImageView.fillSuperview()
        errorImageView.contentMode = .scaleAspectFit
        errorImageView.clipsToBounds = true
        return errorImageView
    }()
    
    lazy var serverErorrImageVIew: UIImageView = {
        let errorImageView = UIImageView()
        errorImageView.fillSuperview()
        errorImageView.contentMode = .scaleAspectFit
        //errorImageView.clipsToBounds = true
        return errorImageView
    }()
    
    lazy var poorConnectionImageView: UIImageView = {
           let poorConnectionImageView = UIImageView()
           poorConnectionImageView.fillSuperview()
           poorConnectionImageView.contentMode = .scaleAspectFit
    
           poorConnectionImageView.clipsToBounds = true
           return poorConnectionImageView
       }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Products"
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let spashScreenVC = storyBoard.instantiateViewController(withIdentifier: "SlashViewController") as! SlashViewController
        self.navigationController?.view.addSubview(spashScreenVC.view)
        
        self.inventoryCollectionView.backgroundColor = .systemBackground

        //TODO: Provide Use cases
        self.clintErorrImageVIew.image = UIImage(named: "errorImage.jpg")
        self.serverErorrImageVIew.image = UIImage(named: "itsnotYouItsMe")
        self.poorConnectionImageView.image = UIImage(named: "no_internet.jpg")
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


