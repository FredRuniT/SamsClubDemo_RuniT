//
//  ProductDetailsView.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/30/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import UIKit
import Cosmos

class ProductDetailsView: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productInstockLabel: UILabel!
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBOutlet weak var productShortDescription: UILabel!
    @IBOutlet weak var productLongDescriptionLabel: UILabel!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var reviewRatings: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          navigationController?.navigationBar.prefersLargeTitles = false
    }
}
