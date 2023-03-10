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

    var content15AttributedString: NSMutableAttributedString?{
        guard let data = content.data(using: .utf8) else {
            return nil
        }
        
        guard let att = try? NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil) else {
            return nil
        }
        
        if att.string.last == "\n" {
            return att.attributedSubstring(from: NSRange(location: 0, length: att.length - 1)) as? NSMutableAttributedString
        } else {
            return att
        }
    }
    
    var content12AttributedString: NSAttributedString?{
    
        guard let data = summaryCellContent.data(using: .utf8) else {
            return nil
        }
        
        guard let att = try? NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil) else {
            return nil
        }

        if att.string.last == "\n" {
            return att.attributedSubstring(from: NSRange(location: 0, length: att.length - 1)) as? NSMutableAttributedString
        } else {
            return att
        }
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
