//
//  EditProfileVC.swift
//  PickaRideDriver
//
//  Created by Admin on 08/05/21.
//

import UIKit
import SDWebImage

class EditProfileVC: BaseVC {
    
    @IBOutlet weak var vwMobile: UIView!
    @IBOutlet weak var scrollViewEditProfile: UIScrollView!
    @IBOutlet weak var vwEditProfileCamera: settingsView!
    @IBOutlet weak var lblName: themeLabel!
    @IBOutlet weak var tblEditProfile: UITableView!
    @IBOutlet weak var tblEditProfileHeight: NSLayoutConstraint!
    @IBOutlet weak var btnUpdatePicture: UIButton!
    @IBOutlet weak var imgProfile: ProfileView!{ didSet{ imgProfile.layer.cornerRadius = imgProfile.frame.size.height / 2}}
    @IBOutlet weak var txtName: themeTextField!
    @IBOutlet weak var txtEmail: themeTextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtPassword: themeTextField!
    @IBOutlet weak var btnSave: themeButton!
    @IBOutlet weak var txtCountryCode: UITextField!
    
    let arrEditProfile = ["Edit Bank Details","Edit Personal Details","Edit Vehicle Details","Edit Vehicle Documents"]
    var selectedImage : UIImage?
    private var imagePicker : ImagePicker!
    var isRemovePhoto = false
    var pickerView = UIPickerView()
    var selectedIndexOfPicker = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "View Profile", leftImage: NavItemsLeft.cancel.value, rightImages: [NavItemsRight.EditProfile.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        vwEditProfileCamera.isHidden = true
        tblEditProfile.delegate = self
        tblEditProfile.dataSource = self
        tblEditProfile.reloadData()
//        vwMobile.layer.borderWidth = 1
        btnUpdatePicture.isUserInteractionEnabled = false
//        vwMobile.layer.borderColor = colors.textfieldbordercolor.value.cgColor
        self.imagePicker = ImagePicker(presentationController: self, delegate: self, allowsEditing: false)
        self.imagePicker = ImagePicker(presentationController: self, delegate: self, allowsEditing: true)
        tblEditProfile.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        setupTextfields(textfield: txtPassword, isEdit: false)
        varifiedTextFields(textfield: txtEmail)
        varifiedTextFields(textfield: txtPhoneNumber)
        txtName.isUserInteractionEnabled = false
        txtPassword.isUserInteractionEnabled = false
        txtEmail.textColor = .lightGray
        txtPhoneNumber.textColor = .lightGray
        txtName.textColor = .lightGray
        txtPassword.textColor = .lightGray
        txtEmail.isUserInteractionEnabled = false
        txtPhoneNumber.isUserInteractionEnabled = false
        txtPassword.delegate = self
        // Do any additional setup after loading the view.
        
        self.prepareView()
    }
    
    func prepareView(){
        
        let obj = SingletonClass.sharedInstance.UserProfilData
        let strUrl = "\(APIEnvironment.Profilebu.rawValue)" + "\(obj?.profileImage ?? "")"
        let strURl = URL(string: strUrl)
        self.imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.imgProfile.sd_setImage(with: strURl, placeholderImage: UIImage(named: "nav_dummy_userImage"), options: .refreshCached, completed: nil)
        self.lblName.text = "Hey \(SingletonClass.sharedInstance.UserProfilData?.firstName ?? "")!"
       
        self.setupData()
        self.setupPicker()
    }
    
    func setupData(){
        self.txtName.text = "\(SingletonClass.sharedInstance.UserProfilData?.firstName ?? "") \(SingletonClass.sharedInstance.UserProfilData?.lastName ?? "")"
        self.txtEmail.text = SingletonClass.sharedInstance.UserProfilData?.email ?? ""
        self.txtPhoneNumber.text = SingletonClass.sharedInstance.UserProfilData?.mobileNo ?? ""
        self.txtPassword.text = "......"
        self.txtCountryCode.text = SingletonClass.sharedInstance.UserProfilData?.countryCode ?? ""
        
    }
    
    func setupPicker(){
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.showsSelectionIndicator = true
        
        self.txtCountryCode.delegate = self
        self.txtCountryCode.tintColor = .white
        self.txtCountryCode.inputView = pickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.barTintColor = .black
        toolBar.barTintColor = .white
        toolBar.tintColor = themeColor
        toolBar.sizeToFit()
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        toolBar.setItems([cancel,space,done], animated: false)
        
        if SingletonClass.sharedInstance.CountryList.count == 0{
            WebServiceSubClass.GetCountryList { _, _, _, _ in}
        }else{
            self.txtCountryCode.inputAccessoryView = toolBar
            self.txtCountryCode.text = SingletonClass.sharedInstance.CountryList[selectedIndexOfPicker].countryCode
        }
    }
    
    @objc func cancelAction(_ sender: UIBarButtonItem) {
        self.txtCountryCode.endEditing(true)
    }
    
    @objc func doneAction(_ sender: UIBarButtonItem) {
        self.txtCountryCode.text = SingletonClass.sharedInstance.CountryList[self.selectedIndexOfPicker].countryCode
        self.txtCountryCode.endEditing(true)
    }
    
