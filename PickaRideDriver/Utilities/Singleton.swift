//
//  Singleton.swift
//  Virtuwoof Pet
//
//  Created by EWW80 on 09/11/19.
//  Copyright © 2019 EWW80. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class SingletonClass: NSObject
{
    static let sharedInstance = SingletonClass()
    
    var AppInitModel : InitResponseModel?
    var UserId = String()
    var LoginRegisterUpdateData : RegisterFinal?
    var UserProfilData : RegisterData?
    
    var Api_Key = String()
    var DeviceToken : String = UIDevice.current.identifierForVendor?.uuidString ?? ""
    var isPresented = false
    var userCurrentLocation : CLLocationCoordinate2D?
    var CountryList = [CountryDetilsModel]()
    var CityList = [CityDetailsModel]()
    var DeviceType : String = "ios"
    
    var latitude : Double!
    var longitude : Double!
    
    var sosNumber: String = "000000000"
    
    var currencySymbol: String {
        UserDefaults.standard.getUserData()?.currencySymbol ?? ""
    }
    
//    var currentLat = Double()
//    var currentLong = Double()
    
    ///Owner Profile Info
//    var OwnerProfileInfo : ResProfileRootClass?
    
    //MARK:- User' Custom Details
  
    func locationString() -> (latitude: String, longitude: String){
        return (String(userCurrentLocation?.latitude ?? 0.0), String(userCurrentLocation?.longitude ?? 0.0))
    }
  
    var arrFutureYears:[String] {
        get {
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: Date())
            return (currentYear...(currentYear + 11)).map { String($0)}
        }
    }
    
    func clearSingletonClass() {
        UserId = ""
        Api_Key = ""
        UserProfilData = nil
        LoginRegisterUpdateData = nil
        balance = nil
    }
    var balance: String?
}

