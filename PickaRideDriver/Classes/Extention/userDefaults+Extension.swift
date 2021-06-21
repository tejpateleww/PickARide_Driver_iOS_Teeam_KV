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
//        try? UserDefaults.standard.set(object: Singleton.shared.countryList, forKey: UserDefaultsKey.countryList.rawValue)
    }
    
    func getCountryData() -> [CountryDetailModel]? {
        let objResponse = try? UserDefaults.standard.get(objectType: [CountryDetailModel].self, forKey:  UserDefaultsKey.userProfile.rawValue)
        return objResponse ?? nil
    }
    func setUserData() {
//        try? UserDefaults.standard.set(object: SingletonClass.sharedInstance., forKey: UserDefaultsKey.userProfile.rawValue)
    }
    func getUserData() -> RegisterData? {
        let objResponse = try? UserDefaults.standard.get(objectType: RegisterData.self, forKey:  UserDefaultsKey.userProfile.rawValue)
        return objResponse ?? nil
    }

}
