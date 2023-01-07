//
//  GetDiaryDataManager.swift
//  Todoary
//
//  Created by 송채영 on 2022/08/23.
//

import Alamofire

class GetDiaryDataManager {
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    func getDiaryDataManager(_ viewController : UIViewController , yearMonth : String) {
        
        AF.request("https://todoary.com/diary/days/\(yearMonth)",
                   method: .get,
                   parameters: nil,
                   headers: headers,interceptor: Interceptor())
            .validate()
            .responseDecodable(of: GetDiaryExistenceModel.self) { response in
                switch response.result {
                case .success(let result):
                    switch result.code {
                    case 1000:
                        print("다이어리존재여부조회 성공")
                        if let vc = viewController as? HomeViewController{
                            vc.successAPI_diary(result.result)
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
