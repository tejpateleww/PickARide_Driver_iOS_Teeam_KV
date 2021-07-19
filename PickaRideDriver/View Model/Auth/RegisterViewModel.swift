//
//  RegisterViewModel.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 07/06/21.
//

import Foundation
class RegisterUserModel{
    weak var registerVC : SignUpVC? = nil
    var registerRequestModel = RegisterFinalRequestModel()
    
    func webserviceRegisterOTP(){
        func webserviceOTP(reqModel: OTPRequestModel){
            Utilities.showHud()
            WebServiceSubClass.OTPRequestApi(reqModel: reqModel) { (status, apiMessage, response, error) in
                Utilities.hideHud()
                Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: status ? .success : .failure)
                
                if status{
                    let controller = OtpVC.instantiate(fromAppStoryboard: .Login)
                    controller.StringOTP = String(format: "%d", response?.otp ?? 0)
                    controller.registerReqModel = self.registerRequestModel
                    self.registerVC?.navigationController?.pushViewController(controller, animated: true)
                }
            }
        }
    }
}


class OTPUserModel{
    weak var registerOTPVC: OtpVC? = nil
    
    func webserviceTORegister(){
        if let reqModel = registerOTPVC?.registerReqModel {
            
            Utilities.showHUD()
            WebServiceSubClass.Register(reqModel: reqModel)  { (status, apiMessage, response, error) in
                
                Utilities.hideHUD()
                if status{
                    
                    user_defaults.set(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                    SingletonClass.sharedInstance.LoginRegisterUpdateData = response
                    if let apikey =  response?.data.xAPIKey{
                        SingletonClass.sharedInstance.Api_Key = apikey
                        user_defaults.set(apikey , forKey: UserDefaultsKey.X_API_KEY.rawValue)
                    }
                    if let userID =  response?.data.id{
                        SingletonClass.sharedInstance.UserId = userID
                    }
                    user_defaults.setUserData()
                    appDel.navigateToHome()
                    
                }
                
            }
        }
        
    }
    
}
