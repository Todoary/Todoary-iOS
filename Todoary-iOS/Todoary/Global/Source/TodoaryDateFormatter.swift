//
//  TodoaryDateFormatter.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/18.
//

import Foundation

struct ConvertDate{
    var year: Int?
    var month: Int?
    var date: String?
    
    var dateSendServer: String{
        
        let monthString = self.month! < 10 ? "0\(month!)" : "\(month!)"
        let dateString = self.date!.count < 2 ? "0\(date!)" : date!
        
        return "\(year!)-\(monthString)-\(dateString)"
    }
    
    var yearMonthSendServer: String{
        
        let monthString = self.month! < 10 ? "0\(month!)" : "\(month!)"
        
        return "\(year!)-\(monthString)"
    }
    
    var dateUsedDiary: String{
        
        let monthString = self.month! < 10 ? "0\(month!)" : "\(month!)"
        let dateString = self.date!.count < 2 ? "0\(date!)" : date!
        
        return "\(year!).\(monthString).\(dateString)"
    }
    
    var dateUsedTodo: String{
        return "\(year!)년 \(month!)월 \(date!)일"
    }
}
