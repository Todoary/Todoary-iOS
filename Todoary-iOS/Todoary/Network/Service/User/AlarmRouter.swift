//
//  AlarmRouter.swift
//  Todoary
//
//  Created by 박지윤 on 2023/01/10.
//

import Foundation
import Alamofire

//MARK: - Enum
enum AlarmRouter{
    case patchTodoAlarm(request: Bool)
    case patchDiaryAlarm(request: Bool)
    case patchRemindAlarm(request: Bool)
    case getAlarms
}

//MARK: - Extension
extension AlarmRouter: BaseRouter{
    
    var path: String{
        switch self{
        case .patchTodoAlarm:                   return HTTPMethodURL.PATCH.todoAlarmActivate
        case .patchDiaryAlarm:                  return HTTPMethodURL.PATCH.diaryAlarmActivate
        case .patchRemindAlarm:                 return HTTPMethodURL.PATCH.remindAlarmActivate
        case .getAlarms:                        return HTTPMethodURL.GET.alarmActivate
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .patchTodoAlarm:                   return .patch
        case .patchDiaryAlarm:                  return .patch
        case .patchRemindAlarm:                 return .patch
        case .getAlarms:                        return .get
        }
    }
    
    var parameters: RequestParams {
        switch self{
        case .patchTodoAlarm(let request),
                .patchDiaryAlarm(let request),
                .patchRemindAlarm(let request):
            
            let parameter: [String:Any] = ["isChecked" : request]
            return .requestBodyWithDictionary(parameter)
            
        case .getAlarms:
            return .requestPlain
        }
    }
    
    var header: HeaderType{
        switch self{
        default:                    return .withToken
        }
    }
}

extension MarketingRouter: BaseRouter{
    
    var path: String{
        switch self{
        case .patchAgreement:                   return HTTPMethodURL.PATCH.marketing
        }
    }
    
    var method: HTTPMethod{
        switch self{
        case .patchAgreement:                   return .patch
        }
    }
    
    var parameters: RequestParams {
        switch self{
        case .patchAgreement(let request):
            let parameter: [String:Any] = ["isChecked" : request]
            return .requestBodyWithDictionary(parameter)
        }
    }
    
    var header: HeaderType{
        switch self{
        default:                    return .withToken
        }
    }
}
