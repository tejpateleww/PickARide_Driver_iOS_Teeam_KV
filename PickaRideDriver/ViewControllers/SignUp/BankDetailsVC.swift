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
    let ACCEPTABLE_CHARACTERS_FOR_ACCOUNT_NUMBER = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    var isFromEditProfile : Bool = false
    var registerRequestModel = RegisterFinalRequestModel()
    var bankInfoViewModel = BankInfoViewModel()
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.isFromEditProfile{
            self.setupDataForProfile()
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Edit Bank Details", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        }else{
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.BankDetails.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        }
    }
    
    //MARK:- Custom Methods
    func setupDataForProfile(){
        self.btnNext.setTitle("SAVE", for: .normal)
        self.txtBankName.text = SingletonClass.sharedInstance.UserProfilData?.bankName ?? ""
        self.txtAccountHolderName.text = SingletonClass.sharedInstance.UserProfilData?.accountHolderName ?? ""
        self.txtAccountNumber.text = SingletonClass.sharedInstance.UserProfilData?.accountNumber ?? ""
        self.txtIfscCode.text = SingletonClass.sharedInstance.UserProfilData?.ifscCode ?? ""
    }
    
    func popBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func validation()->Bool{
        var strTitle : String?
        let BankName = self.txtBankName.validatedText(validationType: .requiredField(field: self.txtBankName.placeholder?.lowercased() ?? ""))
        let AccountHolderName = self.txtAccountHolderName.validatedText(validationType: .requiredField(field: self.txtAccountHolderName.placeholder?.lowercased() ?? ""))
        let AccountNumber = self.txtAccountNumber.validatedText(validationType: .accountNo(field: self.txtAccountNumber.placeholder?.lowercased() ?? ""))
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
        
        if self.validation(){
            if(self.isFromEditProfile){
                self.callUpdatebankInfoAPI()
            }else{
                self.storeDataInRegisterModel()
            }
        }
    }
    
}

//MARK:- Api Call
extension BankDetailsVC{
    
    func callUpdatebankInfoAPI(){
        self.bankInfoViewModel.bankDetailsVC = self
        
        let UploadDocReq = UpdateBankInfoReqModel()
        UploadDocReq.bankName = self.txtBankName.text ?? ""
        UploadDocReq.accountHolderName = self.txtAccountHolderName.text ?? ""
        UploadDocReq.accountNumber = self.txtAccountNumber.text ?? ""
        UploadDocReq.ifscCode = self.txtIfscCode.text ?? ""
        
        self.bankInfoViewModel.webserviceUpdateBankInfoAPI(reqModel: UploadDocReq)
    }
    
}

extension BankDetailsVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
 
        case self.txtAccountNumber :
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_FOR_ACCOUNT_NUMBER).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return (string == filtered) ? (newString.length <= MAX_ACCOUNT_NUMBERLimit) : false

        default:
            print("")
        }
       
        return true
    }

}
