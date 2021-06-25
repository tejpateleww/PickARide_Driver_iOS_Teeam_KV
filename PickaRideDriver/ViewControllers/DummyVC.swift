//
//  DummyVC.swift
//  Cluttrfly-HAULER Driver
//
//  Created by Raju Gupta on 15/03/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit

class DummyVC: BaseVC {

    @IBOutlet weak var lblData: UILabel!
    var strTitle : String = ""
    var dataText : String = ""
    var isfromTerms : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: strTitle, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        lblData.text = dataText
    }
  
}
