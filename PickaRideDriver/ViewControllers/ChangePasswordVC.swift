//
//  ChangePasswordVC.swift
//  Cluttrfly-HAULER Driver
//
//  Created by Raju Gupta on 04/03/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit

class ChangePasswordVC: BaseVC, UITextFieldDelegate {

    //MARK:- IBOutlets
    @IBOutlet weak var txtCurrentPassword: ChangePasswordTextField!
    @IBOutlet weak var txtNewPassword: ChangePasswordTextField!
    @IBOutlet weak var txtConfirmPassword: ChangePasswordTextField!
    @IBOutlet weak var btnSave: submitButton!
    @IBOutlet weak var lblCurrentPassword: themeLabel!
    @IBOutlet weak var lblChangePassword: changePasswordLabel!
    @IBOutlet weak var lblNewPassword: themeLabel!
    @IBOutlet weak var lblConfirmPassword: themeLabel!
    
    //MARK:- Variables
    var submitButtonText = ""
    var isChangePassword : Bool = false
    var btnSubmitClosure : (() -> ())?

    var changePasswordUserModel = PasswordUserModel()
    //MARK:- View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtNewPassword.delegate = self
        txtCurrentPassword.delegate = self
        txtConfirmPassword.delegate = self
//        SetNavigationBar(controller: self, Left: true, Right: false, Title: "", IsGreen: true)
        
        self.txtCurrentPassword.tag = 101
        self.txtNewPassword.tag = 102
        self.txtConfirmPassword.tag = 103
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        setupTextfields(textfield: txtConfirmPassword)
        setupTextfields(textfield: txtNewPassword)
        setupTextfields(textfield: txtCurrentPassword)
    }
    
    //MARK:- Custom Methods
    func setupTextfields(textfield : UITextField) {
        let button = UIButton(type: .custom)
        button.isSelected = true
        button.setImage(UIImage(named: "showpassword"), for: .normal)
        button.setImage(UIImage(named: "hidepassword"), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -32, bottom: -0, right: 0)
        button.frame = CGRect(x: CGFloat(textfield.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.tag = textfield.tag
        button.addTarget(self, action: #selector(self.showHidePassword), for: .touchUpInside)
        textfield.rightView = button
        textfield.rightViewMode = .always
    }
    @IBAction func showHidePassword(_ sender : UIButton) {
        
        if sender.tag == 101 {
            sender.isSelected = !sender.isSelected
            self.txtCurrentPassword.isSecureTextEntry = sender.isSelected
        } else if sender.tag == 102 {
            sender.isSelected = !sender.isSelected
            self.txtNewPassword.isSecureTextEntry = sender.isSelected
        } else if sender.tag == 103 {
            sender.isSelected = !sender.isSelected
            self.txtConfirmPassword.isSecureTextEntry = sender.isSelected
            
        }
        
    }
    
    //MARK:- Textfield delegate method
    
    
    //MARK:- IBActions
    @IBAction func btnCancelTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSaveTap(_ sender: Any) {
        //login view controller root
//        if (!self.validation()){
//            webserviceForChangePasswod()
//            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
//        }
        
    }
}


//MARK:- TxtField Delegate
extension ChangePasswordVC{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtCurrentPassword{
            if (string == " ") {
                Utilities.showAlert(AppInfo.appName, message: "Space should not allow in password", vc: self)
                   return false
               }
        // If consecutive spaces entered by user
         return true
            
        }else if textField == txtNewPassword{
            if (string == " ") {
                Utilities.showAlert(AppInfo.appName, message: "Space should not allow in password", vc: self)
                   return false
               }
        // If consecutive spaces entered by user
         return true
            
        }else if textField == txtConfirmPassword{
            if (string == " ") {
                Utilities.showAlert(AppInfo.appName, message: "Space should not allow in password", vc: self)
                   return false
               }
        // If consecutive spaces entered by user
         return true
        }
        return true
    }
    
}


//MARK:- Validation & Api
extension ChangePasswordVC{
    func validation()->Bool{
        var strTitle : String?
        let oldPassword = self.txtCurrentPassword.validatedText(validationType: .password(field: self.txtCurrentPassword.placeholder?.lowercased() ?? ""))
        let newPassword = txtNewPassword.validatedText(validationType: .password(field: self.txtNewPassword.placeholder?.lowercased() ?? ""))
        let confirmPassword = txtConfirmPassword.validatedText(validationType: .requiredField(field: self.txtConfirmPassword.placeholder?.lowercased() ?? ""))
         
        if isChangePassword && !oldPassword.0{
            strTitle = oldPassword.1
        }else if !newPassword.0{
            strTitle = newPassword.1
        }else if !confirmPassword.0{
            strTitle = confirmPassword.1
        }else if txtNewPassword.text != txtConfirmPassword.text{
            strTitle = "New password & confirm password should be same."
        }

        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
            return false
        }
        
        return true
    }
    
    func callChangePasswordApi(){
        self.changePasswordUserModel.changePasswordVC = self
        
        let reqModel = ChangePasswordReqModel()
        reqModel.oldPassword = self.txtCurrentPassword.text ?? ""
        reqModel.newPassword = self.txtNewPassword.text ?? ""
        
        self.changePasswordUserModel.webserviceChangePassword(reqModel: reqModel)
    }
}
