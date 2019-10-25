//
//  Extensions.swift
//  SamsClubDemo
//
//  Created by Fredrick Burns on 10/23/19.
//  Copyright © 2019 Fredrick Burns. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1, textColor: UIColor = .black, adjustsFontSizeToFitWidth: Bool = true, adjustFontContentCat: Bool = true) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = 2
        self.textColor = .label
        self.adjustsFontSizeToFitWidth = true
        self.adjustsFontForContentSizeCategory = true
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
}
