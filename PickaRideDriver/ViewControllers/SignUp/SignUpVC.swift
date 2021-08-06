//
//  SignUpVC.swift
//  PickaRideDriver
//
//  Created by Harsh Sharma on 07/05/21.
//

import UIKit
import SafariServices

class SignUpVC: BaseVC {
    
    //MARK:- IBOutlets
    @IBOutlet weak var txtPassword: themeTextField!
    @IBOutlet weak var btnTermsandConditions: themeButton!
    @IBOutlet weak var lblPassword: themeLabel!
    @IBOutlet weak var lblFirstName: themeLabel!
    @IBOutlet weak var txtviewHomeAddress: themeTextview!
    @IBOutlet weak var btnPrivacyPolicy: themeButton!
    @IBOutlet weak var lblHomeAddress: themeLabel!
    @IBOutlet weak var vwMobile: UIView!
    @IBOutlet weak var txtEmail: themeTextField!
    @IBOutlet weak var lblEmail: themeLabel!
    @IBOutlet weak var txtFirstName: themeTextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var lblLastName: themeLabel!
    @IBOutlet weak var lblCountrycode: themeLabel!
    @IBOutlet weak var btnNext: themeButton!
    @IBOutlet weak var txtCountryCode: UITextField!
    @IBOutlet weak var txtLastName: themeTextField!
    @IBOutlet weak var stackViewCountryCode: UIStackView!
    @IBOutlet weak var btnCountryCode: UIButton!
    
    //MARK:- Variables and properties
    var pickerView = UIPickerView()
    var selectedIndexOfPicker = Int()
    
    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Create profile", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        txtviewHomeAddress.delegate = self
        self.setUpUI()
        setupTextfields(textfield: txtPassword)
        txtMobile.tintColor = themeColor
        self.setTextFieldDelegate()
        txtviewHomeAddress.textColor = txtviewHomeAddress.text == "Home Address" ? colors.gray.value : .black
        txtMobile.layer.borderColor = UIColor.white.cgColor
        txtviewHomeAddress.leftSpace()
//        txtviewHomeAddress.font = CustomFont.
    }
    
    //MARK:- Custom Methods
    
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
    
    @IBAction func btnCountryCodeTap(_ sender: Any) {
    }
    @IBAction func showHidePassword(_ sender : UIButton) {
        sender.isSelected = !sender.isSelected
        self.txtPassword.isSecureTextEntry = sender.isSelected
    }
    
    //MARK:- IBAction
    @IBAction func btnPrivicyPolicyTap(_ sender: UIButton) {
        previewDocument(strURL: AppPrivacyPolicy)
    }
    
    @IBAction func btnTermsAndConditionTap(_ sender: UIButton) {
        previewDocument(strURL: AppTermAndConditions)
    }
    
    @IBAction func btnNextTap(_ sender: UIButton) {
//        if self.validation(){
            let vc : OtpVC = OtpVC.instantiate(fromAppStoryboard: .Login)
            self.navigationController?.pushViewController(vc, animated: true)
//        }
        
//        let vc : BankDetailsVC = BankDetailsVC.instantiate(fromAppStoryboard: .Login)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func cancelAction(_ sender: UIBarButtonItem) {
        self.txtCountryCode.endEditing(true)
    }
    
    @objc func doneAction(_ sender: UIBarButtonItem) {
        self.txtCountryCode.text = SingletonClass.sharedInstance.CountryList[self.selectedIndexOfPicker].countryCode
        self.txtCountryCode.endEditing(true)
    }
    
}

//MARK:- UITextview Delegate methods
extension SignUpVC : UITextViewDelegate{
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
         txtviewHomeAddress.text = ""
        txtviewHomeAddress.textColor = .black
        return true
    }
    func textViewDidChangeSelection(_ textView: UITextView) {
//        self.txtviewComment.text = txtviewComment.text
        
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        txtviewHomeAddress.text = txtviewHomeAddress.text == "" ? "Home Address" : txtviewHomeAddress.text
        txtviewHomeAddress.textColor = txtviewHomeAddress.text == "Home Address" ? colors.lightGrey.value : .black
    }
}


