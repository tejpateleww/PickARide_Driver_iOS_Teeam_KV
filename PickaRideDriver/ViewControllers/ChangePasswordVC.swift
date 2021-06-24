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
    @IBOutlet weak var lblChangePassword: changePasswordLabel!
    
    //MARK:- Variables
    
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
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: -16, bottom: -5, right: 0)
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
    
    //MARK:- Validations
    func validations()->Bool{
        
        let currentPW = txtCurrentPassword.validatedText(validationType: ValidatorType.password(field: txtCurrentPassword.placeholder?.lowercased() ?? ""))
        let newPW = txtNewPassword.validatedText(validationType: ValidatorType.password(field: txtNewPassword.placeholder?.lowercased() ?? ""))
        let confirmPW = txtConfirmPassword.validatedText(validationType: ValidatorType.password(field: txtConfirmPassword.placeholder?.lowercased() ?? ""))
        if (!currentPW.0){
            Utilities.ShowAlert(OfMessage: currentPW.1)
            return currentPW.0
        }else if (!newPW.0){
            Utilities.ShowAlert(OfMessage: newPW.1)
            return newPW.0
        }
        // 11
        else if (!confirmPW.0){
            Utilities.ShowAlert(OfMessage: confirmPW.1)
            return confirmPW.0
        } else if txtNewPassword.text?.lowercased() != txtConfirmPassword.text?.lowercased(){
            Utilities.ShowAlert(OfMessage: "New password & confirm password should be same")
            return false
        }
        return true
        
    }
    
    //MARK:- Textfield delegate method
    
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
    
    //MARK:- IBActions
    @IBAction func btnCancelTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSaveTap(_ sender: Any) {
        //login view controller root
        if (validations()){
//            webserviceForChangePasswod()
//            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}


//MARK:- Api Call
extension ChangePasswordVC{
//    func webserviceForChangePasswod(){
//        let reqmodel = ChangePasswordReqModel()
//        reqmodel.new_password = txtNewPassword.text ?? ""
//        reqmodel.old_password = txtCurrentPassword.text ?? ""
//        reqmodel.customer_id = SingletonClass.sharedInstance.userProfile.data.id
//
//        self.showHUD()
//        WebServiceSubClass.ChangePassword(changepassModel: reqmodel) { (json, status, error) in
//            self.hideHUD()
//            if status{
//                self.navigationController?.popViewController(animated: true)
//            }else
//            {
//                if let strMessage = json["message"].string {
//                    Utilities.showAlertOfAPIResponse(param: strMessage, vc: self)
//                }else {
//                    Utilities.showAlertOfAPIResponse(param: "No internet found. Check your connection or try again", vc: self)
//                }
//            }
//        }
//    }
}
