//
//  AuthInterceptor.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/26.
//
import Alamofire

final class Interceptor: RequestInterceptor {
    var window: UIWindow?
    var navigationController : UINavigationController?

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if UserDefaults.standard.string(forKey: "accessToken") != nil {
            urlRequest.headers.add(.authorization(UserDefaults.standard.string(forKey: "accessToken")!))
        }

        print("adapt")
        completion(.success(urlRequest))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        if (UserDefaults.standard.string(forKey: "refreshToken") != nil){
            let authJwt = AuthJwtRequestModel(refreshToken: UserDefaults.standard.string(forKey: "refreshToken"))
            
            AF.request("https://todoary.com/auth/jwt", method: .post, parameters: authJwt, encoder: JSONParameterEncoder.default, headers: nil).validate().responseDecodable(of: AuthJwtResultModel.self) { response in
                
                switch response.result{
                case .success(let result):
                    switch result.code{
                    case 1000:
                        UserDefaults.standard.set(result.result?.token?.accessToken, forKey: "accessToken")
                        UserDefaults.standard.set(result.result?.token?.refreshToken, forKey: "refreshToken")
                        print("interceptor 성공")
                        completion(.retry)
                    case 2002:
                        print("유효하지않은 JWT입니다")
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.backToLoginViewController()
                        completion(.doNotRetryWithError(error))
                    case 2003:
                        print("만료된jwt")
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.backToLoginViewController()
                        completion(.doNotRetryWithError(error))
                    case 2006:
                        print("유저정보와 일치하지 않는")
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.backToLoginViewController()
                        completion(.doNotRetryWithError(error))
                    case 4000:
                        print("데이터베이스연결에 실패")
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.backToLoginViewController()
                        completion(.doNotRetryWithError(error))
                    case 4015:
                        print("Fcm")
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.backToLoginViewController()
                        completion(.doNotRetryWithError(error))
                    default:
                        print("에러")
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.backToLoginViewController()
                        completion(.doNotRetryWithError(error))
                    }
                case .failure(let error):
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.backToLoginViewController()
                    completion(.doNotRetryWithError(error))
                }
            }
        }else {
            completion(.doNotRetryWithError(error))
        }
    }
}
