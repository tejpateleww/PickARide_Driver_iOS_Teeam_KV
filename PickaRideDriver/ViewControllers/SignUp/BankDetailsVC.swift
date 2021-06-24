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
    
    //MARK:- Variables and properties
    var isFromEditProfile : Bool = false
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
//        SetNavigationBar(controller: self, Left: true , Right: false, Title: "Bank Details")
//        addMenuButton()
       
//        addNavBarImage(isLeft: false, isRight: false)
        // Do any additional setup after loading the view.
    }
  
    //MARK:- Custom Methods
    
    //MARK:- IBACrions
    @IBAction func btnNextTap(_ sender: UIButton) {
        if isFromEditProfile{
            self.navigationController?.popViewController(animated: true)
        }else{
        let vc : PersonalDocumentVC = PersonalDocumentVC.instantiate(fromAppStoryboard: .Login)
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
