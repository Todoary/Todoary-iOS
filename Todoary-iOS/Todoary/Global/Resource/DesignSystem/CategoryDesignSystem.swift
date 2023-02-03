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
            return .main_category
        default:
            return .todo_category
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
            switch self.titleLabel.text?.count{
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
            
            titleLabel.snp.makeConstraints{
                $0.top.equalToSuperview().offset(padding.top)
                $0.leading.equalToSuperview().offset(padding.left)
                $0.trailing.equalToSuperview().offset(padding.right)
                $0.bottom.equalToSuperview().offset(padding.bottom)
            }
        }
        
        
    }

    class CategoryTodoCategoryTag: CategoryTagView, CustomCategoryTag{
        
        var padding: CategoryPadding! = CategoryPadding(left: 11, right: 11, top: 4, bottom: 3)
        
        internal required init() {
            super.init(type: .categoryTodo)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layout() {
            super.layout()
            setPadding()
        }
        
    }

    class DefaultCategoryTag: CategoryTagView, CustomCategoryTag{
        
        var padding: CategoryPadding! = CategoryPadding(left: 16, right: 16, top: 5, bottom: 4)
        
        internal required init() {
            super.init(type: .default)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layout() {
            super.layout()
            setPadding()
        }
        
        func setSelectState(){
            titleLabel.textColor = .white
            self.backgroundColor = color
        }
        
        func setDeselectState(){
            titleLabel.textColor = color
            self.backgroundColor = .white
            self.layer.borderColor = color.cgColor
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
    func setPadding(){
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(padding.top)
            $0.leading.equalToSuperview().offset(padding.left)
            $0.trailing.equalToSuperview().offset(padding.right)
            $0.bottom.equalToSuperview().offset(padding.bottom)
        }
    }
}


class CategoryTagView: BaseView{
    
    var color: UIColor!
    private let type: CategoryType
    let titleLabel = UILabel()
    
    init(type: CategoryType){
        self.type = type
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func style() {
        self.layer.cornerRadius = type.height / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
        
        self.titleLabel.setTypoStyleWithSingleLine(typoStyle: type.typo)
    }
    
    override func hierarchy() {
        self.addSubview(titleLabel)
    }
    
    override func layout() {
        titleLabel.snp.makeConstraints{
            $0.height.equalTo(type.height)
        }
    }
    
    func bindingData(title: String, color: Int){
        self.titleLabel.text = title
        self.titleLabel.textColor = UIColor.categoryColor[color]
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
