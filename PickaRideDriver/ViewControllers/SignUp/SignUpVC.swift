//
//  SignUpVC.swift
//  PickaRideDriver
//
//  Created by Tej on 07/05/21.
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
    @IBOutlet weak var btnNext: themeButton!
    @IBOutlet weak var txtCountryCode: UITextField!
    @IBOutlet weak var txtLastName: themeTextField!
    @IBOutlet weak var stackViewCountryCode: UIStackView!
    
    //MARK:- Variables and properties
    var pickerView = UIPickerView()
    var selectedIndexOfPicker = Int()
    var otpUserModel = RegisterUserModel()
    var registerRequestModel = RegisterFinalRequestModel()
    let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz"
    let ACCEPTABLE_CHARACTERS_FOR_EMAIL = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@."
    let ACCEPTABLE_CHARACTERS_FOR_PHONE = "0123456789"
    let RISTRICTED_CHARACTERS_FOR_PASSWORD = " "
    let ACCEPTABLE_CHARACTERS_FOR_ADDRESS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ,/-"
    
    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Create profile", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        self.PrepareView()
    }
    
    //MARK:- Custom Methods
    func PrepareView(){
        self.setUpUI()
        self.setUpPicker()
        self.setupTextfields(textfield: txtPassword)
    }
    
    func setUpPicker(){
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
        toolBar.sizeToFit()
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        toolBar.setItems([cancel,space,done], animated: false)
        
        if SingletonClass.sharedInstance.CountryList.count == 0{
            WebServiceSubClass.GetCountryList { _, _, _, _ in}
        }else{
            self.txtCountryCode.inputAccessoryView = toolBar
            self.txtCountryCode.text = SingletonClass.sharedInstance.CountryList[selectedIndexOfPicker].countryCode
        }
    }
    
    func setUpUI(){
        self.txtMobile.tintColor = themeColor
        
        self.txtFirstName.delegate = self
        self.txtLastName.delegate = self
        self.txtCountryCode.delegate = self
        self.txtMobile.delegate = self
        self.txtPassword.delegate = self
        
        self.txtviewHomeAddress.delegate = self
        self.txtviewHomeAddress.textColor = txtviewHomeAddress.text == "Home Address" ? colors.gray.value : .black
        self.txtMobile.layer.borderColor = UIColor.white.cgColor
        self.txtviewHomeAddress.leftSpace()
        
    }
    
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
    
    func storeDataInRegisterModel(){
        self.registerRequestModel.firstName = self.txtFirstName.text ?? ""
        self.registerRequestModel.lastName = self.txtLastName.text ?? ""
        self.registerRequestModel.countryCode = self.txtCountryCode.text ?? ""
        self.registerRequestModel.countryId = SingletonClass.sharedInstance.CountryList[selectedIndexOfPicker].id
        self.registerRequestModel.mobileNo = self.txtMobile.text ?? ""
        self.registerRequestModel.email = self.txtEmail.text ?? ""
        self.registerRequestModel.address = self.txtviewHomeAddress.text ?? ""
        self.registerRequestModel.password = self.txtPassword.text ?? ""
        
        let controller = OtpVC.instantiate(fromAppStoryboard: .Login)
        controller.registerRequestModel = self.registerRequestModel
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func previewDocument(strURL : String){
        guard let url = URL(string: strURL) else {return}
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    func validation()->Bool{
        var strTitle : String?
        let firstName = self.txtFirstName.validatedText(validationType: .username(field: self.txtFirstName.placeholder?.lowercased() ?? ""))
        let lastName = self.txtLastName.validatedText(validationType: .username(field: self.txtLastName.placeholder?.lowercased() ?? ""))
        let mobileNo = self.txtMobile.validatedText(validationType: .requiredField(field: self.txtMobile.placeholder?.lowercased() ?? ""))
        let checkEmail = self.txtEmail.validatedText(validationType: .email(field: self.txtEmail.placeholder?.lowercased() ?? ""))
        let password = self.txtPassword.validatedText(validationType: .password(field: self.txtPassword.placeholder?.lowercased() ?? ""))
        
        if !firstName.0{
            strTitle = firstName.1
        }else if !lastName.0{
            strTitle = lastName.1
        }else if !mobileNo.0{
            strTitle = mobileNo.1
        }else if !checkEmail.0{
            strTitle = checkEmail.1
        }else if self.txtMobile.text?.count != 10 {
            strTitle = UrlConstant.ValidPhoneNo
        }else if txtviewHomeAddress.text == "Home Address" || txtviewHomeAddress.text == ""{
            strTitle = "Please enter home address"
        }else if !password.0{
            strTitle = password.1
        }
        
        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
            return false
        }
        
        return true
    }
    
    //MARK:- IBAction
    @objc func showHidePassword(_ sender : UIButton) {
        sender.isSelected = !sender.isSelected
        self.txtPassword.isSecureTextEntry = sender.isSelected
    }
    
    @IBAction func btnPrivicyPolicyTap(_ sender: UIButton) {
        var PrivacyPolicy = ""
        if let PrivacyPolicyLink = SingletonClass.sharedInstance.AppInitModel?.appLinks?.filter({ $0.name == "privacy_policy"}) {
            if PrivacyPolicyLink.count > 0 {
                PrivacyPolicy = PrivacyPolicyLink[0].url ?? ""
                self.previewDocument(strURL: PrivacyPolicy)
            }
        }
    }
    
    @IBAction func btnTermsAndConditionTap(_ sender: UIButton) {
        var TC = ""
        if let TCLink = SingletonClass.sharedInstance.AppInitModel?.appLinks?.filter({ $0.name == "terms_and_condition"}) {
            if TCLink.count > 0 {
                TC = TCLink[0].url ?? ""
                self.previewDocument(strURL: TC)
            }
        }
    }
    
    @IBAction func btnNextTap(_ sender: UIButton) {
        if self.validation(){
            self.storeDataInRegisterModel()
        }
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
        self.txtviewHomeAddress.text = ""
        self.txtviewHomeAddress.textColor = .black
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    
        switch textView {
        case self.txtviewHomeAddress :
            let set = CharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_FOR_ADDRESS)
            let inverted = set.inverted
            let filtered = text.components(separatedBy: inverted).joined(separator: "")
            let currentString: NSString = textView.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: text) as NSString
            let char = text.cString(using: String.Encoding.utf8)!
            let isBackSpace = strcmp(char, "\\b")
            return (text == filtered) ? (newString.length <= TEXTFIELD_MaximumLimit) : (isBackSpace == -92) ? true : false
            
        default:
            print("")
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.txtviewHomeAddress.text = self.txtviewHomeAddress.text == "" ? "Home Address" : self.txtviewHomeAddress.text
        self.txtviewHomeAddress.textColor = self.txtviewHomeAddress.text == "Home Address" ? colors.lightGrey.value : .black
    }
}

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
        
        switch textField {
 
        case self.txtFirstName :
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return (string == filtered) ? (newString.length <= TEXTFIELD_MaximumLimit) : false
            
        case self.txtLastName :
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return (string == filtered) ? (newString.length <= TEXTFIELD_MaximumLimit) : false
            
        case self.txtEmail :
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_FOR_EMAIL).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            return (string == filtered)
            
        case self.txtMobile :
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
        self.selectedIndexOfPicker = row
    }
}



