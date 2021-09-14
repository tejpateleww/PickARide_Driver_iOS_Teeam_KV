//
//  VerifyViewController.swift
//  PickARide User
//
//  Created by Apple on 15/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import UIKit

class VerifyViewController: BaseVC {

    //MARK: -Properties
    var phoneNumber = " +966 *** **** 656"
    var isFrmRegister = false
    
    //MARK: -IBOutlets
    @IBOutlet weak var lblVerifyPhoneNumber: verifyVcLabel!
    @IBOutlet weak var lblCheckSMS: verifyVcLabel!
    @IBOutlet weak var textFieldOTP1: verifyPinTextField!
    @IBOutlet weak var textFieldOTP2: verifyPinTextField!
    @IBOutlet weak var textFieldOTP3: verifyPinTextField!
    @IBOutlet weak var textFieldOTP4: verifyPinTextField!
    @IBOutlet weak var lblDontRecive: verifyVcLabel!
    @IBOutlet weak var btnRecendCode: ResendCodeButton!
    @IBOutlet weak var btnVerify: submitButton!
    
    //MARK: -View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setLocalization()
        setValue()
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: -other methods
    func setLocalization() {
        lblVerifyPhoneNumber.text = "VerifyVC_lblVerifyPhoneNumber".Localized()
        lblCheckSMS.text = "VerifyVC_lblCheckSMS".Localized() + phoneNumber
        lblDontRecive.text = "VerifyVC_lblDontRecive".Localized()
        btnRecendCode.setTitle("VerifyVC_btnResendCode".Localized(), for: .normal)
        btnVerify.setTitle("VerifyVC_Verify".Localized(), for: .normal)
        
//        setLabel()
    }
    
    func setValue() {
        textFieldOTP1.text = "4"
        textFieldOTP2.text = "2"
        textFieldOTP3.text = "6"
        textFieldOTP4.text = "8"
    }
    
//    func setLabel() {
//        let attributedString = NSMutableAttributedString(string: lblCheckSMS.text!)
//
//        let strNumber : NSString = lblCheckSMS.text as! NSString
//        let range = (strNumber).range(of: phoneNumber)
//        print(range.location)
//        attributedString.addAttribute(NSAttributedString.Key.font, value: CustomFont.regular.returnFont(16), range: NSMakeRange(0, attributedString.length))
//        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: colors.loginPlaceHolderColor.value, range: NSMakeRange(0, attributedString.length))
//        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: colors.phoneNumberColor.value , range: range)
//        lblCheckSMS.attributedText = attributedString
//        //
//    }
    
    //MARK: -IBActions
    @IBAction func Verify(_ sender: Any) {
//        if isFrmRegister {
//            user_defaults.setValue(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
//            appDel.navigateToMain()
//        } else {
//        let controller = AppStoryboard.Login.instance.instantiateViewController(withIdentifier: ChangePasswordPopUpViewController.storyboardID) as! ChangePasswordPopUpViewController
//                controller.submitButtonText = "ChangePassword_btnSetPassword".Localized()
//                controller.isChangePassword = false
//
//        controller.btnSubmitClosure = {
//            user_defaults.setValue(false, forKey: UserDefaultsKey.isUserLogin.rawValue)
//            appDel.navigateToLogin()
//        }
//        controller.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//        let navigationController = UINavigationController(rootViewController: controller)
//        navigationController.modalPresentationStyle = .overCurrentContext
//        navigationController.modalTransitionStyle = .crossDissolve
//        navigationController.navigationBar.isHidden = true
//        self.present(navigationController, animated: true, completion: nil)
//        }
        let vc : BankDetailsVC = BankDetailsVC.instantiate(fromAppStoryboard: .Login)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: -API Calls

}
