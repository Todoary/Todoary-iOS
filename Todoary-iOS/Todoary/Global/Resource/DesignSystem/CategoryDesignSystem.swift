//
//  CategoryDesignSystem.swift
//  Todoary
//
//  Created by 박소윤 on 2023/01/29.
//

import Foundation

enum CategoryType{
    case mainTodo
    case categoryTodo
    case `default`
}

extension CategoryType{
    
    var height: CGFloat{
        switch self{
        case .mainTodo, .categoryTodo:
            return 21
        default:
            return 25
        }
    }
    
    var typo: TypoStyle{
        switch self{
        case .mainTodo, .categoryTodo:
            return .bold12
        default:
            return .bold14
        }
    }
}

class CategoryTag{
    
    static func generateForMainTodo() -> MainTodoCategoryTag{
        return MainTodoCategoryTag()
    }
    
    static func generateForCategoryTodo() -> CategoryTodoCategoryTag{
        return CategoryTodoCategoryTag()
    }
    
    static func generateForDefault() -> DefaultCategoryTag{
        return DefaultCategoryTag()
    }
    
    static func estimatedSize(_ title: String) -> CGSize{
        let label = DefaultCategoryTag().then{
            $0.setTitle(title, for: .normal)
        }
        let width = (label.titleLabel?.intrinsicContentSize.width)! + (label.padding.left + label.padding.right)
        let height = (label.titleLabel?.intrinsicContentSize.height)! + (label.padding.top
                                                          + label.padding.bottom)
        return CGSize(width: width, height: height)
    }
}

extension CategoryTag{
    
    struct CategoryPadding{
        let left: CGFloat
        let right: CGFloat
        let top: CGFloat
        let bottom: CGFloat
    }
    
    class MainTodoCategoryTag: CategoryTagView, CustomCategoryTag{
        
        var padding: CategoryPadding!
        
        internal required init() {
            super.init(type: .mainTodo)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func bindingData(title: String, color: Int) {
            super.bindingData(title: title, color: color)
            setPadding()
        }
        
        private func setPadding() {
            switch self.titleLabel?.text?.count{
            case 1:
                padding = CategoryPadding(left: 7, right: 7, top: 4, bottom: 3)
            case 2:
                padding = CategoryPadding(left: 12, right: 12, top: 4, bottom: 3)
            case 3:
                padding = CategoryPadding(left: 10, right: 10, top: 4, bottom: 3)
            case 4:
                padding = CategoryPadding(left: 8, right: 8, top: 4, bottom: 3)
            case 5:
                padding = CategoryPadding(left: 6, right: 6, top: 4, bottom: 3)
            default:
                padding = CategoryPadding(left: 0, right: 0, top: 0, bottom: 0)
            }
            
            setContentInset()
        }
        
        
    }

    class CategoryTodoCategoryTag: CategoryTagView, CustomCategoryTag{
        
        var padding: CategoryPadding! = CategoryPadding(left: 11, right: 11, top: 4, bottom: 3)
        
        internal required init() {
            super.init(type: .categoryTodo)
            setContentInset()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }

    class DefaultCategoryTag: CategoryTagView, CustomCategoryTag{
        
        var padding: CategoryPadding! = CategoryPadding(left: 16, right: 16, top: 5, bottom: 4)
        
        internal required init() {
            super.init(type: .default)
            setContentInset()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setSelectState(){
            self.setTitleColor(.white, for: .normal)
            self.backgroundColor = color
        }
        
        func setDeselectState(){
            self.setTitleColor(color, for: .normal)
            self.backgroundColor = .white
            self.layer.borderColor = color.cgColor
        }
        
        func initialize(){
            self.setTitle("", for: .normal)
            self.setTitleColor(.transparent, for: .normal)
            self.layer.borderColor = UIColor.transparent.cgColor
            self.backgroundColor = .transparent
        }
        
        override func bindingData(title: String, color: Int) {
            super.bindingData(title: title, color: color)
            setDeselectState()
        }
    
    }
}

protocol CustomCategoryTag{
    init()
    var padding: CategoryTag.CategoryPadding! { get set }
}

extension CustomCategoryTag where Self: CategoryTagView{
    
