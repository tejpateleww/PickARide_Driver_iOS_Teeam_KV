//
//  LoginModuleViewModel.swift
//  PickaRideDriver
//
//  Created by Harsh on 22/06/21.
//

import Foundation
import UIKit

class LoginUserModel{
    weak var loginvc : LoginViewController? = nil
    var loginReqModel : LoginReqModel?
   
    
    func webserviceForLogin(reqModel: LoginReqModel){
        self.loginvc?.btnSignIN.showLoading()
        WebServiceSubClass.Login(reqModel: reqModel) { (status, message, response, error) in
            self.loginvc?.btnSignIN.hideLoading()
            if status{
                
                user_defaults.setValue(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                user_defaults.setValue(response?.data?.xApiKey, forKey: UserDefaultsKey.X_API_KEY.rawValue)
                
                SingletonClass.sharedInstance.UserProfilData = response?.data
                user_defaults.setUserData()
                
                if let apikey = response?.data?.xApiKey{
                    SingletonClass.sharedInstance.Api_Key = apikey
                    SingletonClass.sharedInstance.UserProfilData?.xApiKey = apikey
                    user_defaults.setValue(apikey, forKey: UserDefaultsKey.X_API_KEY.rawValue)
                }
                
                if let userID = response?.data?.id{
                    SingletonClass.sharedInstance.UserId = userID
                }
                
                appDel.navigateToMain()
            }else{
                Toast.show(title: UrlConstant.Failed, message: message, state: .failure)
            }
        }
    }
}