    @IBAction func btnEditProfile(_ sender: Any) {
        resignFirstResponder()
        if (self.imgProfile.image != nil || self.selectedImage != nil) && ((self.imgProfile.image?.isEqualToImage(UIImage.init(named: "Dummy-Profile")!)) != nil){
            self.imagePicker.present(from: self.imgProfile, viewPresented: self.view, isRemove: true)
        } else {
            self.imagePicker.present(from: self.imgProfile, viewPresented: self.view, isRemove: false)
        }
    }
    override func EditProfileBtn(_ sender: UIButton?) {
      
        btnSave.isHidden = false
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.cancel.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        vwEditProfileCamera.isHidden = false
        btnUpdatePicture.isUserInteractionEnabled = true
        txtName.isUserInteractionEnabled = true
        txtPassword.isUserInteractionEnabled = true
        txtName.textColor = .black
        txtPassword.textColor = .black
        let bottomOffset = CGPoint(x: 0, y: scrollViewEditProfile.contentSize.height - scrollViewEditProfile.bounds.height + scrollViewEditProfile.contentInset.bottom)
        scrollViewEditProfile.setContentOffset(bottomOffset, animated: true)
        setupTextfields(textfield: txtPassword, isEdit: true)
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Edit Profile", leftImage: NavItemsLeft.cancel.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        
    }

    
    func setupTextfields(textfield : UITextField, isEdit : Bool = false) {
        let button = UIButton(type: .custom)
        button.isSelected = true
        button.setImage(isEdit ? #imageLiteral(resourceName: "ImgGraterThen") : UIImage(named: ""), for: .normal)
        button.tintColor = .gray
        button.isUserInteractionEnabled = false
//        button.setImage(#imageLiteral(resourceName: <#T##String#>), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(textfield.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.tag = textfield.tag
        button.addTarget(self, action: #selector(self.showHidePassword), for: .touchUpInside)
        textfield.rightView = button
        textfield.rightViewMode = .always
    }
    func varifiedTextFields(textfield : UITextField) {
        let button = UIButton(type: .custom)
        button.isSelected = true
        button.setImage(#imageLiteral(resourceName: "ImgRightArrow"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(textfield.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.tag = textfield.tag
        button.addTarget(self, action: #selector(self.showHidePassword), for: .touchUpInside)
        textfield.rightView = button
        textfield.rightViewMode = .always
    }
    
    
    
    @IBAction func btnSaveTap(_ sender: UIButton) {
     
        btnSave.isHidden = true
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.cancel.value, rightImages: [NavItemsRight.EditProfile.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        txtName.isUserInteractionEnabled = false
        txtPassword.isUserInteractionEnabled = false
        txtName.textColor = .lightGray
        txtPassword.textColor = .lightGray
        vwEditProfileCamera.isHidden = true
        btnUpdatePicture.isUserInteractionEnabled = false
        setupTextfields(textfield: txtPassword, isEdit: false)
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "View Profile", leftImage: NavItemsLeft.cancel.value, rightImages: [NavItemsRight.EditProfile.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    @IBAction func showHidePassword(_ sender : UIButton) {
//
//        sender.isSelected = !sender.isSelected
//        self.txtPassword.isSecureTextEntry = sender.isSelected
//
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if(keyPath == "contentSize"){
            self.tblEditProfileHeight.constant = tblEditProfile.contentSize.height < 34 ? 34: tblEditProfile.contentSize.height
        }
    }
    

}
extension EditProfileVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEditProfile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EditProfileCell = tblEditProfile.dequeueReusableCell(withIdentifier: EditProfileCell.className, for: indexPath)as! EditProfileCell
        cell.lblEditProfile.text = arrEditProfile[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrEditProfile[indexPath.row] == "Edit Bank Details"{
            let vc : BankDetailsVC = BankDetailsVC.instantiate(fromAppStoryboard: .Login)
            vc.isFromEditProfile = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if arrEditProfile[indexPath.row] == "Edit Personal Details"{
            let vc : PersonalDocumentVC = PersonalDocumentVC.instantiate(fromAppStoryboard: .Login)
            vc.isFromEditProfile = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if arrEditProfile[indexPath.row] == "Edit Vehicle Details"{
            let vc : AddVehicleVC = AddVehicleVC.instantiate(fromAppStoryboard: .Login)
            vc.isFromEditProfile = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if arrEditProfile[indexPath.row] == "Edit Vehicle Documents"{
            let vc : VehicleDocumentVC = VehicleDocumentVC.instantiate(fromAppStoryboard: .Login)
            vc.isFromEditProfile = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - ImagePickerDelegate
extension EditProfileVC:ImagePickerDelegate {
    
    func didSelect(image: UIImage?, SelectedTag:Int) {
        //        isRemovePhoto = false
        if(image == nil && SelectedTag == 101){
            self.selectedImage = UIImage()
            self.isRemovePhoto = true
            self.imgProfile.image = UIImage.init(named: "Dummy-Profile")
            //webservice_RemoveProfilePicture()
        }else if image != nil{
            let fixedOrientedImage = image?.fixOrientation()
            self.imgProfile.image = fixedOrientedImage
            self.selectedImage = self.imgProfile.image
        }else{
            return
        }
    }
}

//MARK:- Country Code Picker Set Up
extension EditProfileVC : UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SingletonClass.sharedInstance.CountryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (SingletonClass.sharedInstance.CountryList[row].countryCode ?? "") + " - " + (SingletonClass.sharedInstance.CountryList[row].name ?? "")
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedIndexOfPicker = row
    }
}

//MARK:- TextField Delegate
extension EditProfileVC: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtCountryCode{
            if SingletonClass.sharedInstance.CountryList.count == 0{
                WebServiceSubClass.GetCountryList {_, _, _, _ in}
                return false
            }
        }
        return true
    }
    
}
