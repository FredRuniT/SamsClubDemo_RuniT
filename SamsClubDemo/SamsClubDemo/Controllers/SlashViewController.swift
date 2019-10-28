//
//  SplashView.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/26/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import UIKit

class SlashViewController: UIViewController {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var fadeInLogoImage: UIImageView!
     @IBOutlet weak var connectedTextlabel: UILabel!
    var productListVC = MainViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showSplashAnimation()
        }
    }
    
    fileprivate func showSplashAnimation() {
        //MARK: - Adding a simple animation upon launcing the App
        UIView.animate(withDuration: 1.0, animations: {
            self.logoImageView.frame.origin.y -= 150
            self.connectedTextlabel.frame.origin.y -= -40
            self.view.layoutIfNeeded()
            
        }) { (true) in
            self.fadeInLogoImage.alpha = 1
            self.view.fadeOut()
            self.productListVC.navigationController?.isNavigationBarHidden = false
        }
    }
}
