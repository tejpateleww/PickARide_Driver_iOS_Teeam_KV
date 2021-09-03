//
//  BankDetailsVC.swift
//  PickaRideDriver
//
//  Created by Harsh Sharma on 07/05/21.
//

import UIKit

class BankDetailsVC: BaseVC {
    
    //MARK:- IBOutlwts
    @IBOutlet weak var btnNext: themeButton!
    @IBOutlet weak var txtIfscCode: themeTextField!
    @IBOutlet weak var txtAccountNumber: themeTextField!
    @IBOutlet weak var lblBankName: themeLabel!
    @IBOutlet weak var txtAccountHolderName: themeTextField!
    @IBOutlet weak var lblAccountNumber: themeLabel!
    @IBOutlet weak var lblAccountHolderName: themeLabel!
    @IBOutlet weak var lblIfscCode: themeLabel!
    @IBOutlet weak var txtBankName: themeTextField!
    
    //MARK:- Variables
    var isFromEditProfile : Bool = false
    var registerRequestModel = RegisterFinalRequestModel()
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if isFromEditProfile{
            btnNext.setTitle("SAVE", for: .normal)
            setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Edit Bank Details", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
            txtBankName.text = "Standard Chartered"
            txtAccountHolderName.text = "Joh smitn"
            txtAccountNumber.text = "ACNO123456789"
            txtIfscCode.text = "YT1234"
            
        }else{
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.BankDetails.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        }

    }
  
    //MARK:- Custom Methods
    func validation()->Bool{
        var strTitle : String?
        let BankName = self.txtBankName.validatedText(validationType: .requiredField(field: self.txtBankName.placeholder?.lowercased() ?? ""))
        let AccountHolderName = self.txtAccountHolderName.validatedText(validationType: .requiredField(field: self.txtAccountHolderName.placeholder?.lowercased() ?? ""))
        let AccountNumber = self.txtAccountNumber.validatedText(validationType: .requiredField(field: self.txtAccountNumber.placeholder?.lowercased() ?? ""))
        let IFSCCode = self.txtIfscCode.validatedText(validationType: .requiredField(field: self.txtIfscCode.placeholder?.lowercased() ?? ""))

        if !BankName.0{
            strTitle = BankName.1
        }else if !AccountHolderName.0{
            strTitle = AccountHolderName.1
        }else if !AccountNumber.0{
            strTitle = AccountNumber.1
        }else if !IFSCCode.0{
            strTitle = IFSCCode.1
        }
        
        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
            return false
        }
        
        return true
    }
    
    func storeDataInRegisterModel(){
        self.registerRequestModel.bankName = self.txtBankName.text ?? ""
        self.registerRequestModel.accountHolderName = self.txtAccountHolderName.text ?? ""
        self.registerRequestModel.accountNumber = self.txtAccountNumber.text ?? ""
        self.registerRequestModel.ifscCode = self.txtIfscCode.text ?? ""
        
        let vc : PersonalDocumentVC = PersonalDocumentVC.instantiate(fromAppStoryboard: .Login)
        vc.registerRequestModel = self.registerRequestModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- IBACrions
    @IBAction func btnNextTap(_ sender: UIButton) {
        if validation(){
            self.storeDataInRegisterModel()
        }
    }
    
}
