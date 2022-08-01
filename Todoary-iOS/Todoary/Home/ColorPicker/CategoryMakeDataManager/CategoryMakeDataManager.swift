//
//  CategoryMakeDataManager.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/29.
//

import Alamofire

class CategoryMakeDataManager {
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    func categoryMakeDataManager(parameter: CategoryMakeInput, categoryVC: CategoryViewController, viewController : ColorPickerBottomsheetViewController) {
        AF.request("https://todoary.com/category", method: .post, parameters: parameter,  encoder: JSONParameterEncoder.default , headers: headers).validate().responseDecodable(of: CategoryMakeModel.self) { response in
            switch response.result {
            case .success(let result):
                switch result.code {
                case 1000:
                    print("카테고리생성성공")
                    categoryVC.requestCategory()
                    viewController.hideBottomSheetAndGoBack()
                case 2010:
                    print("유저 아이디값을 확인해주세요")
                case 2104:
                    print("같은 이름의 카테고리가 이미 존재합니다")
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
    
    func categoryMakeDataManager( _ viewController : ColorPickerViewController , _ parameter: CategoryMakeInput) {
        AF.request("https://todoary.com/category", method: .post, parameters: parameter,  encoder: JSONParameterEncoder.default , headers: headers).validate().responseDecodable(of: CategoryMakeModel.self) { response in
            switch response.result {
            case .success(let result):
                switch result.code {
                case 1000:
                    print("카테고리생성성공")
                case 2010:
                    print("유저 아이디값을 확인해주세요")
                case 2104:
                    print("같은 이름의 카테고리가 이미 존재합니다")
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
