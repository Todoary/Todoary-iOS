//
//  UITextField.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/04.
//

import UIKit

extension UITextField {

    //placeholder 색상 변경 함수
    func setPlaceholderColor(_ placeholderColor: UIColor = .todoaryGrey) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                .foregroundColor: placeholderColor,
                .font: font
            ].compactMapValues { $0 }
        )
    }
}
