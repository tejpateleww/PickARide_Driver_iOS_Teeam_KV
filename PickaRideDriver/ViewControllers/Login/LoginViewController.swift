//
//  LoginViewController.swift
//  ApiStructureModule
//
//  Created by EWW071 on 14/03/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

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
    @IBOutlet weak var txtEmailOrPhoneNumber: ChangePasswordTextField!
    @IBOutlet weak var txtPassword: ChangePasswordTextField!
    
    //MARK: -View Life Cycle Methods
    var loginusermodel = LoginUserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalization()
        hideKeyboardWhenTappedAround()
        setupTextfields(textfield: txtPassword)
        txtEmailOrPhoneNumber.autocapitalizationType = .none
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
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: -16, bottom: -5, right: 0)
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
//        if isValidForLogin(){
//            self.loginusermodel.loginvc = self
//            self.loginusermodel.webserviceForLogin()
//        }
        user_defaults.setValue(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
        appDel.navigateToMain()
      
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
}

fileprivate extension LoginViewController
{
    func isValidForLogin() -> Bool
    {
        guard let email = self.txtEmailOrPhoneNumber.text, let password = self.txtPassword.text else {
            return false
        }
        
        if (email.count <= 0)
        {
            self.showAlert(title: "", message: ConstantString.MESSAGE_LOGIN_EMAIL_MISSING, alertActions: [])
            return false
        }
        
        if (!email.isValidEmailAddress())
        {
            self.showAlert(title: "", message: ConstantString.MESSAGE_LOGIN_EMAIL_INVALID.Localized(), alertActions: [])
        }
        
        if (password.count <= 0)
        {
            self.showAlert(title: "", message:ConstantString.MESSAGE_LOGIN_PASSWORD_MISSING, alertActions: [])
            return false
        }
        
        return true
    }
    
}

//MARK: - API

extension LoginViewController
{
    
    
    
}

