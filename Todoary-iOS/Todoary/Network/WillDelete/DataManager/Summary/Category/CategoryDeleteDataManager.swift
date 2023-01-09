//
//  CategoryDeleteDataManager.swift
//  Todoary
//
//  Created by 송채영 on 2022/08/01.
//

import Alamofire

class CategoryDeleteDataManager {
    
    func delete(categoryId : Int, viewController : CategoryBottomSheetViewController, categoryViewController: CategoryViewController) {
        
        AF.request("https://todoary.com/category/\(categoryId)",
                   method: .delete,
                   parameters: nil,
                   interceptor: Interceptor())
            .validate()
            .responseDecodable(of: CategoryDeleteModel.self) { response in
                switch response.result {
                case .success(let result):
                    switch result.code {
                    case 1000:
                        print("카테고리삭제성공")
                        GetCategoryDataManager().get(categoryViewController)
                        viewController.dismiss(animated: true)
//                        viewController.hideBottomSheetAndGoBack()
                    case 2010:
                        print("유저 아이디값을 확인해주세요")
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
    
    func categoryDeleteDataManager(_ viewController : ColorPickerViewController , categoryId : Int) {
        
        AF.request("https://todoary.com/category/\(categoryId)",
                   method: .delete,
                   parameters: nil,
                   interceptor: Interceptor())
            .validate()
            .responseDecodable(of: CategoryDeleteModel.self) { response in
                switch response.result {
                case .success(let result):
                    switch result.code {
                    case 1000:
                        print("카테고리삭제성공")
                        TodoSettingViewController.selectCategory = -1
                        viewController.navigationController?.popViewController(animated: true)
                    case 2010:
                        print("유저 아이디값을 확인해주세요")
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
