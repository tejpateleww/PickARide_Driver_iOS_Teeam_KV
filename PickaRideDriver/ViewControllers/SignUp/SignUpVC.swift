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
    @IBOutlet weak var txtHomeAddress: themeTextField!
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
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        self.setUpUI()
//        stackViewCountryCode.layer.borderWidth = 1
//        stackViewCountryCode.layer.borderColor = UIColor.white.cgColor
//        vwMobile.layer.borderWidth = 1
//        vwMobile.layer.borderColor = colors.textfieldbordercolor.value.cgColor
        setupTextfields(textfield: txtPassword)
//        txtHomeAddress.isUserInteractionEnabled = false
        txtMobile.tintColor = themeColor
    }
    
    //MARK:- Custom Methods
    
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
        
        let vc : OtpVC = OtpVC.instantiate(fromAppStoryboard: .Login)
        self.navigationController?.pushViewController(vc, animated: true)
        
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

extension SignUpVC
{
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
        toolBar.sizeToFit()
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        toolBar.setItems([cancel,space,done], animated: false)
        
        self.txtCountryCode.inputAccessoryView = toolBar
        self.txtCountryCode.text = SingletonClass.sharedInstance.CountryList[selectedIndexOfPicker].countryCode
//        self.textFieldPassword.setPasswordVisibility(vc: self, action: #selector(self.showHidePassword(_:)))
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
//MARK:- TextField Delegate
extension SignUpVC: UITextFieldDelegate{
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

//MARK:- TextView Delegate
//extension SignUpVC: UITextViewDelegate{
//    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//
//        let controller = CommonWebViewVC.instantiate(fromAppStoryboard: .Main)
//        if (URL.absoluteString ==  "SignUpPage_textViewText2".Localized().replacingOccurrences(of: " ", with: "")) {
//            print("Print termsAndConditions")
//            controller.strNavTitle = "SignUpPage_textViewText2".Localized().capitalized
//        } else if (URL.absoluteString ==  "SignUpPage_textViewText4".Localized().replacingOccurrences(of: " ", with: "")) {
//            print("Print privacypolicy")
//            controller.strNavTitle = "SignUpPage_textViewText4".Localized().capitalized
//        }
//
//        self.navigationController?.pushViewController(controller, animated: true)
//        return false
//    }
//}
