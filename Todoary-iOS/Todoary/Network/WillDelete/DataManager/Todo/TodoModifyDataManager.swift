//
//  TodoModifyDataManager.swift
//  Todoary
//
//  Created by 송채영 on 2022/08/02.
//

import Alamofire

class TodoModifyDataManager {
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    func todoModifyDataManager( _ viewController : TodoSettingViewController , _ parameter: TodoModifyInput, todoId: Int) {
        AF.request("https://todoary.com/todo/\(todoId)", method: .patch, parameters: parameter,  encoder: JSONParameterEncoder.default , headers: headers, interceptor: Interceptor()).validate().responseDecodable(of: TodoModifyModel.self) { response in
            switch response.result {
            case .success(let result):
                switch result.code {
                case 1000:
                    print("투두수정성공")
                    viewController.navigationController?.popViewController(animated: true)
                case 2005:
                    print("유효하지 않은 회원정보입니다.")
                case 2010:
                    print("유저아이디값을 확인해주세요")
                default:
                    print(result.message)
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
