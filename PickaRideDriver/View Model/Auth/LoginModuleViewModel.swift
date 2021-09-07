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
   
    
    func webserviceForLogin(){
        let loginReqModel = LoginReqModel()
        loginReqModel.lat = SingletonClass.sharedInstance.locationString().latitude
        loginReqModel.lng = SingletonClass.sharedInstance.locationString().longitude
        loginReqModel.username = loginvc?.txtEmailOrPhoneNumber.text ?? ""
        loginReqModel.password = loginvc?.txtPassword.text ?? ""
        
        self.loginvc?.btnSignIN.showLoading()
        
        WebServiceSubClass.Login(reqModel: loginReqModel) { (status, message, response, error) in
            self.loginvc?.btnSignIN.hideLoading()
            if status{
                SingletonClass.sharedInstance.LoginRegisterUpdateData = response
                user_defaults.setUserData()
                user_defaults.setValue(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                appDel.navigateToMain()
            }else{
                if let loginvc  = self.loginvc{
                    Utilities.showAlertOfAPIResponse(param: error, vc: loginvc)
                }
            }
        }
    }
}
