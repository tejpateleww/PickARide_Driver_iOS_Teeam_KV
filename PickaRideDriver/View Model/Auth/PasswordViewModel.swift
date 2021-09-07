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
        self.forgotPasswordVC?.btnContinue.showLoading()
        WebServiceSubClass.ForgotPasswordApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.forgotPasswordVC?.btnContinue.hideLoading()
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: .success) {
                let controller = OtpVC.instantiate(fromAppStoryboard: .Login)
                self.forgotPasswordVC?.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
    func webserviceChangePassword(reqModel: ChangePasswordReqModel){
        Utilities.showHud()
        self.changePasswordVC?.btnSave.showLoading()
        WebServiceSubClass.ChangePasswordApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.changePasswordVC?.btnSave.hideLoading()
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: .success) {
                self.changePasswordVC?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
