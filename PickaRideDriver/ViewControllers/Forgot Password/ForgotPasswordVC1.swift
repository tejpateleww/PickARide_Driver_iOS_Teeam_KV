import UIKit

class ForgotPasswordVC: BaseVC {
    
    @IBOutlet weak var lblForgotPassword: ForgotPasswordLabel!
    @IBOutlet weak var lblQuestion: ForgotPasswordLabel!
    @IBOutlet weak var lblDescription: ForgotPasswordLabel!
    @IBOutlet weak var lblEmailTitle: ProfileLabel!
    @IBOutlet weak var btnContinue: submitButton!
    @IBOutlet weak var txtEmail: emailPasswordTextField!
    
    var forgotPasswordUserModel = PasswordUserModel()
    let ACCEPTABLE_CHARACTERS_FOR_EMAIL = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Forgot Password", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    @IBAction func btnContinue(_ sender: Any) {
        if self.validation(){
            self.callForgotPasswordApi()
        }
    }
}

//MARK:- Methods
extension ForgotPasswordVC{
    func setupLocalization() {
        lblQuestion.text = "ForgotPasswordScreen_lblQuestion".Localized()
        lblDescription.text = "ForgotPasswordScreen_lblDescription".Localized()
        lblEmailTitle.text = "LoginScreen_lblEmail".Localized()
        btnContinue.setTitle("ForgotPasswordScreen_btnContinue".Localized(), for: .normal)
    }
}

//MARK:- Validation & Api
extension ForgotPasswordVC{
    func validation()->Bool{
        var strTitle : String?
        
        let checkEmail = txtEmail.validatedText(validationType: .email)
        if !checkEmail.0{
            strTitle = checkEmail.1
        }

        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
            return false
        }
        return true
    }
    
    func callForgotPasswordApi(){
        self.forgotPasswordUserModel.forgotPasswordVC = self
        
        let reqModel = ForgotPasswordReqModel()
        reqModel.email = txtEmail.text ?? ""
        self.forgotPasswordUserModel.webserviceForgotPassword(reqModel: reqModel)
    }
}

//MARK:- TextField Delegate
extension ForgotPasswordVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        
        case self.txtEmail :
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_FOR_EMAIL).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            return (string == filtered)

       
        default:
            print("")
        }
        return true
    }
}
