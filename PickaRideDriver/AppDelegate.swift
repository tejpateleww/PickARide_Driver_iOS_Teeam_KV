//
//  AppDelegate.swift
//  PickaRideDriver
//
//  Created by Harsh Sharma on 06/05/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let notificationCenter = UNUserNotificationCenter.current()
    var window: UIWindow?
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        navigateToLogin()
        return true
    }
    func navigateToLogin(){
        let storyborad = UIStoryboard(name: "Main", bundle: nil)
        let Login = storyborad.instantiateViewController(withIdentifier: CancelRideVC.className) as! CancelRideVC
        let NavHomeVC = UINavigationController(rootViewController: Login)
        NavHomeVC.navigationBar.isHidden = true
        self.window?.rootViewController = NavHomeVC
    }
//    func navigateToLogin(){
//        let storyborad = UIStoryboard(name: "Login", bundle: nil)
//        let Login = storyborad.instantiateViewController(withIdentifier: LoginViewController.className) as! LoginViewController
//        let NavHomeVC = UINavigationController(rootViewController: Login)
//        NavHomeVC.navigationBar.isHidden = true
//        self.window?.rootViewController = NavHomeVC
//    }
    
//    func navigateToHome(){
//        let storyborad = UIStoryboard(name: "Main", bundle: nil)
//        let Login = storyborad.instantiateViewController(withIdentifier: MainViewController.className) as! MainViewController
////        let NavHomeVC = UINavigationController(rootViewController: Login)
//        self.window?.rootViewController = Login
//    }


}

