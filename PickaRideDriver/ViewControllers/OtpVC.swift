//
//  OtpVC.swift
//  Cluttrfly
//
//  Created by Raju Gupta on 19/03/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit

protocol OTPTextFieldDelegate   {
    func textFieldDidDelete(currentTextField: OTPTextField)
}

class OtpVC: BaseVC, UITextFieldDelegate, OTPTextFieldDelegate {
    
    //MARK:- IBOutlets
    @IBOutlet weak var lblDisplayMesagewithNumber: themeLabel!
    @IBOutlet var txtOtp: [OTPTextField]!
    @IBOutlet weak var lblCountDown: themeLabel!
    @IBOutlet weak var btnAeero: themeButton!
    @IBOutlet weak var btnArrowBottom: NSLayoutConstraint!
    
    @IBOutlet weak var btnResendCode: UIButton!
    //MARK:- Variables
    var StringOTP : String = ""
//    var objectRegister = RegisterReqModel()
    var clickBtnVerify : (() -> ())?
    var textFieldsIndexes:[OTPTextField:Int] = [:]
    var counter = 30
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let phone = objectRegister.mobileno
//
//               let splitedPhoneNoArr = phone.components(separatedBy: " ")
//               let countryCode = splitedPhoneNoArr[0]
//               let onlyNo: String? = splitedPhoneNoArr.count > 1 ? splitedPhoneNoArr[1] : nil
//               let phoneNo: String? = countryCode + onlyNo!
        
//        let range = objectRegister.mobileno.range(of: "-")
//        let LastDigit = objectRegister.mobileno[range!.upperBound...]
//        let regularAttribute = [
//                      NSAttributedString.Key.font: CustomFont.regular.returnFont(19)
//                   ]
//        let num = NSAttributedString(string: " (******\(LastDigit))?", attributes: regularAttribute)
//        let newString = NSMutableAttributedString()
//        newString.append(num)
//        lblDisplayMesagewithNumber.te
        reversetimer()
//        lblDisplayMesagewithNumber.text = "Please enter the 4 digit code sent to you at ******" + objectRegister.mobileno.suffix(4)
        btnAeero.layer.cornerRadius = 16
//        SetNavigationBar(controller: self, Left: true, Right: false, Title: "", IsGreen: true)
        for i in txtOtp {
            i.layer.cornerRadius = 16
        }
        
