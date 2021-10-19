//
//  AppDelegate.swift
//  PickaRideDriver
//
//  Created by Harsh Sharma on 06/05/21.
//

import UIKit
import IQKeyboardManagerSwift
import CoreLocation
import GoogleMaps
import GooglePlaces
import UserNotifications

import Firebase
import FirebaseMessaging
import FirebaseInstanceID
import FirebaseCore
import FirebaseCrashlytics

import SocketIO

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate{
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    var locationManager = LocationService()
    let notificationCenter = UNUserNotificationCenter.current()
    var window: UIWindow?
    let SManager = SocketManager(socketURL: URL(string: SocketKeys.KHostUrl.rawValue)!)
    var timerTracking : Timer?
    var timerLocUpdate : Timer?
    var isHomeVcVisible : Bool = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool{
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        GMSServices.provideAPIKey(AppInfo.Google_API_Key)
        GMSPlacesClient.provideAPIKey(AppInfo.Google_API_Key)
        checkAndSetDefaultLanguage()
        
        self.locationManager.startUpdatingLocation()
        SideMenuController.preferences.basic.menuWidth = UIScreen.main.bounds.width - 100
        SideMenuController.preferences.basic.defaultCacheKey = "0"

        FirebaseApp.configure()
        registerForPushNotifications()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.stopTimers()
    }
    
    func navigateToLogin(){
        
        let storyborad = UIStoryboard(name: "Login", bundle: nil)
        let Login = storyborad.instantiateViewController(withIdentifier: LoginViewController.className) as! LoginViewController
        let NavHomeVC = UINavigationController(rootViewController: Login)
        NavHomeVC.navigationBar.isHidden = true
        self.window?.rootViewController = NavHomeVC
    }
    
    func navigateToHome(){
        
        let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: HomeVC.storyboardID) as! HomeVC
        let nav = UINavigationController(rootViewController: controller)
        nav.navigationBar.isHidden = true
        self.window?.rootViewController = nav
    }
    
    func navigateToMain(){
        
        //SideMenuController
        let storyborad = UIStoryboard(name: "Main", bundle: nil)
        let Home = storyborad.instantiateViewController(withIdentifier: SideMenuController.className) as! SideMenuController
        let HomeVC = UINavigationController(rootViewController: Home)
        HomeVC.navigationBar.isHidden = true
        self.window?.rootViewController = HomeVC
    }
    
    func navigateToMainLogin(){
        let controller = AppStoryboard.Login.instance.instantiateViewController(withIdentifier: LoginViewController.storyboardID) as? LoginViewController
        let nav = UINavigationController(rootViewController: controller!)
        nav.navigationBar.isHidden = true
        self.window?.rootViewController = nav
    }
    
    func checkAndSetDefaultLanguage(){
        if user_defaults.value(forKey: UserDefaultsKey.selLanguage.rawValue) == nil {
            setLanguageEnglish()
        }
    }
    
    func setLanguageEnglish(){
        user_defaults.setValue("en", forKey: UserDefaultsKey.selLanguage.rawValue)
    }
    
    func webserviceGetCountryList(){
        WebServiceSubClass.GetCountryList {_, _, _, _ in}
    }
    
    func clearData(){
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            
            if key != UserDefaultsKey.DeviceToken.rawValue && key  != "language"  {
                print("\(key) = \(value) \n")
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
        user_defaults.set(false, forKey: UserDefaultsKey.isUserLogin.rawValue)
        SingletonClass.sharedInstance.clearSingletonClass()
        user_defaults.setUserData()
    }
    
    func mainSocketOff(){
        let socket = (UIApplication.shared.delegate as! AppDelegate).SManager.defaultSocket
        socket.off(SocketKeys.updateDriverLocation.rawValue)
        socket.off(SocketKeys.forwardBookingRequest.rawValue)
        socket.off(SocketKeys.forwardBookingRequestToAnotherDriver.rawValue)
        socket.off(SocketKeys.acceptBookingRequest.rawValue)
        socket.off(SocketKeys.verifyCustomer.rawValue)
        socket.off(SocketKeys.arrivedAtPickupLocation.rawValue)
        socket.off(SocketKeys.startTrip.rawValue)
        socket.off(SocketKeys.liveTracking.rawValue)
        socket.disconnect()
    }
    
    func mainSocketOn(){
        let socket = (UIApplication.shared.delegate as! AppDelegate).SManager.defaultSocket
        
        socket.on(SocketKeys.updateDriverLocation.rawValue) { data, ack in
            print ("updateDriverLocation socket connected")
        }
        socket.on(SocketKeys.forwardBookingRequest.rawValue) { data, ack in
            print ("forwardBookingRequest socket connected")
        }
        socket.on(SocketKeys.forwardBookingRequestToAnotherDriver.rawValue) { data, ack in
            print ("forwardBookingRequestToAnotherDriver socket connected")
        }
        socket.on(SocketKeys.acceptBookingRequest.rawValue) { data, ack in
            print ("acceptBookingRequest socket connected")
        }
        socket.on(SocketKeys.verifyCustomer.rawValue) { data, ack in
            print ("verifyCustomer socket connected")
        }
        socket.on(SocketKeys.arrivedAtPickupLocation.rawValue) { data, ack in
            print ("arrivedAtPickupLocation socket connected")
        }
        socket.on(SocketKeys.startTrip.rawValue) { data, ack in
            print ("startTrip socket connected")
        }
        socket.on(SocketKeys.liveTracking.rawValue) { data, ack in
            print ("liveTracking socket connected")
        }
        socket.connect()
    }
    
    func stopTimers(){
        //stop all timers
        if(appDel.timerTracking != nil){
            appDel.timerTracking?.invalidate()
            appDel.timerTracking = nil
        }
        if(appDel.timerLocUpdate != nil){
            appDel.timerLocUpdate?.invalidate()
            appDel.timerLocUpdate = nil
        }
    }
    
    func dologout(){
        for (key, _) in UserDefaults.standard.dictionaryRepresentation() {
            
            if key != UserDefaultsKey.DeviceToken.rawValue && key  != "language"  {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
        
        self.mainSocketOff()
        self.stopTimers()

        user_defaults.setValue(false, forKey: UserDefaultsKey.isUserLogin.rawValue)
        SingletonClass.sharedInstance.clearSingletonClass()
        user_defaults.setUserData()
        user_defaults.synchronize()
        appDel.navigateToMainLogin()
    }
    
}


extension UIApplication {
    
/// Top most ViewController
    func topMostViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController()
    }
    
/// Top visible viewcontroller
    var topMostVisibleViewController : UIViewController? {
        
        if UIApplication.shared.keyWindow?.rootViewController is UINavigationController {
            return (UIApplication.shared.keyWindow?.rootViewController as! UINavigationController).visibleViewController
        }
        return nil
    }
}
