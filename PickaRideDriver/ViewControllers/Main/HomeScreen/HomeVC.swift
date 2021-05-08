//
//  HomeVC.swift
//  PickaRideDriver
//
//  Created by Admin on 08/05/21.
//

import UIKit

class HomeVC: BaseVC {

    @IBOutlet weak var vwMap: UIView!
    @IBOutlet weak var btnOn: UIButton!
    @IBOutlet weak var lblOffline: themeLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        SetNavigationBar(controller : self,Left:false,Right:true,Title:"",IsSettingVC:false,IsGreen:true, IsShadow :false)
//        SetNavigationBar(controller: self, Left: true, Right: true, Title: "", IsSettingVC: false, IsGreen: false, IsShadow: false)
//        SetNavigationBar(controller: self, Left: false , Right: false, Title: "")
//        navigationController.
        // Do any additional setup after loading the view.
    }
    @IBAction func btnOnClick(_ sender: Any) {
    }
}
