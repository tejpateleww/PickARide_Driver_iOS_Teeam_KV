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
        
//        setupLocalization()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: -Other Methods
    
    func setupLocalization() {
        lblSignIN.text = "LoginScreen_lblSignIN".Localized()
        lblWelcomeBack.text = "LoginScreen_lblWelcomeBack".Localized()
        
        textFieldEmailID.placeholder = "LoginScreen_textFieldEmailID_place".Localized()
        textFieldPassword.placeholder = "LoginScreen_textFieldPassword_place".Localized()
        
        btnForgotPassword.setTitle("LoginScreen_btnForgotPassword".Localized(), for: .normal)
        
        btnSignIN.setTitle("LoginScreen_btnSignIN".Localized(), for: .normal)
        
//        lblOR.text = "LoginScreen_lblOR".Localized()
        
        lblDontHaveanAccount.text = "LoginScreen_lblDontHaveanAccount".Localized()
        
        btnSIgnUP.setTitle("LoginScreen_btnSIgnUP".Localized(), for: .normal)
    }
    
    //MARK: -IBActions
    
    @IBAction func signUP(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
        let controller = AppStoryboard.Login.instance.instantiateViewController(withIdentifier: SignUpVC.storyboardID)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnSignInClicked(_ sender: Any) {
        userDefault.setValue(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
        appDel.navigateToMain()
    }
    
    @IBAction func ForgotPassword(_ sender: Any) {
//        let controller = AppStoryboard.Login.instance.instantiateViewController(withIdentifier: ChangePasswordPopUpViewController.storyboardID) as! ChangePasswordPopUpViewController
//        controller.submitButtonText = "ChangePassword_btnChangePassword".Localized()
//        controller.isChangePassword = true
//        controller.btnSubmitClosure = {
//            self.dismiss(animated: true, completion: nil)
//        }
//        self.present(controller, animated: true, completion: nil)
        //self.navigationController?.navigationBar.isHidden = false
        
        
//        let controller = AppStoryboard.Login.instance.instantiateViewController(withIdentifier: ForgotPasswordVC.storyboardID)
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: -API Calls
    
    
  
}
