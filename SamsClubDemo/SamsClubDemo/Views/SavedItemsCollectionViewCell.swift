//
//  SavedItemsCollectionViewCell.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/21/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import UIKit

class SavedItemsCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          backgroundColor = .blue
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
}
