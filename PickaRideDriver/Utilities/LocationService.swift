//
//  LocationService.swift


import Foundation
import CoreLocation
import UIKit

protocol LocationServiceDelegate {
    func tracingLocation(currentLocation: CLLocation)
    func tracingLocationDidFailWithError(error: Error)
}

class LocationService: NSObject, CLLocationManagerDelegate {
    
    class var sharedInstance: LocationService {
        struct Static {
            static var instance = LocationService()
        }
        return Static.instance
    }

    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var delegate: LocationServiceDelegate?

    override init() {
        super.init()

        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {
            return
        }
        
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            // you have 2 choice
            // 1. requestAlwaysAuthorization
            // 2. requestWhenInUseAuthorization
            self.locationManager?.requestWhenInUseAuthorization()
        }
//        else if status == .denied || status == .restricted{
//            Utility.showAlertWithTitleFromWindow(title: locationTitle, andMessage: locationMsg, buttons: [locationAllow]) { (index) in
//                if let settingsAppURL = URL(string: UIApplication.openSettingsURLString){
//                    UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
//                }
//            }
//        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // The accuracy of the location data
//        locationManager.distanceFilter = 200 // The minimum distance (measured in meters) a device must move horizontally before an update event is generated.
        locationManager.delegate = self
    }
    
    func startUpdatingLocation() {
        print("Starting Location Updates")
        
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            // you have 2 choice
            // 1. requestAlwaysAuthorization
            // 2. requestWhenInUseAuthorization
            self.locationManager?.requestWhenInUseAuthorization()
        }else if status == .denied || status == .restricted{
    
            var vc = appDel.window?.rootViewController
             
//            if let tabbar = appDel.businessTabbar{
//                vc = tabbar
//            }else if let tabbar = appDel.customerTabbar{
//                vc = tabbar
//            }
            
//            if let tabbar = Utility.getSceneDelegate()?.businessTabbar {
//                vc = tabbar
//            }else if let tabbar = Utility.getSceneDelegate()?.customerTabbar {
//                vc = tabbar
//            }
            
//            Utility.showAlertWithTitleFromVC(vc: vc ?? UIViewController(), title: locationTitle, message: locationMsg, buttons: [locationAllow], isOkRed: false) { (index) in
//                if let settingsAppURL = URL(string: UIApplication.openSettingsURLString){
//                    UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
//                }
//            }
            
            
            Utilities.showAlertWithTitleFromWindow(title: "Required", andMessage: "", buttons: ["Allow"]) { (index) in
                if let settingsAppURL = URL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
                }
            }
        }
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
    }
    
    // CLLocationManagerDelegate
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else {
            return
        }
        
        // singleton for get last(current) location
        self.currentLocation = location
        
        // use for real time update location
        updateLocation(currentLocation: location)
        //updateLocation(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        // do on error
        updateLocationDidFailWithError(error: error)
        //updateLocationDidFailWithError(error)
    }
    
    // Private function
    private func updateLocation(currentLocation: CLLocation){

        guard let delegate = self.delegate else {
            return
        }
        SingletonClass.sharedInstance.userCurrentLocation.latitude = currentLocation.coordinate.latitude
        SingletonClass.sharedInstance.userCurrentLocation.longitude = currentLocation.coordinate.longitude
        delegate.tracingLocation(currentLocation: currentLocation)
       // delegate.tracingLocation(currentLocation)
    }
    
    private func updateLocationDidFailWithError(error: Error) {
        
        guard let delegate = self.delegate else {
            return
        }
        delegate.tracingLocationDidFailWithError(error: error)
        //delegate.tracingLocationDidFailWithError(error)
    }
}
