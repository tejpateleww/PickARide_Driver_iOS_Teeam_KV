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
    
    //MARK: -Properties
    
    //MARK: -IBOutlets
    @IBOutlet weak var btnRememberMe: themeButton!
    @IBOutlet weak var lblSignIN: loginScreenLabel!
    @IBOutlet weak var lblWelcomeBack: loginScreenLabel!
    @IBOutlet weak var btnForgotPassword: loginScreenButton!
    @IBOutlet weak var btnSignIN: submitButton!
    @IBOutlet weak var lblOR: loginScreenLabel!
    @IBOutlet weak var lblDontHaveanAccount: loginScreenLabel!
    @IBOutlet weak var btnSIgnUP: loginScreenButton!
    @IBOutlet weak var txtEmailOrPhoneNumber: themeTextField!
    @IBOutlet weak var txtPassword: themeTextField!
    @IBOutlet weak var EmailView: changePasswordView!
    @IBOutlet weak var vwPassword: changePasswordView!
    
    //MARK: -View Life Cycle Methods
    var loginusermodel = LoginUserModel()
    var locationManager : LocationService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalization()
        hideKeyboardWhenTappedAround()
        setupTextfields(textfield: txtPassword)
        txtEmailOrPhoneNumber.autocapitalizationType = .none
        let _ = self.getLocation()
        self.txtPassword.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: -Other Methods
    
    func setupLocalization() {
        lblSignIN.text = ConstantString.LABEL_LOGIN_SIGN_IN
        lblWelcomeBack.text = ConstantString.LABEL_LOGIN_WELCOME_BACK
        txtEmailOrPhoneNumber.placeholder = ConstantString.PLACE_HOLDER_LOGIN_EMAILID
        txtPassword.placeholder = ConstantString.PLACE_HOLDER_LOGIN_PASSWORD
        btnForgotPassword.setTitle(ConstantString.BUTTON_TITLE_LOGIN_FORGOT_PASSWORD, for: .normal)
        btnSignIN.setTitle(ConstantString.BUTTON_TITLE_LOGIN_SIGN_IN, for: .normal)
        //        lblOR.text = "LoginScreen_lblOR".Localized()
        lblDontHaveanAccount.text = ConstantString.LABEL_LOGIN_DONT_HAVE_ACCOUNT
        btnSIgnUP.setTitle(ConstantString.BUTTON_TITLE_LOGIN_SIGN_UP, for: .normal)
    }
    
    //MARK: -IBActions
    
    func setupTextfields(textfield : UITextField) {
        let button = UIButton(type: .custom)
        button.isSelected = true
        button.setImage(UIImage(named: "showpassword"), for: .normal)
        button.setImage(UIImage(named: "hidepassword"), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
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
    
    @IBAction func signUP(_ sender: Any)
    {
        self.navigationController?.navigationBar.isHidden = false
        let controller = AppStoryboard.Login.instance.instantiateViewController(withIdentifier: SignUpVC.storyboardID)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnSignInClicked(_ sender: Any)
    {
        if isValidForLogin(){
            if self.getLocation(){
//                self.callLoginApi()
                user_defaults.setValue(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                appDel.navigateToMain()
            }
        }
        
    }
    
    @IBAction func ForgotPassword(_ sender: UIButton)
    {
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
        let checkEmail = txtEmailOrPhoneNumber.validatedText(validationType: .email)
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

//MARK:- TextField Delegate
extension LoginViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtPassword {
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return string == "" || newString.length <=  TEXTFIELD_MaximumLimit
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
        
        self.loginusermodel.webserviceForLogin()
    }
}

