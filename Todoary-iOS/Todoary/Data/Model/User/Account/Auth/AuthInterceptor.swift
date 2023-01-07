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

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        if (UserDefaults.standard.string(forKey: "refreshToken") != nil){
            let authJwt = AuthJwtInput(refreshToken: UserDefaults.standard.string(forKey: "refreshToken"))
            
            AF.request("https://todoary.com/auth/jwt", method: .post, parameters: authJwt, encoder: JSONParameterEncoder.default, headers: nil).validate().responseDecodable(of: AuthJwtModel.self) { [self] response in
                
                switch response.result{
                case .success(let result):
                    switch result.code{
                    case 1000:
                        UserDefaults.standard.set(result.result?.token?.accessToken, forKey: "accessToken")
                        UserDefaults.standard.set(result.result?.token?.refreshToken, forKey: "refreshToken")
                        print("interceptor 성공")
                        completion(.retry)
                        
                    default:
                        print("에러")
                        completion(.doNotRetryWithError(error))
                    }
                case .failure(let error):
<<<<<<< Updated upstream
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    navigationController = UINavigationController(rootViewController: LoginViewController())
                    self.window?.rootViewController = self.navigationController
                    self.window?.makeKeyAndVisible()
                    completion(.doNotRetryWithError(error))
=======
                    completion(.retry)
//                    self.window = UIWindow(frame: UIScreen.main.bounds)
//                    navigationController = UINavigationController(rootViewController: LoginViewController())
//                    self.window?.rootViewController = self.navigationController
//                    self.window?.makeKeyAndVisible()
//                    completion(.doNotRetryWithError(error))
>>>>>>> Stashed changes
                }
            }
        }else {
            completion(.doNotRetryWithError(error))
        }
    }
}
