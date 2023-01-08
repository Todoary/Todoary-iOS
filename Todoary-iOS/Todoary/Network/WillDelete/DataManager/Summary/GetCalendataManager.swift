//
//  GetCalendataManager.swift
//  Todoary
//
//  Created by 송채영 on 2022/08/01.
//

import Alamofire

class GetCalendataManager {
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    func getCalendataManager(_ viewController : UIViewController , yearMonth : String) {
        
        AF.request("https://todoary.com/todo/days/\(yearMonth)",
                   method: .get,
                   parameters: nil,
                   headers: headers,
                   interceptor: Interceptor())
            .validate()
            .responseDecodable(of: GetCalendarModel.self) { response in
                switch response.result {
                case .success(let result):
                    switch result.code {
                    case 1000:
                        print("캘린더조회성공")
                        if let vc = viewController as? HomeViewController{
                            vc.successAPI_calendar(result.result)
                        }
                    case 2005:
                        print("유효하지 않은 회원정보입니다")
                    case 2010:
                        print("유저 아이디값을 확인해 주세요")
                    case 4000:
                        if let vc = viewController as? HomeViewController{
                            let alert = DataBaseErrorAlert()
                            vc.present(alert, animated: true, completion: nil)
                        }
                    default:
                        print(result.message)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
