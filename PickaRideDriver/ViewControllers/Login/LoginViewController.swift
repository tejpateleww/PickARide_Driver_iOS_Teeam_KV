//
//  LoginViewController.swift
//  ApiStructureModule
//
//  Created by EWW071 on 14/03/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit
import CoreLocation
class LoginViewController: UIViewController {
    
    //MARK: -IBOutlets
    @IBOutlet weak var lblPassword: themeLabel!
    @IBOutlet weak var btnRememberMe: themeButton!
    @IBOutlet weak var lblEmail: themeLabel!
    @IBOutlet weak var lblSignIN: loginScreenLabel!
    @IBOutlet weak var lblWelcomeBack: loginScreenLabel!
    @IBOutlet weak
    var btnForgotPassword: loginScreenButton!
    @IBOutlet weak var btnSignIN: themeButton!
    @IBOutlet weak var lblOR: loginScreenLabel!
    @IBOutlet weak var lblDontHaveanAccount: loginScreenLabel!
    @IBOutlet weak var btnSIgnUP: loginScreenButton!
    @IBOutlet weak var txtEmailOrPhoneNumber: themeTextField!
    @IBOutlet weak var txtPassword: themeTextField!
    @IBOutlet weak var EmailView: UIView!
    @IBOutlet weak var vwPassword: UIView!
    
    //MARK: -View Life Cycle Methods
    var loginusermodel = LoginUserModel()
    var locationManager : LocationService?
    let ACCEPTABLE_CHARACTERS_FOR_EMAIL = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@."
    let RISTRICTED_CHARACTERS_FOR_PASSWORD = " "
    let ACCEPTABLE_CHARACTERS_FOR_PHONE = "0123456789"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalization()
        hideKeyboardWhenTappedAround()
        setupTextfields(textfield: txtPassword)
        txtEmailOrPhoneNumber.autocapitalizationType = .none
        let _ = self.getLocation()
        self.txtPassword.delegate = self
#if targetEnvironment(simulator)
        txtEmailOrPhoneNumber.text = "9727528777"
        txtPassword.text = "vyas1313"
#endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: -Other Methods
    
    func setupLocalization() {
        lblSignIN.text = ConstantString.LABEL_LOGIN_SIGN_IN
        lblWelcomeBack.text = ConstantString.LABEL_LOGIN_WELCOME_BACK
        txtPassword.placeholder = ConstantString.PLACE_HOLDER_LOGIN_PASSWORD
        btnForgotPassword.setTitle(ConstantString.BUTTON_TITLE_LOGIN_FORGOT_PASSWORD, for: .normal)
        btnSignIN.setTitle(ConstantString.BUTTON_TITLE_LOGIN_SIGN_IN, for: .normal)
        lblDontHaveanAccount.text = ConstantString.LABEL_LOGIN_DONT_HAVE_ACCOUNT
        btnSIgnUP.setTitle(ConstantString.BUTTON_TITLE_LOGIN_SIGN_UP, for: .normal)
    }
    
    //MARK: -IBActions
    
    func setupTextfields(textfield : UITextField) {
        let button = UIButton(type: .custom)
        button.isSelected = true
        button.setImage(UIImage(named: "showpassword"), for: .normal)
        button.setImage(UIImage(named: "hidepassword"), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -32, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(textfield.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.tag = textfield.tag
        button.addTarget(self, action: #selector(self.showHidePassword), for: .touchUpInside)
        textfield.rightView = button
        textfield.rightViewMode = .always
    }
    
    @IBAction func showHidePassword(_ sender : UIButton) {
        sender.isSelected = !sender.isSelected
        self.txtPassword.isSecureTextEntry = sender.isSelected
    }
    
    @IBAction func signUP(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
        let controller = AppStoryboard.Login.instance.instantiateViewController(withIdentifier: SignUpVC.storyboardID)
        self.navigationController?.pushViewController(controller, animated: true)
//        let controller = PersonalDocumentVC.instantiate(fromAppStoryboard: .Login)
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnSignInClicked(_ sender: Any) {
        if isValidForLogin(){
            if self.getLocation(){
                self.callLoginApi()
            }
        }
    }
    
    @IBAction func ForgotPassword(_ sender: UIButton) {
        if sender.tag == 1{
            sender.isSelected = !sender.isSelected
        }else{
            let vc : ForgotPasswordVC = ForgotPasswordVC.instantiate(fromAppStoryboard: .Login)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func getLocation() -> Bool {
        if SingletonClass.sharedInstance.userCurrentLocation == nil{
            self.locationManager = LocationService()
            self.locationManager?.startUpdatingLocation()
            return false
        }else{
            return true
        }
    }
}

extension LoginViewController{
    func isValidForLogin() -> Bool{
        var strTitle : String?
        
//        if(self.txtEmailOrPhoneNumber.text == ""){
//            Toast.show(title: UrlConstant.Required, message: "Please enter email", state: .failure)
//            return false
//        }
        let checkEmail = txtEmailOrPhoneNumber.validatedText(validationType: .phoneNo)
        let password = txtPassword.validatedText(validationType: .password(field: self.txtPassword.placeholder?.lowercased() ?? ""))
        
        if !checkEmail.0{
            strTitle = checkEmail.1
        }else if !password.0{
            strTitle = password.1
        }

        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
            return false
        }
        
        return true
    }
}

//MARK: - API
extension LoginViewController{
    func callLoginApi(){
        self.loginusermodel.loginvc = self
        
        let reqModel = LoginReqModel()
        reqModel.username = self.txtEmailOrPhoneNumber.text ?? ""
        reqModel.password = self.txtPassword.text ?? ""
        self.loginusermodel.webserviceForLogin(reqModel: reqModel)
    }
}


//MARK:- TextField Delegate
extension LoginViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        
        case self.txtEmailOrPhoneNumber :
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_FOR_PHONE).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return (string == filtered) ? (newString.length <= MAX_PHONE_DIGITS) : false

        case self.txtPassword :
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
