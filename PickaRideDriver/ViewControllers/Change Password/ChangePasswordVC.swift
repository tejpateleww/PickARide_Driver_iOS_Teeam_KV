//
//  ChangePasswordVC.swift
//  Cluttrfly-HAULER Driver
//
//  Created by Raju Gupta on 04/03/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit

class ChangePasswordVC: BaseVC {

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
    var btnSubmitClosure : (() -> ())?
    var changePasswordUserModel = PasswordUserModel()
    let RISTRICTED_CHARACTERS_FOR_PASSWORD = " "
    
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
        if(self.validation()){
            callChangePasswordApi()
        }
    }
    
    func close(){
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK:- Validation & Api
extension ChangePasswordVC{
    func validation()->Bool{
        var strTitle : String?
        let oldPassword = self.txtCurrentPassword.validatedText(validationType: .password(field: self.txtCurrentPassword.placeholder?.lowercased() ?? ""))
        let newPassword = txtNewPassword.validatedText(validationType: .password(field: self.txtNewPassword.placeholder?.lowercased() ?? ""))
        let confirmPassword = txtConfirmPassword.validatedText(validationType: .password(field: self.txtConfirmPassword.placeholder?.lowercased() ?? ""))
         
        if !oldPassword.0{
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

//MARK:- TextField Delegate
extension ChangePasswordVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        
        case self.txtCurrentPassword :
            let set = CharacterSet(charactersIn: RISTRICTED_CHARACTERS_FOR_PASSWORD)
            let inverted = set.inverted
            let filtered = string.components(separatedBy: inverted).joined(separator: "")
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            let char = string.cString(using: String.Encoding.utf8)!
            let isBackSpace = strcmp(char, "\\b")
            return (string != filtered) ? (newString.length <= TEXTFIELD_PASSWORD_MaximumLimit) : (isBackSpace == -92) ? true : false
            
        case self.txtNewPassword :
            let set = CharacterSet(charactersIn: RISTRICTED_CHARACTERS_FOR_PASSWORD)
            let inverted = set.inverted
            let filtered = string.components(separatedBy: inverted).joined(separator: "")
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            let char = string.cString(using: String.Encoding.utf8)!
            let isBackSpace = strcmp(char, "\\b")
            return (string != filtered) ? (newString.length <= TEXTFIELD_PASSWORD_MaximumLimit) : (isBackSpace == -92) ? true : false
            
        case self.txtConfirmPassword :
            let set = CharacterSet(charactersIn: RISTRICTED_CHARACTERS_FOR_PASSWORD)
            let inverted = set.inverted
            let filtered = string.components(separatedBy: inverted).joined(separator: "")
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            let char = string.cString(using: String.Encoding.utf8)!
            let isBackSpace = strcmp(char, "\\b")
            return (string != filtered) ? (newString.length <= TEXTFIELD_PASSWORD_MaximumLimit) : (isBackSpace == -92) ? true : false

        default:
            print("")
        }
       
        return true
    }
}
