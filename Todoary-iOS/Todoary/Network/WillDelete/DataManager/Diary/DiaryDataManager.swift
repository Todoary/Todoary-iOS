//
//  DiaryDataManager.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/17.
//

import UIKit
import Alamofire

class DiaryDataManager {
    
    //다이어리 생성/수정
    func posts(viewController: DiaryViewController, createdDate: String, parameter: DiaryInput){
        
        AF.request("https://todoary.com/diary/\(createdDate)", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default,
                   interceptor: Interceptor()).validate().responseDecodable(of: ApiModel.self) { response in
            switch response.result {
            case .success(let result):
                if(result.code == 1000){
                    print("다이어리 생성 성공")
                    viewController.exitBtnDidTab()
                    viewController.navigationController?.popViewController(animated: true)
                }else{
                    print(result.code)
                    print(result.messsage)
                    viewController.exitBtnDidTab()
                    let alert = DataBaseErrorAlert()
                    viewController.present(alert, animated: true, completion: nil)
                }
            case .failure(let error):
                print("실패")
                print(error.localizedDescription)
            }
        }
    }
    
    func gets(_ date: String){
        AF.request("https://todoary.com/diary", method: .get, parameters: ["createdDate":date],
                   encoding: URLEncoding.queryString,
                   interceptor: Interceptor()).validate().responseDecodable(of: GetDiaryModel.self) { response in
            switch response.result {
            case .success(let result):
                HomeViewController.bottomSheetVC.checkGetDiaryApiResultCode(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //다이어리 스티커 생성/수정/삭제
    func diaryStickerDataManager(viewController: DiaryViewController, createdDate: String, parameter: DiaryStickerInput){
        
        AF.request("https://todoary.com/diary/\(createdDate)/sticker", method: .put, parameters: parameter, encoder: JSONParameterEncoder.default
                   , interceptor: Interceptor()).validate().responseDecodable(of: DiaryStickerModel.self) { response in
            
            switch response.result {
            case .success(let result):
                switch result.code {
                case 1000:
                    print("다이어리 스티커 생성 성공")
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
    
    
    func getDiarySticker(viewController: DiaryViewController, createdDate: String){
        
        AF.request("https://todoary.com/diary/\(createdDate)/sticker", method: .get, parameters: nil, interceptor: Interceptor()).validate().responseDecodable(of: GetDiaryStickerModel.self) { response in
            switch response.result {
            case .success(let result):
                switch result.code {
                case 1000:
                    print("다이어리스티커조회 성공")
                    viewController.successAPI_sticker(result.result) 
                case 2005:
                    print("유효하지 않은 회원정보입니다")
                case 2402:
                    print("해당하는 유저와 일치하는 일기가 없습니다")
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
