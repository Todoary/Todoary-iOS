//
//  ShadowDesignSystem.swift
//  Todoary
//
//  Created by 박소윤 on 2023/02/17.
//

import Foundation

class ShadowView: BaseView{
    
    private let cornerRadius: CGFloat
    
    init(cornerRadius: CGFloat){
        self.cornerRadius = cornerRadius
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func style(){
        self.backgroundColor = .white
        self.layer.shadowRadius = 10.0
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
    }
}
