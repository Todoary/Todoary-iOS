//
//  AppDelegate.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/01.
//

import UIKit
import Firebase

import FirebaseAnalytics
import FirebaseMessaging
import AuthenticationServices

//@main
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate  {

    var window: UIWindow?
    var navigationController : UINavigationController?
    var delay = 2
    
    
    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let firebaseToken = fcmToken ?? ""
        UserManager.fcmToken = firebaseToken
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        self.navigationController = UINavigationController(rootViewController: UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!)
        self.navigationController?.navigationBar.isHidden = true
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if(UserManager.isFirstTime){
            self.moveOnboardingViewController()
        }else{
            if (UserManager.refreshToken == nil){
                self.moveLoginViewController()
                
            }else {
                NetworkCheck().networkCheck()
            }
        }
        
        if #available(iOS 12.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .sound, .badge, .providesAppNotificationSettings], completionHandler: { didAllow,Error in
            })
        } else {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow,Error in
                print(didAllow)
            })
        }
        UNUserNotificationCenter.current().delegate = self
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        application.registerForRemoteNotifications()
        
        return true
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        NetworkCheck().networkCheck()
    }
        
    
    func successAPI(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            if (UserManager.hasAppPassword) {
                self.navigationController = UINavigationController(rootViewController: AppPasswordViewController())
                self.navigationController?.navigationBar.isHidden = true
                self.window?.rootViewController = self.navigationController
                self.window?.makeKeyAndVisible()
            }else {
                self.moveHomeViewController()
            }
        }
    }
    
    func moveHomeViewController(){
        navigationController?.pushViewController(HomeViewController(), animated: false)
        navigationController?.navigationBar.isHidden = true
    }
    
    func moveLoginViewController(){
        navigationController?.pushViewController(LoginViewController(), animated: false)
        navigationController?.navigationBar.isHidden = true
    }
    
    func backToLoginViewController(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            self.navigationController?.pushViewController(LoginViewController(), animated: false)
        }
    }
    
    func moveOnboardingViewController(){
        navigationController?.pushViewController(OnboardingViewController(), animated: false)
        navigationController?.navigationBar.isHidden = true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate{
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}

