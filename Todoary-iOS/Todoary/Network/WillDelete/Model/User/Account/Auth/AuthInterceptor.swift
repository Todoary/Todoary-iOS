//
//  AuthInterceptor.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/26.
//
import Alamofire

final class Interceptor: RequestInterceptor {

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        if (UserDefaults.standard.string(forKey: "refreshToken") != nil){
            let authJwt = AuthJwtInput(refreshToken: UserDefaults.standard.string(forKey: "refreshToken"))
            AuthJwtDataManager().authJwtDataManager(authJwt)
            completion(.retry)
        }
    }
}

final class JwtInterceptor: RequestInterceptor {
    var window: UIWindow?
    var navigationController : UINavigationController?

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navigationController = UINavigationController(rootViewController: LoginViewController())
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        completion(.retry)
    }
}
