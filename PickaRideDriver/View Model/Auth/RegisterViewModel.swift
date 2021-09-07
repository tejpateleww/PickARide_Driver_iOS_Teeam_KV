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

class RegisterUserFinalModel{
    
    weak var vehicleDocumentVC : VehicleDocumentVC? = nil
    
    func webserviceRegister(reqModel: RegisterFinalRequestModel){
        self.vehicleDocumentVC?.btnNext.showLoading()
        WebServiceSubClass.Register(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.vehicleDocumentVC?.btnNext.hideLoading()
            if status{
                SingletonClass.sharedInstance.LoginRegisterUpdateData = response
                user_defaults.setUserData()
                user_defaults.setValue(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                self.vehicleDocumentVC?.goToWaitingForApproval()
            }else{
                Utilities.showAlertOfAPIResponse(param: apiMessage, vc: self.vehicleDocumentVC!)
            }
        }
    }
}
