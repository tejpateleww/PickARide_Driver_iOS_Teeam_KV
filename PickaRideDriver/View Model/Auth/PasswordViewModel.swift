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
            if status{
                Toast.show(title: UrlConstant.Success, message: apiMessage, state: .success)
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
    func webserviceChangePassword(reqModel: ChangePasswordReqModel){
        self.changePasswordVC?.btnSave.showLoading()
        WebServiceSubClass.ChangePasswordApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.changePasswordVC?.btnSave.hideLoading()
            if status{
                Toast.show(title: UrlConstant.Success, message: apiMessage, state: .success)
                self.changePasswordVC?.close()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
}
