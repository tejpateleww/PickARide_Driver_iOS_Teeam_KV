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
        loginReqModel.lat = String(SingletonClass.sharedInstance.userCurrentLocation.coordinate.latitude)
        loginReqModel.lng = String(SingletonClass.sharedInstance.userCurrentLocation.coordinate.longitude)
        loginReqModel.username = loginvc?.mViewEmail.textField.text ?? ""
        loginReqModel.password = loginvc?.mViewPassword.textField.text ?? ""
        
        Utilities.showHUD()
        WebServiceSubClass.Login(reqModel: loginReqModel) { (status, response, error) in
            Utilities.hideHUD()
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
