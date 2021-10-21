//
//  RegisterViewModel.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 07/06/21.
//

import Foundation

class RegisterUserModel{
    
    weak var registerVC : OtpVC? = nil
    var registerRequestModel = RegisterFinalRequestModel()
    
    func webserviceRegisterOTP(reqModel: OTPRequestModel){
        self.registerVC?.btnAeero.showLoading()
        WebServiceSubClass.OTPRequestApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.registerVC?.btnAeero.hideLoading()
            if status{
                self.registerVC?.StringOTP = "\(response?.otp ?? 0)"
                self.registerVC?.otpToastDisplay()
                self.registerVC?.reversetimer()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure) {
                    self.registerVC?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}

class RegisterOTPUserModel{
    
    weak var registerVC : SignUpVC? = nil
    var registerRequestModel = RegisterFinalRequestModel()
    
    func webserviceRegisterOTP(reqModel: OTPRequestModel){
        self.registerVC?.btnNext.showLoading()
        WebServiceSubClass.OTPRequestApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.registerVC?.btnNext.hideLoading()
            if status{
                self.registerVC?.StringOTP = "\(response?.otp ?? 0)"
                self.registerVC?.storeDataInRegisterModel()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
}

class RegisterUserFinalModel{
    
    weak var vehicleDocumentVC : VehicleDocumentVC? = nil
    
    func webserviceRegister(reqModel: RegisterFinalRequestModel){
        self.vehicleDocumentVC?.btnNext.showLoading()
        WebServiceSubClass.Register(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.vehicleDocumentVC?.btnNext.hideLoading()
            if status{
                
//                  user_defaults.setValue(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
//                user_defaults.setValue(response?.data?.xAPIKey, forKey: UserDefaultsKey.X_API_KEY.rawValue)
//                SingletonClass.sharedInstance.UserProfilData = response?.data
//                user_defaults.setUserData()
//
//                if let apikey = response?.data?.xAPIKey{
//                    SingletonClass.sharedInstance.Api_Key = apikey
//                    SingletonClass.sharedInstance.UserProfilData?.xAPIKey = apikey
//                    user_defaults.setValue(apikey, forKey: UserDefaultsKey.X_API_KEY.rawValue)
//                }
//
//                if let userID = response?.data?.id{
//                    SingletonClass.sharedInstance.UserId = userID
//                }
                
                self.vehicleDocumentVC?.goToWaitingForApproval()
                
                
            }else{
                Utilities.showAlertOfAPIResponse(param: apiMessage, vc: self.vehicleDocumentVC!)
            }
        }
    }
}
