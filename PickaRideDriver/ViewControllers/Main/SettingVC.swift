//
//  SettingVC.swift
//  PickaRideDriver
//
//  Created by Admin on 10/05/21.
//

import UIKit

class SettingVC: BaseVC {
    var arrSetting = ["Privacy Policy","Language","English","German"]
    @IBOutlet weak var tblSetting: UITableView!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var tblSettingHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        tblSetting.delegate = self
        tblSetting.dataSource = self
        tblSetting.reloadData()
        tblSetting.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        // Do any additional setup after loading the view.
    }
    @IBAction func btnEditProfileTap(_ sender: Any) {
        let vc : EditProfileVC = EditProfileVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if(keyPath == "contentSize"){
            self.tblSettingHeight.constant = tblSetting.contentSize.height < 122.5 ? 122.5: tblSetting.contentSize.height
            
        }
    }
}
extension SettingVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSetting.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SettingCell = tblSetting.dequeueReusableCell(withIdentifier: SettingCell.className, for: indexPath) as! SettingCell
        cell.vwArrow.isHidden = true
        cell.notifSwitch.isHidden = true
//        cell.vwSwitch.isHidden = true
        cell.backgroundColor = UIColor.init(hexString: "#F4F4F6")
        cell.lblTitle.text = arrSetting[indexPath.row]
        if indexPath.row == 0{
            cell.vwArrow.isHidden = false
        }else if indexPath.row == 1{
            cell.backgroundColor = UIColor.white
        }else if indexPath.row == 2{
//            cell.vwSwitch.isHidden = false
            cell.notifSwitch.isHidden = false
        }else if indexPath.row == 3{
//            cell.vwSwitch.isHidden = false
            cell.notifSwitch.isHidden = false
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
