//
//  GetCategoryDataManager.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/31.
//

import Alamofire

class GetCategoryDataManager {
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]

    func get( _ viewController : CategoryViewController ) {
        AF.request("https://todoary.com/category", method: .get , parameters: nil, headers: headers, interceptor: Interceptor()).validate().responseDecodable(of: GetCategoryModel.self) { response in
            switch response.result {
            case .success(let result):
                switch result.code {
                case 1000:
                    viewController.checkGetCategoryApiResultCode(result.result)
                case 4000:
                    let alert = DataBaseErrorAlert()
                    viewController.present(alert, animated: true, completion: nil)
                default:
                    print(result.message)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getCategoryDataManager( _ viewController : UIViewController ) {
        AF.request("https://todoary.com/category", method: .get , parameters: nil, headers: headers).validate().responseDecodable(of: GetCategoryModel.self) { response in
            switch response.result {
            case .success(let result):
                switch result.code {
                case 1000:
                    print("카테고리조회성공")
                    if let vc = viewController as? TodoSettingViewController {
                        vc.successAPI_category(result.result)
                    }else if let vc = viewController as? SummaryBottomViewController {
                        vc.successAPI_category(result.result)
                    }
                case 4000:
                    let alert = DataBaseErrorAlert()
                    viewController.present(alert, animated: true, completion: nil)
                default:
                    print(result.message)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
