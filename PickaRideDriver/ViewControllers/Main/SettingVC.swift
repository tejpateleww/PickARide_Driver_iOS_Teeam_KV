//
//  SettingVC.swift
//  PickaRideDriver
//
//  Created by Admin on 10/05/21.
//

import UIKit

class SettingVC: BaseVC, UITextFieldDelegate {
    
    
    var arrLanguage = ["English","German"]
    var arrSetting = ["Privacy Policy"]
    var pickerView = UIPickerView()
    var selectedIndexOfPicker = NSNotFound
    
    @IBOutlet weak var tblSetting: UITableView!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var tblSettingHeight: NSLayoutConstraint!
    @IBOutlet weak var btnPicker: UIButton!
    @IBOutlet weak var txtLanguage: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtLanguage.text = arrLanguage[0]
        txtLanguage.delegate = self
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.barTintColor = .black
//        toolBar.isTranslucent = true
        toolBar.barTintColor = .white
        toolBar.tintColor = themeColor
        toolBar.sizeToFit()
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        toolBar.setItems([cancel,space,done], animated: false)
        txtLanguage.inputView = pickerView
        txtLanguage.inputAccessoryView = toolBar
        
        
//        pickerSetup()
        tblSetting.delegate = self
        tblSetting.dataSource = self
        tblSetting.reloadData()
        tblSetting.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        txtLanguage.text = arrLanguage[0]
        setupTextfields(textfield: txtLanguage)
        txtLanguage.textColor = hexStringToUIColor(hex: "222B45")
   
        // Do any additional setup after loading the view.
    }
    
    func setupTextfields(textfield : UITextField) {
        let button = UIButton(type: .custom)
        button.isSelected = true
        button.setImage(#imageLiteral(resourceName: "ic_DownReg"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -55, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(textfield.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.tag = textfield.tag
        button.isUserInteractionEnabled = false
//        button.addTarget(self, action: #selector(self.showHidePassword), for: .touchUpInside)
        textfield.rightView = button
        textfield.rightViewMode = .always
    }
    
    
    //MARK:- picker view
    @objc func cancelAction(_ sender: UIBarButtonItem) {
        txtLanguage.endEditing(true)
    }
    @objc func doneAction(_ sender: UIBarButtonItem) {
        txtLanguage.text = arrLanguage[self.selectedIndexOfPicker]
        txtLanguage.endEditing(true)
    }
    
    
    @IBAction func btnPickerTap(_ sender: UIButton) {
    }
    @IBAction func btnEditProfileTap(_ sender: Any) {
        let vc : EditProfileVC = EditProfileVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if(keyPath == "contentSize"){
            self.tblSettingHeight.constant = tblSetting.contentSize.height < 40 ? 40: tblSetting.contentSize.height
            
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == txtLanguage)
        {
            return false
        }
        return true
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
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}

extension SettingVC : UIPickerViewDelegate,UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrLanguage.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return arrLanguage[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if btnPicker.title(for: .normal) == "Button" {
////            btnPicker.setTitle(arrLanguage[0], for: .normal)
//            txtLanguage.text = arrLanguage[0]
//        }
//
//        txtLanguage.text = arrLanguage[row]
////        btnPicker.setTitle(arrLanguage[row], for: .normal)
//        pickerView.removeFromSuperview()
        selectedIndexOfPicker = row
    }
}
