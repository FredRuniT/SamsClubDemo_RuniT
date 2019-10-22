//
//  BaseTabBarController.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/21/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavigationController(viewController: ProductListCollectionViewController(), title: "Products", imageName: UIImage(systemName: "square.grid.2x2")),
            createNavigationController(viewController: UIViewController(), title: "Saved Items", imageName: UIImage(systemName: "bookmark"))
        ]
    }
    
    //MARK: A function that creates a generic navigation controller for reuse.
    fileprivate func createNavigationController(viewController: UIViewController, title: String, imageName: UIImage!) -> UIViewController {
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = imageName
        return navigationController
    }
}
