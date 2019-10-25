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
        errorImageView.clipsToBounds = true
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
        self.clintErorrImageVIew.image = UIImage(named: "errorImage.jpg")
        self.serverErorrImageVIew.image = UIImage(named: "itsnotYouItsMe.jpeg")
        self.poorConnectionImageView.image = UIImage(named: "no_internet.jpg")
    }

}
