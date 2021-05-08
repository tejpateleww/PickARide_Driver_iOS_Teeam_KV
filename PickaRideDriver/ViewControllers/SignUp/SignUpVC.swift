//
//  SignUpVC.swift
//  PickaRideDriver
//
//  Created by Harsh Sharma on 07/05/21.
//

import UIKit

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
    @IBOutlet weak var txtLastName: themeTextField!
    
    //MARK:- Variables and properties

    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        SetNavigationBar(controller: self, Left: true , Right: false, Title: "")
        
        vwMobile.layer.borderWidth = 1
        vwMobile.layer.borderColor = colors.textfieldbordercolor.value.cgColor
        
        setupTextfields(textfield: txtPassword)
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
    
    @IBAction func showHidePassword(_ sender : UIButton) {
        
       
            sender.isSelected = !sender.isSelected
            self.txtPassword.isSecureTextEntry = sender.isSelected
        
    }
    
    //MARK:- IBAction
    @IBAction func btnPrivicyPolicyTap(_ sender: UIButton) {
        
    }
    @IBAction func btnNextTap(_ sender: UIButton) {
        let vc : BankDetailsVC = BankDetailsVC.instantiate(fromAppStoryboard: .Login)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnTermsAndConditionTap(_ sender: UIButton) {
    }
    
}