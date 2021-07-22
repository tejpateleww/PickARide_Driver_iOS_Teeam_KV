//
//  ForgotPasswordVC.swift
//  PickaRideDriver
//
//  Created by Harsh on 24/06/21.
//

import UIKit

class ForgotPasswordVC: BaseVC {

    @IBOutlet weak var btnSend: themeButton!
    @IBOutlet weak var lblForgotPassword: themeLabel!
    @IBOutlet weak var txtForgotPassword: themeTextField!
    
    var forgotPasswordUserModel = PasswordUserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        setNavigationBarInViewController(controller: self, naviColor: colors.myride.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        txtForgotPassword.placeholder = ConstantString.PLACE_HOLDER_LOGIN_EMAILID
    }
    @IBAction func btnSendTap(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        if (validation()){
            callForgotPasswordApi()
        }
    }
    
}
//MARK:- Validation & Api
extension ForgotPasswordVC{
    func validation()->Bool{
        var strTitle : String?
        let checkEmail = self.txtForgotPassword.validatedText(validationType: .email)
        
        if !checkEmail.0{
            strTitle = checkEmail.1
        }

        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
            return false
        }
        
        return true
    }
    
    func callForgotPasswordApi(){
        self.forgotPasswordUserModel.forgotPasswordVC = self
        
        let reqModel = ForgotPasswordReqModel()
        reqModel.email = self.txtForgotPassword.text ?? ""
        
        self.forgotPasswordUserModel.webserviceForgotPassword(reqModel: reqModel)
    }
}
