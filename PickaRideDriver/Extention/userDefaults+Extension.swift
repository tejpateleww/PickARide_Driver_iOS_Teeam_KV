//
//  userDefaults+Extension.swift
//  Qwnched-Customer
//
//  Created by apple on 16/09/20.
//  Copyright © 2020 Hiral's iMac. All rights reserved.
//

import Foundation
extension UserDefaults{
    func set<T: Codable>(object: T, forKey: String) throws {
        
        let jsonData = try JSONEncoder().encode(object)
        
        set(jsonData, forKey: forKey)
    }
    
    
    func get<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {
        
        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }
        
        return try JSONDecoder().decode(objectType, from: result)
    }
    
    func setCountryData() {
        try? UserDefaults.standard.set(object: SingletonClass.sharedInstance.CountryList, forKey: UserDefaultsKey.countryList.rawValue)
    }
    
    func getCountryData() -> [CountryDetilsModel]? {
        let objResponse = try? UserDefaults.standard.get(objectType: [CountryDetilsModel].self, forKey:  UserDefaultsKey.countryList.rawValue)
        return objResponse ?? nil
    }
    
    func setUserData() {
        try? UserDefaults.standard.set(object: SingletonClass.sharedInstance.UserProfilData, forKey: UserDefaultsKey.userProfile.rawValue)
    }
//    func getUserData() -> RegisterFinal? {
//        let objResponse = try? UserDefaults.standard.get(objectType: RegisterFinal.self, forKey:  UserDefaultsKey.userProfile.rawValue)
//        return objResponse ?? nil
//    }
    
    func getUserData() -> RegisterData? {
        let objResponse = try? UserDefaults.standard.get(objectType: RegisterData.self, forKey:  UserDefaultsKey.userProfile.rawValue)
        SingletonClass.sharedInstance.UserProfilData = objResponse
        SingletonClass.sharedInstance.UserId = objResponse?.id ?? ""
        SingletonClass.sharedInstance.Api_Key = objResponse?.xApiKey ?? ""
        SingletonClass.sharedInstance.UserProfilData?.duty = user_defaults.value(forKey: UserDefaultsKey.dutyStatus.rawValue) as? String ?? "0"
        return objResponse ?? nil
    }

}
