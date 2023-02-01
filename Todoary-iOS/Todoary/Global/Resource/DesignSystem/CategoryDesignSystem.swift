//
//  CategoryDesignSystem.swift
//  Todoary
//
//  Created by 박소윤 on 2023/01/29.
//

import Foundation

enum CategoryType{
    case mainTodo //main만 카테고리 크기 다름
    case categoryTodo
    case `default`
}

struct CategoryPadding{
    let left: CGFloat
    let right: CGFloat
    let top: CGFloat
    let bottom: CGFloat
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
    
    var padding: CategoryPadding{
        switch self{
        case .categoryTodo:
            return CategoryPadding(left: 11, right: 11, top: 4, bottom: 3)
        default:
            return CategoryPadding(left: 16, right: 16, top: 5, bottom: 4)
        }
    }
    
    func getMainCategoryPadding(count: Int) -> CategoryPadding{
        switch count{
        case 1:
            return CategoryPadding(left: 7, right: 7, top: 4, bottom: 3)
        case 2:
            return CategoryPadding(left: 12, right: 12, top: 4, bottom: 3)
        case 3:
            return CategoryPadding(left: 10, right: 10, top: 4, bottom: 3)
        case 4:
            return CategoryPadding(left: 8, right: 8, top: 4, bottom: 3)
        case 5:
            return CategoryPadding(left: 6, right: 6, top: 4, bottom: 3)
        default:
            return CategoryPadding(left: 0, right: 0, top: 0, bottom: 0)
        }
    }
}


class CategoryTag: BaseView{
    
    private let type: CategoryType!
    private var color: UIColor!
    
    private let titleLabel = UILabel()
    
    init(type: CategoryType){
        self.type = type
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func style() {
        self.layer.cornerRadius = type.height / 2
        self.layer.borderWidth = 1
    }
    
    override func hierarchy() {
        self.addSubview(titleLabel)
    }
    
    override func layout() {
        titleLabel.snp.makeConstraints{
            $0.height.equalTo(type.height)
        }
        
        setPadding()
    }

    private func setPadding(){
        
        let padding = type == .mainTodo ? type.getMainCategoryPadding(count: titleLabel.text?.count ?? 0) : type.padding
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(padding.top)
            $0.leading.equalToSuperview().offset(padding.left)
            $0.trailing.equalToSuperview().offset(padding.right)
            $0.bottom.equalToSuperview().offset(padding.bottom)
        }
    }
    
    private func initialize() {
        titleLabel.setTypoStyleWithSingleLine(typoStyle: type.typo)
    }
    
    func bindingData(title: String, color: Int){
        
        self.color = UIColor.categoryColor[color]
        titleLabel.text = title
        
        setDeselectState()
        
        if(type == .mainTodo){
            setPadding()
        }
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
