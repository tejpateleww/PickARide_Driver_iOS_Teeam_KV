//
//  AppDelegate.swift
//  PickaRideDriver
//
//  Created by Harsh Sharma on 06/05/21.
//

import UIKit
import IQKeyboardManagerSwift
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var locationManager = LocationService()
    let notificationCenter = UNUserNotificationCenter.current()
    var window: UIWindow?
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        //        navigateToLogin()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        checkAndSetDefaultLanguage()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        SideMenuController.preferences.basic.menuWidth = UIScreen.main.bounds.width - 100
        SideMenuController.preferences.basic.defaultCacheKey = "0"
        if user_defaults.object(forKey: UserDefaultsKey.isUserLogin.rawValue) as? Bool == true
        {
            self.navigateToMain()
        } else
        {
            self.navigateToLogin()
        }
        return true
    }
    
    func navigateToLogin()
    {
        let storyborad = UIStoryboard(name: "Login", bundle: nil)
        let Login = storyborad.instantiateViewController(withIdentifier: LoginViewController.className) as! LoginViewController
        
        let NavHomeVC = UINavigationController(rootViewController: Login)
        NavHomeVC.navigationBar.isHidden = true
        self.window?.rootViewController = NavHomeVC
    }
    
    func navigateToHome()
    {
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: HomeVC.storyboardID) as! HomeVC
        let nav = UINavigationController(rootViewController: controller)
        nav.navigationBar.isHidden = true
        self.window?.rootViewController = nav
    }
    func navigateToMain()
    {
        //SideMenuController
        let storyborad = UIStoryboard(name: "Main", bundle: nil)
        let Home = storyborad.instantiateViewController(withIdentifier: SideMenuController.className) as! SideMenuController
        let HomeVC = UINavigationController(rootViewController: Home)
        HomeVC.navigationBar.isHidden = true
        self.window?.rootViewController = HomeVC
    }
    func navigateToMainLogin() {
        let controller = AppStoryboard.Login.instance.instantiateViewController(withIdentifier: LoginViewController.storyboardID) as? LoginViewController
        let nav = UINavigationController(rootViewController: controller!)
        nav.navigationBar.isHidden = true
        self.window?.rootViewController = nav
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
    
    
    func checkAndSetDefaultLanguage() {
        if user_defaults.value(forKey: UserDefaultsKey.selLanguage.rawValue) == nil {
            setLanguageEnglish()
        }
    }
    func setLanguageEnglish() {
        user_defaults.setValue("en", forKey: UserDefaultsKey.selLanguage.rawValue)
    }
    
}

extension AppDelegate:  CLLocationManagerDelegate, LocationServiceDelegate{
func tracingLocation(currentLocation: CLLocation) {
    SingletonClass.sharedInstance.userCurrentLocation = currentLocation
    
}

func tracingLocationDidFailWithError(error: Error) {
    self.locationManager.startUpdatingLocation()
}
}
