//
//  ProfileImgDataManager.swift
//  Todoary
//
//  Created by 예리 on 2022/07/22.
//

import Alamofire

class profileImgDataManager {
    
    let headers : HTTPHeaders = [.contentType("multipart/form-data"),.authorization(UserDefaults.standard.string(forKey: "accessToken")!)]
    
    func profileImgData(_ viewController : ProfileViewController, _ Input: UIImage) {
        AF.upload(multipartFormData: { (multipartFormData) in
            
            if let image = Input.jpegData(compressionQuality: 0.1) {
                multipartFormData.append(image, withName: "profile-img", fileName: "\(image).jpeg", mimeType: "image/ipeg")
            }
            
        }, to: "https://todoary.com/users/profile-img", usingThreshold: UInt64.init(), method: .patch, headers: headers).validate().responseDecodable(of: ProfileImgModel.self)
        { response in
            
            switch response.result {
            case .success(let result) :
                switch result.code {
                    
                case 1000 :
                    print("프로필이미지변경성공")
                case 5001 :
                    let alert = DataBaseErrorAlert()
                    viewController.present(alert, animated: true, completion: nil)
                default:
                    print(result.message)
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
        
    }
}