extension SignUpVC{
    func setUpUI(){
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.showsSelectionIndicator = true
        
        self.txtCountryCode.tintColor = .white
        self.txtCountryCode.delegate = self
        self.txtCountryCode.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.barTintColor = .black
        toolBar.barTintColor = .white
        toolBar.tintColor = themeColor
        if SingletonClass.sharedInstance.CountryList.count == 0{
            WebServiceSubClass.GetCountryList { _, _, _, _ in}
        }else{
            
            self.txtCountryCode.inputAccessoryView = toolBar
            self.txtCountryCode.text = SingletonClass.sharedInstance.CountryList[selectedIndexOfPicker].countryCode
        }
        toolBar.sizeToFit()
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        toolBar.setItems([cancel,space,done], animated: false)
        
//        self.textFieldPassword.setPasswordVisibility(vc: self, action: #selector(self.showHidePassword(_:)))
    }

    func setTextFieldDelegate(){
        self.txtFirstName.delegate = self
        self.txtLastName.delegate = self
        self.txtCountryCode.delegate = self
        self.txtMobile.delegate = self
        self.txtPassword.delegate = self
    }
    
    func previewDocument(strURL : String)
    {
        guard let url = URL(string: strURL) else {
            return
        }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
}

//MARK:- Validation & Api
extension SignUpVC{
    func validation()->Bool{
        var strTitle : String?
        let firstName = self.txtFirstName.validatedText(validationType: .username(field: self.txtFirstName.placeholder?.lowercased() ?? ""))
        let lastName = self.txtLastName.validatedText(validationType: .username(field: self.txtLastName.placeholder?.lowercased() ?? ""))
        let checkEmail = self.txtEmail.validatedText(validationType: .email)
        let mobileNo = self.txtMobile.validatedText(validationType: .requiredField(field: self.txtMobile.placeholder?.lowercased() ?? ""))
//        let address = self.txtviewHomeAddress.validatedText(validationType: .requiredField(field: self.txtHomeAddress.placeholder?.lowercased() ?? ""))
        let password = self.txtPassword.validatedText(validationType: .password(field: self.txtPassword.placeholder?.lowercased() ?? ""))
        
        if !firstName.0{
            strTitle = firstName.1
        }else if !lastName.0{
            strTitle = lastName.1
        }else if !checkEmail.0{
            strTitle = checkEmail.1
        }else if !mobileNo.0{
            strTitle = mobileNo.1
        }else if self.txtMobile.text?.count != 10 {
            strTitle = UrlConstant.ValidPhoneNo
        }else if txtviewHomeAddress.text == "Home Address" || txtviewHomeAddress.text == ""{
            strTitle = "Please enter home address"
            return false
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
extension SignUpVC: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtCountryCode{
            if SingletonClass.sharedInstance.CountryList.count == 0{
                WebServiceSubClass.GetCountryList {_, _, _, _ in}
                return false
            }
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtMobile || textField == txtFirstName || textField == txtLastName || textField == txtPassword{
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return string == "" || (newString.length <= ((textField == txtMobile) ? MAX_PHONE_DIGITS : TEXTFIELD_MaximumLimit))
        }
        
        return true
    }
}

//MARK:- Country Code Picker Set Up
extension SignUpVC : UIPickerViewDelegate,UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SingletonClass.sharedInstance.CountryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (SingletonClass.sharedInstance.CountryList[row].countryCode ?? "") + " - " + (SingletonClass.sharedInstance.CountryList[row].name ?? "")
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndexOfPicker = row
    }
}

////MARK:- TextView Delegate
//extension SignUpVC: UITextViewDelegate{
////    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
////
////        let controller = CommonWebViewVC.instantiate(fromAppStoryboard: .Main)
////        if (URL.absoluteString ==  "SignUpPage_textViewText2".Localized().replacingOccurrences(of: " ", with: "")) {
////            print("Print termsAndConditions")
////            controller.strNavTitle = "SignUpPage_textViewText2".Localized().capitalized
////        } else if (URL.absoluteString ==  "SignUpPage_textViewText4".Localized().replacingOccurrences(of: " ", with: "")) {
////            print("Print privacypolicy")
////            controller.strNavTitle = "SignUpPage_textViewText4".Localized().capitalized
////        }
////
////        self.navigationController?.pushViewController(controller, animated: true)
////        return false
////    }
//}
extension UITextView {
func leftSpace() {
    self.textContainerInset = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 4)
}
}
