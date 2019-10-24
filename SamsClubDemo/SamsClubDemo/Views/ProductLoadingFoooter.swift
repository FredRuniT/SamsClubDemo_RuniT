//
//  ProductLoadingFoooter.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/24/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import Foundation
import UIKit

class ProductLoadindFooter: UICollectionReusableView {
    
    let activityView = UIActivityIndicatorView(style: .large)
    let activityLoadingLabel = UILabel(text: "Loading Products", font: .systemFont(ofSize: 16))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //TODO: Use Walmart Color
        let loadingStackView = VerticalStackView(arrangedSubviews: [activityView, activityLoadingLabel], spacing: 10)
        
        self.activityLoadingLabel.textAlignment = .center
        self.activityView.color = .darkGray
        self.activityView.startAnimating()
        
        addSubview(loadingStackView)
        loadingStackView.centerInSuperview(size: .init(width: 200, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
