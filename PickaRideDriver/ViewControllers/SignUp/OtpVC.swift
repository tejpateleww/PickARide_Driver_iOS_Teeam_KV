//
//  OtpVC.swift
//  PickaRideDriver
//
//  Created by Tej on 07/05/21.
//

import UIKit

protocol OTPTextFieldDelegate   {
    func textFieldDidDelete(currentTextField: OTPTextField)
}

class OtpVC: BaseVC, OTPTextFieldDelegate {
    
    //MARK:- IBOutlets
    @IBOutlet weak var lblDisplayMesagewithNumber: themeLabel!
    @IBOutlet var txtOtp: [OTPTextField]!
    @IBOutlet weak var lblCountDown: themeLabel!
    @IBOutlet weak var btnAeero: themeButton!
    @IBOutlet weak var btnResendCode: UIButton!
    
    //MARK:- Variables
    var StringOTP : String = ""
    var clickBtnVerify : (() -> ())?
    var textFieldsIndexes:[OTPTextField:Int] = [:]
    var counter = 30
    var timer = Timer()
    var otpUserModel = RegisterUserModel()
    var registerRequestModel = RegisterFinalRequestModel()
    
    //MARK:- Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Verify", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        self.PrepareView()
        self.callOtpApi()
    }
    
    //MARK:- custom methods
    override func btnBackAction() {
        super.btnBackAction()
        self.timer.invalidate()
    }
    
    func PrepareView(){
        self.lblDisplayMesagewithNumber.text = "Check your SMS messages. We've sent you the PIN at" + " \(self.registerRequestModel.mobileNo?.masked(4, reversed: true) ?? "")"
        
        for i in txtOtp {
            i.backgroundColor = .clear
            i.layer.cornerRadius = 4
            i.layer.borderColor = colors.loginViewColor.value.cgColor
            i.layer.borderWidth = 1
            i.tintColor = themeColor
        }
        
        for index in 0 ..< txtOtp.count {
            textFieldsIndexes[txtOtp[index]] = index
        }
        self.txtOtp[0].myDelegate = self
        self.txtOtp[1].myDelegate = self
        self.txtOtp[2].myDelegate = self
        self.txtOtp[3].myDelegate = self
    }
    
    func reversetimer(){
        self.timer.invalidate()
        self.lblCountDown.isHidden = false
        self.btnResendCode.isUserInteractionEnabled = false
        self.btnResendCode.setTitleColor(#colorLiteral(red: 0, green: 0.6666666667, blue: 0.4941176471, alpha: 1).withAlphaComponent(0.3), for: .normal)
        self.btnResendCode.setTitle("Resend code in", for: .normal)
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func otpToastDisplay(){
        Utilities.showAlert(UrlConstant.OtpSent, message: self.StringOTP, vc: self)
    }
    
    func popBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func timerAction() {
        if self.counter > 0{
            self.counter -= 1
            self.lblCountDown.text =  self.counter > 9 ? "00:\(self.counter)" : "00:0\(self.counter)"
        } else {
            self.lblCountDown.isHidden = true
            self.btnResendCode.isUserInteractionEnabled = true
            self.btnResendCode.setTitleColor(#colorLiteral(red: 0, green: 0.6666666667, blue: 0.4941176471, alpha: 1), for: .normal)
            self.btnResendCode.setTitle("Resend code", for: .normal)
        }
    }
    
    func validation() -> Bool {
        var strTitle : String?
        var strEnteredOTP = ""
        for index in 0 ..< self.txtOtp.count {
            strEnteredOTP.append(self.txtOtp[index].text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        }
        
        if strEnteredOTP == "" {
            strTitle = UrlConstant.RequiredVerificationCode
        }else if self.StringOTP != strEnteredOTP {
            self.clearAllFields()
            strTitle = UrlConstant.InvalidVerificationCode
        }
        
        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
            return false
        }
        return true
    }
    
    func clearAllFields() {
        for index in 0 ..< self.txtOtp.count {
            self.txtOtp[index].text = ""
        }
    }
    
    func setNextResponder(_ index:Int?, direction: Direction) {
        guard let index = index else { return }
        
        if direction == .left {
            index == 0 ?
                (_ = self.txtOtp.first?.resignFirstResponder()) :
                (_ = self.txtOtp[(index - 1)].becomeFirstResponder())
            if index > 0 {
                let neIndex = index + 1
                for i in neIndex..<self.txtOtp.count {
                    self.txtOtp[i].text = ""
                }
            }
        } else {
            index == self.txtOtp.count - 1 ?
                (_ = self.txtOtp.last?.resignFirstResponder()) :
                (_ = self.txtOtp[(index + 1)].becomeFirstResponder())
        }
    }
    
    func setNextResponderBlank(_ index:Int?) {
        if index! >= 0 {
            let neIndex = index! + 1
            for i in neIndex..<self.txtOtp.count {
                self.txtOtp[i].text = ""
                
            }
        }
    }
    
    //MARK:- IBActions
    @IBAction func btnAeeroTap(_ sender: Any) {
        let strTokenCode = "\(self.txtOtp[0].text ?? "" )\(self.txtOtp[1].text ?? "" )\(self.txtOtp[2].text ?? "" )\(self.txtOtp[3].text ?? "")"
        if(self.StringOTP != strTokenCode){
            Utilities.showAlert(AppName, message: UrlConstant.OtpInvalid, vc: self)
        }else{
            self.timer.invalidate()
            
            let vc : BankDetailsVC = BankDetailsVC.instantiate(fromAppStoryboard: .Login)
            vc.registerRequestModel = self.registerRequestModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func btnResendCodeTap(_ sender: Any) {
        self.counter = 31
        self.callOtpApi()
    }
}


//MARK:- class OTPTextField
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

//MARK:- UITextFieldDelegate
extension OtpVC : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 0 {
            self.setNextResponder(textFieldsIndexes[textField as! OTPTextField], direction: .right)
            textField.text = string
            return true
        } else if range.length == 1 {
            self.setNextResponder(textFieldsIndexes[textField as! OTPTextField], direction: .left)
            textField.text = ""
            return false
        }
        return false
    }
    
    func textFieldDidDelete(currentTextField: OTPTextField) {
        self.setNextResponder(textFieldsIndexes[currentTextField], direction: .left)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        self.setNextResponderBlank(textFieldsIndexes[textField as! OTPTextField])
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}

//MARK:- Api Call
extension OtpVC{
    
    func callOtpApi(){
        self.otpUserModel.registerVC = self
        self.otpUserModel.registerRequestModel = self.registerRequestModel
        let otpReqModel = OTPRequestModel()
        otpReqModel.email = self.registerRequestModel.email ?? ""
        otpReqModel.countryCode = self.registerRequestModel.countryCode ?? ""
        otpReqModel.phone = self.registerRequestModel.mobileNo ?? ""
        self.otpUserModel.webserviceRegisterOTP(reqModel: otpReqModel)
    }
    
}