        for index in 0 ..< txtOtp.count {
            textFieldsIndexes[txtOtp[index]] = index
        }
        txtOtp[0].myDelegate = self
        txtOtp[1].myDelegate = self
        txtOtp[2].myDelegate = self
        txtOtp[3].myDelegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
    }
    
    func reversetimer(){
        timer.invalidate() // just in case this button is tapped multiple times
        
        lblCountDown.isHidden = false
        btnResendCode.isUserInteractionEnabled = false
        btnResendCode.setTitle("Resend code in", for: .normal)
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        if counter > 0{
            counter -= 1
            lblCountDown.text =  counter > 9 ? "00:\(counter)" : "00:0\(counter)"
        } else {
            lblCountDown.isHidden = true
            btnResendCode.isUserInteractionEnabled = true
            btnResendCode.setTitle("Resend code", for: .normal)
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.btnArrowBottom.constant = keyboardHeight + 12
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 0 {
            setNextResponder(textFieldsIndexes[textField as! OTPTextField], direction: .right)
            textField.text = string
            return true
        } else if range.length == 1 {
            setNextResponder(textFieldsIndexes[textField as! OTPTextField], direction: .left)
            textField.text = ""
            return false
        }
        return false
    }
    
    func textFieldDidDelete(currentTextField: OTPTextField) {
        print("delete")
        setNextResponder(textFieldsIndexes[currentTextField], direction: .left)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        //        if textField != txtCode1 {
        setNextResponderBlank(textFieldsIndexes[textField as! OTPTextField])
        //        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.btnArrowBottom.constant = 20
    }
    func validation() -> Bool {
        //        let strEnteredOTP = "\(txtCode1.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")\(txtCode2.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")\(txtCode3.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")\(txtCode4.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")"
        var strEnteredOTP = ""
        for index in 0 ..< txtOtp.count {
            strEnteredOTP.append(txtOtp[index].text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        }
        
        if strEnteredOTP == "" {
            //                Utilities.ShowAlert(OfMessage: "validMsg_RequiredOtp".Localized())
            Utilities.ShowAlert(OfMessage: "Please enter verification code")
            return false
        } else if self.StringOTP != strEnteredOTP {
            self.clearAllFields()
            //                Utilities.ShowAlert(OfMessage: "validMsg_InvalidOtp".Localized())
            Utilities.ShowAlert(OfMessage: "Please enter valid verification code")
            return false
        }
        return true
    }
    
    func clearAllFields() {
        for index in 0 ..< txtOtp.count {
            txtOtp[index].text = ""
        }
    }
    
    func setNextResponder(_ index:Int?, direction: Direction) {
        guard let index = index else { return }
        
        if direction == .left {
            index == 0 ?
                (_ = txtOtp.first?.resignFirstResponder()) :
                (_ = txtOtp[(index - 1)].becomeFirstResponder())
            if index > 0 {
                let neIndex = index + 1
                for i in neIndex..<txtOtp.count {
                    txtOtp[i].text = ""
                }
                
                //                let prevIndex = index - 1
                //                for i in 0..<prevIndex {
                //                    txtOtpOutletCollection[i].isUserInteractionEnabled = false
                //                }
            }
        } else {
            index == txtOtp.count - 1 ?
                (_ = txtOtp.last?.resignFirstResponder()) :
                (_ = txtOtp[(index + 1)].becomeFirstResponder())
        }
    }
    
    func setNextResponderBlank(_ index:Int?) {
        if index! >= 0 {
            let neIndex = index! + 1
            for i in neIndex..<txtOtp.count {
                txtOtp[i].text = ""
               
            }
        }
    }
    
    
    //MARK:- IBActions
    
    @IBAction func btnAeeroTap(_ sender: Any) {
//        UserDefaults.standard.setValue(true, forKey: "login")
//        appDel.navigateToHome()
//        let vc : VehicalInformationVC = VehicalInformationVC.instantiate(fromAppStoryboard: .Main)
//        self.navigationController?.pushViewController(vc, animated: true)
        let vc : BankDetailsVC = BankDetailsVC.instantiate(fromAppStoryboard: .Login)
        self.navigationController?.pushViewController(vc, animated: true)
//        if (validation()){
////            let vc : VehicalInformationVC = VehicalInformationVC.instantiate(fromAppStoryboard: .Main)
////            vc.objectRegister = self.objectRegister
////            self.navigationController?.pushViewController(vc, animated: true)
//    
//        }
        
    }
    @IBAction func btnResendCodeTap(_ sender: Any) {
//        if lblCountDown.text == "0"{
//            counter = 30
//            webserviceForOtp()
//            reversetimer()
//
//        }
        txtOtp.forEach { (textfield) in
            textfield.text = ""
        }
            counter = 31
//            webserviceForOtp()
            reversetimer()
        
    }
    
    
}
//MARK:- Api Call
extension OtpVC{
//    func webservicesForSignUp(){
//        self.showHUD()
//        WebServiceSubClass.register(UpdateProfileReq: objectRegister, img: UIImage()) { (json, status, response) in
//            self.hideHUD()
//            if status{
//                let register  = RegisterMain.init(fromJson: json)
//                print(json)
//                SingletonClass.sharedInstance.userProfile = register
//                userDefault.setValue(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
//                SingletonClass.sharedInstance.Api_Key = register.data.xApiKey
//                userDefault.setUserData()
////                UserDefaults.standard.setValue(true, forKey: "login")
//                appDel.navigateToHome()
//
//            }else
//            {
//                if let strMessage = json["message"].string {
//                    Utilities.showAlertOfAPIResponse(param: strMessage, vc: self)
//                }else {
//                    Utilities.showAlertOfAPIResponse(param: "Something went wrong", vc: self)
//                }
//            }
//        }
//    }
    
//    func webserviceForOtp(){
//        var reqmodel = otpReqModel()
//        reqmodel.countrycode = "+1"
//        reqmodel.email = objectRegister.email
//        reqmodel.mobileno = objectRegister.mobileno
//
//        self.showHUD()
//        WebServiceSubClass.otp(otpModel: reqmodel) { (json, status, response) in
//            self.hideHUD()
//            if status{
//                let otp = OtpMain.init(fromJson: json)
//                print(json)
//                self.StringOTP = String(otp.otp)
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


class OTPTextField: UITextField {
    
    var myDelegate: OTPTextFieldDelegate?
    
    override func deleteBackward() {
        super.deleteBackward()
        myDelegate?.textFieldDidDelete(currentTextField: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9529411765, blue: 0.968627451, alpha: 1)
        self.textAlignment = .center
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0
        self.font = CustomFont.medium.returnFont(17)
        self.tintColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
    }
}
enum Direction { case left, right }
