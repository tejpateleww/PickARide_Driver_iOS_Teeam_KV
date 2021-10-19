//
//  EditProfileVC.swift
//  PickaRideDriver
//
//  Created by Admin on 08/05/21.
//

import UIKit
import SDWebImage

class EditProfileVC: BaseVC {
    
    //MARK:- IBOutlet
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
    @IBOutlet weak var btnSaveHeight: NSLayoutConstraint!
    @IBOutlet weak var txtCountryCode: UITextField!
    @IBOutlet weak var imgDownArrow: UIImageView!
    @IBOutlet weak var txtviewHomeAddress: themeTextview!
    @IBOutlet weak var btnPassword: UIButton!
    
    //MARK:- Variables
    let arrEditProfile = ["Edit Bank Details","Edit Personal Details","Edit Vehicle Details","Edit Vehicle Documents"]
    var selectedImage : UIImage?
    var imagePicker = UIImagePickerController()
    var isRemovePhoto = false
    var pickerView = UIPickerView()
    var selectedIndexOfPicker = Int()
    var userInfoViewModel = UserInfoViewModel()
    var strImageURL = ""
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    //MARK:- Custom methods
    func prepareView(){
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "View Profile", leftImage: NavItemsLeft.cancel.value, rightImages: [NavItemsRight.EditProfile.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        
        self.setupData()
        self.setupPicker()
        self.setupTableView()
        self.setupUI()
    }
    
    func setupUI(){
        self.btnSave.isHidden = true
        self.btnSaveHeight.constant = 0
        
        self.vwEditProfileCamera.isHidden = true
        self.btnUpdatePicture.isUserInteractionEnabled = false
        self.imagePicker.delegate = self
        
        self.setupTextfields(textfield: txtPassword, isEdit: false)
        self.varifiedTextFields(textfield: txtEmail)
        self.varifiedTextFields(textfield: txtPhoneNumber)
        
        self.txtEmail.isUserInteractionEnabled = false
        self.txtPhoneNumber.isUserInteractionEnabled = false
        self.txtName.isUserInteractionEnabled = false
        self.txtPassword.isUserInteractionEnabled = false
        self.txtEmail.textColor = .lightGray
        self.txtPhoneNumber.textColor = .lightGray
        self.txtName.textColor = .lightGray
        self.txtPassword.textColor = .lightGray
        self.txtCountryCode.isUserInteractionEnabled = false
        self.txtCountryCode.textColor = .lightGray
        self.txtviewHomeAddress.isUserInteractionEnabled = false
        self.txtviewHomeAddress.textColor = .lightGray
        
        self.imgDownArrow.image = UIImage(named: "ic_DownReg")?.withRenderingMode(.alwaysTemplate)
        self.imgDownArrow.tintColor = .lightGray
        
        self.txtPassword.delegate = self
        
        self.txtviewHomeAddress.delegate = self
        self.txtviewHomeAddress.leftSpace()
    }
    
    func setupData(){
        
        let obj = SingletonClass.sharedInstance.UserProfilData
        let strUrl = "\(APIEnvironment.Profilebu.rawValue)" + "\(obj?.profileImage ?? "")"
        let strURl = URL(string: strUrl)
        self.imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.imgProfile.sd_setImage(with: strURl, placeholderImage: UIImage(named: "nav_dummy_userImage"), options: .refreshCached, completed: nil)
        self.lblName.text = "Hey \(SingletonClass.sharedInstance.UserProfilData?.firstName ?? "")!"
        
        self.txtName.text = "\(SingletonClass.sharedInstance.UserProfilData?.firstName ?? "") \(SingletonClass.sharedInstance.UserProfilData?.lastName ?? "")"
        self.txtEmail.text = SingletonClass.sharedInstance.UserProfilData?.email ?? ""
        self.txtviewHomeAddress.text = SingletonClass.sharedInstance.UserProfilData?.address ?? ""
        self.txtPhoneNumber.text = SingletonClass.sharedInstance.UserProfilData?.mobileNo ?? ""
        self.txtPassword.text = "......"
        
        let countryCode = SingletonClass.sharedInstance.UserProfilData?.countryCode ?? ""
        let Code = countryCode.replacingOccurrences(of: " ", with: "+")
        self.txtCountryCode.text = Code
    }
    
    func setupPicker(){
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.showsSelectionIndicator = true
        
        self.txtCountryCode.delegate = self
        self.txtCountryCode.tintColor = .white
        self.txtCountryCode.inputView = self.pickerView
        
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
            //self.txtCountryCode.text = SingletonClass.sharedInstance.CountryList[selectedIndexOfPicker].countryCode
        }
    }
    
