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
    
    //MARK:- View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        SetNavigationBar(controller: self, Left: true , Right: false, Title: "Bank Details")
//        addMenuButton()
       
//        addNavBarImage(isLeft: false, isRight: false)
        // Do any additional setup after loading the view.
    }
  
    //MARK:- Custom Methods
    
    //MARK:- IBACrions
    @IBAction func btnNextTap(_ sender: UIButton) {
    }
    
}
