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
    @IBOutlet weak var lblSignIN: loginScreenLabel!
    @IBOutlet weak var lblWelcomeBack: loginScreenLabel!
    @IBOutlet weak var mViewEmail: themeMeterialFloatingTextfield!
    @IBOutlet weak var mViewPassword: themeMeterialFloatingTextfield!
    @IBOutlet weak var textFieldPassword: emailPasswordTextField!
    @IBOutlet weak var textFieldEmailID: emailPasswordTextField!
    @IBOutlet weak var btnForgotPassword: loginScreenButton!
    @IBOutlet weak var btnSignIN: submitButton!
    @IBOutlet weak var lblOR: loginScreenLabel!
    @IBOutlet weak var lblDontHaveanAccount: loginScreenLabel!
    @IBOutlet weak var btnSIgnUP: loginScreenButton!
    
    //MARK: -View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalization()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: -Other Methods
    
    func setupLocalization() {
        
        lblSignIN.text = ConstantString.LABEL_LOGIN_SIGN_IN
        lblWelcomeBack.text = ConstantString.LABEL_LOGIN_WELCOME_BACK
        mViewEmail.textField.placeholder = ConstantString.PLACE_HOLDER_LOGIN_EMAILID
        mViewPassword.textField.placeholder = ConstantString.PLACE_HOLDER_LOGIN_PASSWORD
        btnForgotPassword.setTitle(ConstantString.BUTTON_TITLE_LOGIN_FORGOT_PASSWORD, for: .normal)
        btnSignIN.setTitle(ConstantString.BUTTON_TITLE_LOGIN_SIGN_IN, for: .normal)
        //        lblOR.text = "LoginScreen_lblOR".Localized()
        lblDontHaveanAccount.text = ConstantString.LABEL_LOGIN_DONT_HAVE_ACCOUNT
        btnSIgnUP.setTitle(ConstantString.BUTTON_TITLE_LOGIN_SIGN_UP, for: .normal)
    }
    
    //MARK: -IBActions
    
    @IBAction func signUP(_ sender: Any)
    {
        self.navigationController?.navigationBar.isHidden = false
        let controller = AppStoryboard.Login.instance.instantiateViewController(withIdentifier: SignUpVC.storyboardID)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnSignInClicked(_ sender: Any)
    {
        userDefault.setValue(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
        appDel.navigateToMain()
    }
    
    @IBAction func ForgotPassword(_ sender: Any)
    {

    }
}

fileprivate extension LoginViewController
{
    func isValidForLogin() -> Bool
    {
        guard let email = self.textFieldEmailID.text, let password = self.textFieldPassword.text else {
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

