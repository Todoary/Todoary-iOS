//
//  UIAlertController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/04.
//

import UIKit

extension UIAlertController {

    func setTitle(font: UIFont? = UIFont.nbFont(type: .alert)) {
        
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)
        
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font: titleFont],
                                          range: NSRange(location: 0, length: title.count))
        }
        
        self.setValue(attributeString, forKey: "attributedTitle")
        
    }

}
