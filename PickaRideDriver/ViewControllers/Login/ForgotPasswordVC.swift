//
//  ForgotPasswordVC.swift
//  PickaRideDriver
//
//  Created by Harsh on 24/06/21.
//

import UIKit

class ForgotPasswordVC: BaseVC {

    @IBOutlet weak var btnSend: themeButton!
    @IBOutlet weak var lblForgotPassword: themeLabel!
    @IBOutlet weak var txtForgotPassword: themeTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        txtForgotPassword.placeholder = ConstantString.PLACE_HOLDER_LOGIN_EMAILID
    }
    @IBAction func btnSendTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
