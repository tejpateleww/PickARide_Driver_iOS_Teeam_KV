
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
    var clickBtnVerify : (() -> ())?
    var textFieldsIndexes:[OTPTextField:Int] = [:]
    var counter = 30
    var timer = Timer()
    
    var otpUserModel = OTPUserModel()
    var registerReqModel = RegisterFinalRequestModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDisplayMesagewithNumber.text = "Check your SMS messages. We've sent you the PIN at" + "    ******9999"
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Verify", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        txtOtp[0].becomeFirstResponder()
        reversetimer()
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
        txtOtp[0].myDelegate = self
        txtOtp[1].myDelegate = self
        txtOtp[2].myDelegate = self
        txtOtp[3].myDelegate = self
        
        
    }
    
    override func btnBackAction() {
        super.btnBackAction()
        timer.invalidate()
    }
    
    func reversetimer(){
        timer.invalidate() // just in case this button is tapped multiple times
        //timer? = nil
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
//        self.btnArrowBottom.constant = 20
    }
    
    func validation() -> Bool {
        var strTitle : String?
        var strEnteredOTP = ""
        for index in 0 ..< txtOtp.count {
            strEnteredOTP.append(txtOtp[index].text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
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
        let vc : BankDetailsVC = BankDetailsVC.instantiate(fromAppStoryboard: .Login)
        self.navigationController?.pushViewController(vc, animated: true)
        
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
