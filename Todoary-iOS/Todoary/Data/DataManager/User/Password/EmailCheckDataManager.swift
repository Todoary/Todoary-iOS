//
//  EmailCheckDataManager.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/24.
//

import Alamofire

class EmailCheckDataManager{
    
    func emailCheckDataManager(_ viewController: PwFindViewController, email: String){
        AF.request("https://todoary.com/auth/email/existence", method: .get, parameters: ["email":email], encoding: URLEncoding.queryString).validate().responseDecodable(of: EmailCheckModel.self) { response in
            switch response.result {
            case .success(let result):
                switch result.code{
                case 1000:
                    viewController.checkEmail(1000)
                    print("비밀번호찾기 이메일 인증 성공")
                default:
                    viewController.checkEmail(result.code)
                    print(result.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
