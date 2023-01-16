//
//  TodoGetDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/27.
//

import Foundation
import Alamofire

class GetTodoDataManager{
    
    func gets(_ date: String){
        
        AF.request("https://todoary.com/todo/date/\(date)", method: .get, parameters: nil, interceptor: Interceptor()).validate().responseDecodable(of: GeneralResponse<[TodoResultModel]>.self) { response in
            switch response.result {
            case .success(let result):
                HomeViewController.bottomSheetVC.checkGetTodoApiResultCode(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

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
