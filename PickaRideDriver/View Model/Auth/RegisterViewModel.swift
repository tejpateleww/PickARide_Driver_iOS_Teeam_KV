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
        Utilities.showHud()
        WebServiceSubClass.OTPRequestApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: status ? .success : .failure)
            if status{
                self.registerVC?.StringOTP = "\(response?.otp ?? 0)"
                self.registerVC?.otpToastDisplay()
                self.registerVC?.reversetimer()
            }else{
                Utilities.showAlertAction(AppName, message: apiMessage, vc: self.registerVC!)
            }
        }
    }
}
