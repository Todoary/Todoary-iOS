//
//  TodoResultModel.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/17.
//

import Foundation

struct TodoResultModel: Codable, Equatable{
    let todoId: Int
    var isPinned: Bool!
    var isChecked: Bool
    var title: String
    var targetDate: String
    var isAlarmEnabled: Bool
    var targetTime: String?
    let createdTime: String
    var categoryId: Int
    let categoryTitle: String
    let color: Int
    
    static func ==(lhs: TodoResultModel, rhs: TodoResultModel) -> Bool {
        return lhs.todoId == rhs.todoId
    }
    
    var convertTime: String?{

        guard let time = targetTime else{ return nil }
        
        var startIndex: String.Index!
        var endIndex : String.Index!

        if(time < "01:00"){
            startIndex = time.index(time.startIndex, offsetBy: 2)
            endIndex = time.endIndex
            return "AM 12\(time[startIndex..<endIndex])"
        }else if(time < "12:00"){
            startIndex = time >= "10:00" ? time.startIndex : time.index(time.startIndex, offsetBy: 1)
            endIndex = time.endIndex
            return "AM \(time[startIndex..<endIndex])"
        }else if(time < "13:00"){
            return "PM \(time)"
        }else{
            startIndex = time.startIndex
            endIndex = time.index(time.startIndex, offsetBy: 2)
            
            let changeHour = Int(time[startIndex..<endIndex])! - 12
            
            return "PM \(changeHour)\(time[endIndex..<time.endIndex])"
        }
    }
    
    var convertDate: String{
        //2022-07-24 -> 7월 24일
        let dateArr = targetDate.components(separatedBy: "-")
        
        return "\(Int(dateArr[1])!)월 \(Int(dateArr[2])!)일"
    }
    
    var categoryWidth: Int{
        
        if(isPinned! && isAlarmEnabled){
            switch self.categoryTitle.count{
            case 1:
                return 11 + 7*2
            case 2:
                return 22 + 12*2
            case 3:
                return 32 + 10*2
            case 4:
                return 43 + 8*2
            case 5:
                return 53 + 6*2
            default:
                return 0
            }
        }else{
            switch self.categoryTitle.count{
            case 1:
                return 11 + 24
            case 2:
                return 22 + 24
            case 3:
                return 32 + 24
            case 4:
                return 43 + 24
            case 5:
                return 53 + 6*2
            default:
                return 0
            }
//            return self.categoryTitle.count < 5 ? 24 : 6*2
        }
    }
}
