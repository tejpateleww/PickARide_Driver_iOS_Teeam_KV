//
//  PasswordViewModel.swift
//  PickARide User
//
//  Created by apple on 7/6/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
class PasswordUserModel{
    weak var forgotPasswordVC : ForgotPasswordVC? = nil
    weak var changePasswordVC : ChangePasswordVC? = nil
    
    func webserviceForgotPassword(reqModel: ForgotPasswordReqModel){
        Utilities.showHud()
        WebServiceSubClass.ForgotPasswordApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: .success) {
                self.forgotPasswordVC?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func webserviceChangePassword(reqModel: ChangePasswordReqModel){
        Utilities.showHud()
        
        WebServiceSubClass.ChangePasswordApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: .success) {
                self.changePasswordVC?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