    func setupTableView(){
        self.tblEditProfile.delegate = self
        self.tblEditProfile.dataSource = self
        self.tblEditProfile.reloadData()
        self.tblEditProfile.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    func setupUserImage(){
        let strUrl = "\(APIEnvironment.Profilebu.rawValue)" + "\(self.strImageURL)"
        let strURl = URL(string: strUrl)
        self.imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.imgProfile.sd_setImage(with: strURl, placeholderImage: UIImage(named: "nav_dummy_userImage"), options: .refreshCached, completed: nil)
    }
    
    func UploadImage(){
        let alert = UIAlertController(title: "Choose Photo", message: nil, preferredStyle: .alert)
        let Gallery = UIAlertAction(title: "Select photo from gallery"
                                    , style: .default, handler: { ACTION in
                                        self.imagePicker.allowsEditing = false
                                        self.imagePicker.sourceType = .photoLibrary
                                        self.present(self.imagePicker, animated: true)
                                        
                                    })
        let Camera  = UIAlertAction(title: "Select photo from camera", style: .default, handler: { ACTION in
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.imagePicker.cameraCaptureMode = .photo
            self.present(self.imagePicker, animated: true)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { ACTION in
            
        })
        alert.addAction(Gallery)
        alert.addAction(Camera)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func cancelAction(_ sender: UIBarButtonItem) {
        self.txtCountryCode.endEditing(true)
    }
    
    @objc func doneAction(_ sender: UIBarButtonItem) {
        //self.txtCountryCode.text = SingletonClass.sharedInstance.CountryList[self.selectedIndexOfPicker].countryCode
        self.txtCountryCode.endEditing(true)
    }
    
    func setupTextfields(textfield : UITextField, isEdit : Bool = false) {
        let button = UIButton(type: .custom)
        button.isSelected = true
        button.setImage(isEdit ? #imageLiteral(resourceName: "ImgGraterThen") : UIImage(named: ""), for: .normal)
        button.tintColor = .gray
        button.isUserInteractionEnabled = false
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(textfield.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.tag = textfield.tag
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
        textfield.rightView = button
        textfield.rightViewMode = .always
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if(keyPath == "contentSize"){
            self.tblEditProfileHeight.constant = tblEditProfile.contentSize.height < 34 ? 34: tblEditProfile.contentSize.height
        }
    }
    
    override func EditProfileBtn(_ sender: UIButton?) {
        
        self.btnSave.isHidden = false
        self.btnSaveHeight.constant = 50
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.cancel.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        self.vwEditProfileCamera.isHidden = false
        self.btnUpdatePicture.isUserInteractionEnabled = true
        self.txtName.isUserInteractionEnabled = true
        self.txtviewHomeAddress.isUserInteractionEnabled = true
        self.txtPassword.isUserInteractionEnabled = true
        self.txtName.textColor = .black
        self.txtviewHomeAddress.textColor = .black
        self.txtPassword.textColor = .black
        let bottomOffset = CGPoint(x: 0, y: scrollViewEditProfile.contentSize.height - scrollViewEditProfile.bounds.height + scrollViewEditProfile.contentInset.bottom)
        scrollViewEditProfile.setContentOffset(bottomOffset, animated: true)
        self.setupTextfields(textfield: txtPassword, isEdit: true)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Edit Profile", leftImage: NavItemsLeft.cancel.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        
    }
    
    func validation()->Bool{
        var strTitle : String?
        let FullName = self.txtName.validatedText(validationType: .requiredField(field: self.txtName.placeholder?.lowercased() ?? ""))
        
        if !FullName.0{
            strTitle = FullName.1
        }
        else if txtviewHomeAddress.text == "Home Address" || txtviewHomeAddress.text == ""{
            strTitle = "Please enter home address"
        }
        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
            return false
        }
        return true
    }
    
    //MARK:- Button action methods
    @IBAction func btnSaveTap(_ sender: UIButton) {
        if(self.validation()){
            self.callUpdateUserBasicInfo()
        }
    }
    
    @IBAction func btnEditProfile(_ sender: Any) {
        resignFirstResponder()
        self.UploadImage()
    }
    
    @IBAction func btnPasswordAction(_ sender: Any) {
        let vc : ChangePasswordVC = ChangePasswordVC.instantiate(fromAppStoryboard: .Main)
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(vc, animated: true, completion: nil)
    
    }
    
}

//MARK:- extension tableview
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

//MARK:- UIImagePickerControllerDelegate Method
extension EditProfileVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let pickedImage  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if pickedImage == nil{
            Utilities.showAlert(AppName, message: "Please select image to upload", vc: self)
        }else{
            self.callUploadSingleDocApi(uploadImage: pickedImage!)
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
        }else if textField == self.txtPassword{
            let vc : ChangePasswordVC = ChangePasswordVC.instantiate(fromAppStoryboard: .Main)
            vc.modalPresentationStyle = .overFullScreen
            self.navigationController?.present(vc, animated: true, completion: nil)
            return false
        }
        return true
    }
}

//MARK:- UITextview Delegate methods
extension EditProfileVC : UITextViewDelegate{
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.txtviewHomeAddress.text = ""
        self.txtviewHomeAddress.textColor = .black
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.txtviewHomeAddress.text = self.txtviewHomeAddress.text == "" ? "Home Address" : self.txtviewHomeAddress.text
        self.txtviewHomeAddress.textColor = self.txtviewHomeAddress.text == "Home Address" ? colors.lightGrey.value : .black
    }
}

//MARK:- Api Call
extension EditProfileVC{
    
    func callUpdateUserBasicInfo(){
        self.userInfoViewModel.editProfileVC = self
        
        let fullNameArr = self.txtName.text?.components(separatedBy: " ")
        let firstName: String = fullNameArr?[0] ?? ""
        let lastName: String = fullNameArr?[1] ?? ""
        let StrImgUrl = (self.strImageURL == "") ? SingletonClass.sharedInstance.UserProfilData?.profileImage ?? "" : self.strImageURL
        
        let UploadReq = UpdateBasicInfoReqModel()
        UploadReq.firstName = firstName
        UploadReq.lastName = lastName
        UploadReq.address = self.txtviewHomeAddress.text ?? ""
        UploadReq.profileImage = StrImgUrl
        self.userInfoViewModel.webserviceUserBasicInfoUpdateAPI(reqModel: UploadReq, reqImage: self.imgProfile.image!)
        
    }
    
    func callUploadSingleDocApi(uploadImage : UIImage){
        self.userInfoViewModel.editProfileVC = self
        
        let UploadDocReq = UploadDocReqModel()
        UploadDocReq.email = self.txtEmail.text ?? ""
        UploadDocReq.mobileNo = self.txtPhoneNumber.text ?? ""
        self.userInfoViewModel.webserviceSingleDocUpload(reqModel: UploadDocReq, reqImage: uploadImage)
    }
}
