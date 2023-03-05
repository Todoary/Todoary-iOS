//
//  DiaryResultModel.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/17.
//

import Foundation

struct DiaryResultModel: Codable{
    let diaryId: Int
    var title: String
    var content: String
    let createdDate: String
    
    var content15AttributedString: NSAttributedString?{
    
        let data = Data(content.utf8)
        
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            return attributedString
        }
        return nil
    }
    
    var content12AttributedString: NSAttributedString?{
    
        let data = Data(self.summaryCellContent.utf8)
            
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                return attributedString
            }
        return nil
    }
    
    //SummaryVC Cell에서 사용할 폰트 12 사이즈의 text
    var summaryCellContent: String{
        /*
         font: 15.0px
         font-size: 15.00px
         */
        var changeText = self.content.replacingOccurrences(of: "font: 15.0px", with: "font: 12.0px")
        
        changeText = changeText.replacingOccurrences(of: "font-size: 15.00px", with: "font-size: 12.00px")
        
        return changeText
    }
}