    func setContentInset(){
        
        self.snp.makeConstraints{
            $0.width.equalTo(self.titleLabel!).offset(padding.left + padding.right)
            $0.height.equalTo(self.titleLabel!).offset(padding.top + padding.bottom)
        }
        
        self.contentEdgeInsets = UIEdgeInsets(top: padding.top,
                                              left: padding.left,
                                              bottom: padding.bottom,
                                              right: padding.right)
        
        /*
        self.configuration?.contentInsets = NSDirectionalEdgeInsets(top: padding.top,
                                                                    leading: padding.left,
                                                                    bottom: padding.bottom,
                                                                    trailing: padding.right)
         */
    }
}

class CategoryTagView: UIButton{
    
    var color: UIColor!
    private let type: CategoryType
    
    init(type: CategoryType){
        self.type = type
        super.init(frame: .zero)
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style(){
        self.titleLabel?.textAlignment = .center
        self.backgroundColor = .white
        self.layer.cornerRadius = type.height / 2
        self.layer.borderWidth = 1
        
        self.titleLabel?.setTypoStyleWithSingleLine(typoStyle: type.typo)
    
        self.isUserInteractionEnabled = false
    }
    
    func bindingData(title: String, color: Int){
        
        self.setTitle(title, for: .normal)
        self.color = UIColor.categoryColor[color]
        
        self.setTitleColor(self.color, for: .normal)
        self.layer.borderColor = self.color.cgColor
    }
}

//MARK: - UILabel Typo method
extension UILabel {
    
    func setTypoStyle(font: UIFont, kernValue: Double, lineSpacing: CGFloat) {
        if let labelText = text, labelText.count > 0, let attributedText = self.attributedText {

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.maximumLineHeight = lineSpacing
            paragraphStyle.minimumLineHeight = lineSpacing
            
            
             let attributedString = NSMutableAttributedString(attributedString: attributedText)
            
            attributedString.addAttributes([.font:font,
                                                .kern:kernValue,
                                                .paragraphStyle: paragraphStyle,
                                                .baselineOffset: (lineSpacing - font.lineHeight) / 4
            ], range: NSRange(location: 0,
                              length: attributedString.length))
            
            self.attributedText = attributedString
        }
    }
    
    func setTypoStyleWithSingleLine(typoStyle: TypoStyle) {
        
        if(self.text == nil){
            self.text = " "
        }
        
        let font = typoStyle.font
        let kernValue = typoStyle.labelDescription.kern

        if let labelText = text, labelText.count > 0, let attributedText = self.attributedText {
            
             let attributedString = NSMutableAttributedString(attributedString: attributedText)
            
            attributedString.addAttributes([.font:font,
                                            .kern:kernValue],
                                           range: NSRange(location: 0,
                                                          length: attributedString.length))
            
            self.attributedText = attributedString
        }
    }
    
    func setTypoStyleWithMultiLine(typoStyle: TypoStyle) {
        
        if(self.text == nil){
            self.text = " "
        }
        
        let font = typoStyle.font
        let kernValue = typoStyle.labelDescription.kern
        let lineSpacing = typoStyle.labelDescription.lineHeight

        if let labelText = text, labelText.count > 0, let attributedText = self.attributedText {

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.maximumLineHeight = lineSpacing
            paragraphStyle.minimumLineHeight = lineSpacing
            
             let attributedString = NSMutableAttributedString(attributedString: attributedText)
            
            attributedString.addAttributes([.font:font,
                                            .kern:kernValue,
                                            .paragraphStyle: paragraphStyle,
                                            .baselineOffset: (lineSpacing - font.lineHeight) / 4
            ], range: NSRange(location: 0,
                              length: attributedString.length))
            
            self.attributedText = attributedString
        }
    }
}
