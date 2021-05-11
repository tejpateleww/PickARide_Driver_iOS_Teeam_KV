//
//  AddVehicleVC.swift
//  PickaRideDriver
//
//  Created by Admin on 08/05/21.
//

import UIKit

class AddVehicleVC: BaseVC {

    @IBOutlet weak var txtServiceType: themeWBorderTextField!
    @IBOutlet weak var txtBrand: themeWBorderTextField!
    @IBOutlet weak var txtModel: themeWBorderTextField!
    @IBOutlet weak var txtManufacturer: themeWBorderTextField!
    @IBOutlet weak var txtNumberPlate: themeWBorderTextField!
    @IBOutlet weak var txtCarYear: themeWBorderTextField!
    @IBOutlet weak var carColor: themeWBorderTextField!
    @IBOutlet weak var btnNext: themeButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.login.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        // Do any additional setup after loading the view.
    }
    @IBAction func btnNextTap(_ sender: Any) {
    }
}
