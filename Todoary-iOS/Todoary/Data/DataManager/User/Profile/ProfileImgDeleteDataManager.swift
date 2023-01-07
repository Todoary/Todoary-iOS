//
//  ProfileImgDeleteDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Alamofire

class ProfileImgDeleteDataManager {
    
    let headers : HTTPHeaders = [.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    //통신
    func profileImgDelete(_ veiwController : ProfileViewController) {
        AF.request("http://todoary.com/users/profile-img",
                   method: .delete,
                   encoding: URLEncoding(destination: .queryString),
                   headers: headers,
                   interceptor: Interceptor()).validate().responseDecodable(of: ProfileImgDeleteModel.self)
        {response in
            switch response.result {
            case .success(let result) :
                switch result.code {
                case 1000 :
                    print("사진삭제")
                case 5001 :
                    let alert = DataBaseErrorAlert()
                    veiwController.present(alert, animated: true, completion: nil)
                default:
                    print(result.message)
                }
            case .failure(let error) :
                print(error.localizedDescription)

                }
            }
        }
    }
