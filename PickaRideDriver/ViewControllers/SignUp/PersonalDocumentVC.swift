//
//  PersonalDocumentVC.swift
//  PickaRideDriver
//
//  Created by Bhumi on 03/06/21.
//

import UIKit
import DropDown
import EasyTipView

struct PersonalDetails{
    var header : String?
    var message : String?
    var dateofExp : String?
}

class PersonalDocumentVC: BaseVC {
    
    //MARK:- IBOutlets
    @IBOutlet weak var tblPersonalDetails: UITableView!
    @IBOutlet weak var btnNext: themeButton!
    @IBOutlet weak var tblPersonalDetailsHeight: NSLayoutConstraint!
    
    //MARK:- Properties
    var isFromEditProfile : Bool = false
    var isVehicleDocument : Bool = false
    var ArrPersonaldetails = [PersonalDetails]()
    var registerRequestModel = RegisterFinalRequestModel()
    var imagePicker = UIImagePickerController()
    var imagePicked = 0
    var datePicked = ""
    var strImageURL = ""
    var selectedCellPath: IndexPath?
    var singleDocUploadModel = SingleDocUploadModel()
    
    var preferences = EasyTipView.Preferences()
    var tipView: EasyTipView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.PrepareView()
        
        if isFromEditProfile{
            self.btnNext.setTitle("SAVE", for: .normal)
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Edit Personal Document", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
            self.editPersonalDetails()
            
        }else{
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Personal Document", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
            self.personalDetails()
        }
    }
    
    func PrepareView(){
        self.imagePicker.delegate = self
        self.tblPersonalDetails.delegate = self
        self.tblPersonalDetails.dataSource = self
        self.tblPersonalDetails.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.registerNib()
        self.setUpPopTip()
    }
    
    func registerNib(){
        let nib = UINib(nibName: PersonalDocumentCell.className, bundle: nil)
        self.tblPersonalDetails.register(nib, forCellReuseIdentifier: PersonalDocumentCell.className)
    }
    
    func personalDetails(){
        self.ArrPersonaldetails.append(PersonalDetails(header: "Profile Photo", message: "Clear photo of yours", dateofExp: ""))
        self.ArrPersonaldetails.append(PersonalDetails(header: "Goverment ID", message: "ID is an offical Document", dateofExp: "Date of expiry : \(self.registerRequestModel.govermentIdExpDate ?? "")"))
        self.ArrPersonaldetails.append(PersonalDetails(header: "Driving License", message: "A driving license is an offical Document", dateofExp: "Date of expiry : \(self.registerRequestModel.driverLicenceExpDate ?? "")"))
        self.ArrPersonaldetails.append(PersonalDetails(header: "Vehicle Registration", message: "Vehicle Registration", dateofExp: "Date of expiry : \(self.registerRequestModel.vehicleRegistrationExpDate ?? "")"))
        self.ArrPersonaldetails.append(PersonalDetails(header: "Insurance policy", message: "Insurance policy", dateofExp: "Date of expiry : \(self.registerRequestModel.driverInsuranceExpDate ?? "")"))
    }
    
    func editPersonalDetails(){
        self.ArrPersonaldetails.append(PersonalDetails(header: "Profile Photo", message: "Clear photo of yours", dateofExp: ""))
        self.ArrPersonaldetails.append(PersonalDetails(header: "Goverment ID", message: "ID is an offical Document", dateofExp: "Date of expiry : \(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.governmentIdExpiryDate ?? "")"))
        self.ArrPersonaldetails.append(PersonalDetails(header: "Driving License", message: "A driving license is an offical Document", dateofExp: "Date of expiry : \(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.drivingLicenceExpiryDate ?? "")"))
        self.ArrPersonaldetails.append(PersonalDetails(header: "Vehicle Registration", message: "Vehicle Registration", dateofExp: "Date of expiry : \(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleRegistrationExpiryDate ?? "")"))
        self.ArrPersonaldetails.append(PersonalDetails(header: "Insurance policy", message: "Insurance policy", dateofExp: "Date of expiry : \(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.driverInsurancePolicyExpiryDate ?? "")"))
    }
    
    
    //MARK:- Custom Methods
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if(keyPath == "contentSize"){
            if let info = object, let collObj = info as? UITableView{
                
                if collObj == self.tblPersonalDetails{
                    self.tblPersonalDetailsHeight.constant = self.tblPersonalDetails.contentSize.height
                }
            }
        }
    }
    
    func UploadImage(index : IndexPath){
        let alert = UIAlertController(title: "Choose Photo", message: nil, preferredStyle: .alert)
        let Gallery = UIAlertAction(title: "Select photo from gallery"
                                    , style: .default, handler: { ACTION in
                                        self.imagePicker.allowsEditing = false
                                        self.imagePicker.sourceType = .photoLibrary
                                        self.imagePicked = index.row
                                        self.present(self.imagePicker, animated: true)
                                        
                                    })
        let Camera  = UIAlertAction(title: "Select photo from camera", style: .default, handler: { ACTION in
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.imagePicker.cameraCaptureMode = .photo
            self.imagePicked = index.row
            self.present(self.imagePicker, animated: true)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { ACTION in
            if(self.selectedCellPath != nil){
                self.hideLoader()
            }
        })
        alert.addAction(Gallery)
        alert.addAction(Camera)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func UpdateData(){
        
        if(isFromEditProfile){
            if self.imagePicked == 0 {
                SingletonClass.sharedInstance.UserProfilData?.profileImage = self.strImageURL
            }else if self.imagePicked == 1 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.governmentId = self.strImageURL
                self.openDatePicker()
            }else if self.imagePicked == 2 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.drivingLicence = self.strImageURL
                self.openDatePicker()
            }else if self.imagePicked == 3 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleRegistration = self.strImageURL
                self.openDatePicker()
            }else if self.imagePicked == 4 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.driverInsurancePolicy = self.strImageURL
                self.openDatePicker()
            }
        }else{
            if self.imagePicked == 0 {
                self.registerRequestModel.profileImage = self.strImageURL
            }else if self.imagePicked == 1 {
                self.registerRequestModel.govermentIdImage = self.strImageURL
                self.openDatePicker()
            }else if self.imagePicked == 2 {
                self.registerRequestModel.driverLicenceImage = self.strImageURL
                self.openDatePicker()
            }else if self.imagePicked == 3 {
                self.registerRequestModel.vehicleRegistrationImage = self.strImageURL
                self.openDatePicker()
            }else if self.imagePicked == 4 {
                self.registerRequestModel.driverInsuranceImage = self.strImageURL
                self.openDatePicker()
            }
        }
        self.tblPersonalDetails.reloadData()
    }
    
    func UpdateExpDate(){
        if(isFromEditProfile){
            if self.imagePicked == 0 {
            }else if self.imagePicked == 1 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.governmentIdExpiryDate = self.datePicked
                self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : \(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.governmentIdExpiryDate ?? "Date of expiry : ")"
            }else if self.imagePicked == 2 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.drivingLicenceExpiryDate = self.datePicked
                self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : \(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.drivingLicenceExpiryDate ?? "Date of expiry : ")"
            }else if self.imagePicked == 3 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleRegistrationExpiryDate = self.datePicked
                self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : \(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleRegistrationExpiryDate ?? "Date of expiry : ")"
            }else if self.imagePicked == 4 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.driverInsurancePolicyExpiryDate = self.datePicked
                self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : \(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.driverInsurancePolicyExpiryDate ?? "Date of expiry : ")"
            }
        }else{
            if self.imagePicked == 0 {
            }else if self.imagePicked == 1 {
                self.registerRequestModel.govermentIdExpDate = self.datePicked
                self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : \(self.registerRequestModel.govermentIdExpDate ?? "Date of expiry : ")"
            }else if self.imagePicked == 2 {
                self.registerRequestModel.driverLicenceExpDate = self.datePicked
                self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : \(self.registerRequestModel.driverLicenceExpDate ?? "Date of expiry : ")"
            }else if self.imagePicked == 3 {
                self.registerRequestModel.vehicleRegistrationExpDate = self.datePicked
                self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : \(self.registerRequestModel.vehicleRegistrationExpDate ?? "Date of expiry : ")"
            }else if self.imagePicked == 4 {
                self.registerRequestModel.driverInsuranceExpDate = self.datePicked
                self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : \(self.registerRequestModel.driverInsuranceExpDate ?? "Date of expiry : ")"
            }
        }
        self.tblPersonalDetails.reloadData()
    }
    
    func getExpDate() -> String{
        if(isFromEditProfile){
            if self.imagePicked == 1 {
                return SingletonClass.sharedInstance.UserProfilData?.driverDocs?.governmentIdExpiryDate ?? ""
            }else if self.imagePicked == 2 {
                return SingletonClass.sharedInstance.UserProfilData?.driverDocs?.drivingLicenceExpiryDate ?? ""
            }else if self.imagePicked == 3 {
                return SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleRegistrationExpiryDate ?? ""
            }else if self.imagePicked == 4 {
                return SingletonClass.sharedInstance.UserProfilData?.driverDocs?.driverInsurancePolicyExpiryDate ?? ""
            }
        }else{
            if self.imagePicked == 1 {
                return self.registerRequestModel.govermentIdExpDate ?? ""
            }else if self.imagePicked == 2 {
                return self.registerRequestModel.driverLicenceExpDate ?? ""
            }else if self.imagePicked == 3 {
                return self.registerRequestModel.vehicleRegistrationExpDate ?? ""
            }else if self.imagePicked == 4 {
                return self.registerRequestModel.driverInsuranceExpDate ?? ""
            }
        }
        return ""
    }
    
    func RemoveData(){
        
        if(isFromEditProfile){
            if self.imagePicked == 0 {
                SingletonClass.sharedInstance.UserProfilData?.profileImage = ""
            }else if self.imagePicked == 1 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.governmentId = ""
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.governmentIdExpiryDate = ""
                self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : "
            }else if self.imagePicked == 2 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.drivingLicence = ""
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.drivingLicenceExpiryDate = ""
                self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : "
            }else if self.imagePicked == 3 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleRegistration = ""
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleRegistrationExpiryDate = ""
                self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : "
            }else if self.imagePicked == 4 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.driverInsurancePolicy = ""
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.driverInsurancePolicyExpiryDate = ""
                self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : "
            }
        }else{
            if self.imagePicked == 0 {
                self.registerRequestModel.profileImage = ""
            }else if self.imagePicked == 1 {
                self.registerRequestModel.govermentIdImage = ""
                self.registerRequestModel.govermentIdExpDate = ""
                self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : "
            }else if self.imagePicked == 2 {
                self.registerRequestModel.driverLicenceImage = ""
                self.registerRequestModel.driverLicenceExpDate = ""
                self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : "
            }else if self.imagePicked == 3 {
                self.registerRequestModel.vehicleRegistrationImage = ""
                self.registerRequestModel.vehicleRegistrationExpDate = ""
                self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : "
            }else if self.imagePicked == 4 {
                self.registerRequestModel.driverInsuranceImage = ""
                self.registerRequestModel.driverInsuranceExpDate = ""
                self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : "
            }
        }
        self.tblPersonalDetails.reloadData()
    }
    
    func storeDataInRegisterModel(){
        let vc : AddVehicleVC = AddVehicleVC.instantiate(fromAppStoryboard: .Login)
        vc.registerRequestModel = self.registerRequestModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openDatePicker(){
        let vc : PopUpVC = PopUpVC.instantiate(fromAppStoryboard: .Main)
        vc.modalPresentationStyle = .overFullScreen
        vc.delegateDatePick = self
        vc.strDate = getExpDate()
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    func validate() -> Bool{
        
        if(isFromEditProfile){
            if(SingletonClass.sharedInstance.UserProfilData?.profileImage == "" || SingletonClass.sharedInstance.UserProfilData?.profileImage == nil){
                return false
            }else if(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.governmentId == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.governmentId == nil || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.governmentIdExpiryDate == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.governmentIdExpiryDate == nil){
                return false
            }else if(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.drivingLicence == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.drivingLicence == nil || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.drivingLicenceExpiryDate == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.drivingLicenceExpiryDate == nil){
                return false
            }
            else if(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleRegistration == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleRegistration == nil || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleRegistrationExpiryDate == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleRegistrationExpiryDate == nil){
                return false
            }else if(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.driverInsurancePolicy == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.driverInsurancePolicy == nil || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.driverInsurancePolicyExpiryDate == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.driverInsurancePolicyExpiryDate == nil){
                return false
            }
        }else{
            if(self.registerRequestModel.profileImage == "" || self.registerRequestModel.profileImage == nil){
                return false
            }else if(self.registerRequestModel.govermentIdImage == "" || self.registerRequestModel.govermentIdImage == nil || self.registerRequestModel.govermentIdExpDate == "" || self.registerRequestModel.govermentIdExpDate == nil){
                return false
            }else if(self.registerRequestModel.driverLicenceImage == "" || self.registerRequestModel.driverLicenceImage == nil || self.registerRequestModel.driverLicenceExpDate == "" || self.registerRequestModel.driverLicenceExpDate == nil){
                return false
            }
            else if(self.registerRequestModel.vehicleRegistrationImage == "" || self.registerRequestModel.vehicleRegistrationImage == nil || self.registerRequestModel.vehicleRegistrationExpDate == "" || self.registerRequestModel.vehicleRegistrationExpDate == nil){
                return false
            }else if(self.registerRequestModel.driverInsuranceImage == "" || self.registerRequestModel.driverInsuranceImage == nil || self.registerRequestModel.driverInsuranceExpDate == "" || self.registerRequestModel.driverInsuranceExpDate == nil){
                return false
            }
        }
        return true
    }
    
    func showPopTip(index : IndexPath, sender: UIButton){
        if let tipView = self.tipView {
            tipView.dismiss(withCompletion: {
                print("Completion called!")
                self.tipView = nil
            })
        } else {
            let view = EasyTipView(text: self.ArrPersonaldetails[index.row].message ?? "", preferences: self.preferences)
            view.show(forView: sender, withinSuperview: self.navigationController?.view)
            self.tipView = view
        }
    }
    
    func setUpPopTip() {
        self.preferences.drawing.font = CustomFont.regular.returnFont(14)
        self.preferences.drawing.foregroundColor = UIColor.white
        self.preferences.drawing.backgroundColor = themeColor
        self.preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.top
    }
    
    func showLoader(){
        let cell = self.tblPersonalDetails.cellForRow(at: self.selectedCellPath!) as! PersonalDocumentCell
        cell.btnUpload.isHidden = true
        cell.activity.startAnimating()
    }
    
    func hideLoader(){
        let cell = self.tblPersonalDetails.cellForRow(at: self.selectedCellPath!) as! PersonalDocumentCell
        cell.activity.stopAnimating()
        cell.btnUpload.isHidden = false
        self.selectedCellPath = nil
    }
    
    
    //MARK:- IBActions
    @IBAction func btnNextTap(_ sender: Any) {
        
        if(self.validate()){
            if self.isFromEditProfile{
                self.callUpdatePersonalDocs()
            }else{
                self.storeDataInRegisterModel()
            }
        }else{
            Toast.show(title: UrlConstant.Failed, message: "Please provide all document details.", state: .failure)
        }
    }
}
//MARK:- UITableview delegate and DataSource Method
extension PersonalDocumentVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ArrPersonaldetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblPersonalDetails.dequeueReusableCell(withIdentifier: PersonalDocumentCell.className) as! PersonalDocumentCell
        
        if(self.ArrPersonaldetails[indexPath.row].header == "Profile Photo"){
            if(isFromEditProfile){
                cell.btnUpload.isHidden = (SingletonClass.sharedInstance.UserProfilData?.profileImage == "" || SingletonClass.sharedInstance.UserProfilData?.profileImage == nil) ? false : true
                cell.vwMoreButtons.isHidden = (SingletonClass.sharedInstance.UserProfilData?.profileImage == "" || SingletonClass.sharedInstance.UserProfilData?.profileImage == nil) ? true : false
            }else{
                cell.btnUpload.isHidden = (self.registerRequestModel.profileImage == "" || self.registerRequestModel.profileImage == nil) ? false : true
                cell.vwMoreButtons.isHidden = (self.registerRequestModel.profileImage == "" || self.registerRequestModel.profileImage == nil) ? true : false
            }
        }else if(self.ArrPersonaldetails[indexPath.row].header == "Goverment ID"){
            if(isFromEditProfile){
                cell.btnUpload.isHidden = (SingletonClass.sharedInstance.UserProfilData?.driverDocs?.governmentId == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.governmentId == nil) ? false : true
                cell.vwMoreButtons.isHidden = (SingletonClass.sharedInstance.UserProfilData?.driverDocs?.governmentId == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.governmentId == nil) ? true : false
            }else{
                cell.btnUpload.isHidden = (self.registerRequestModel.govermentIdImage == "" || self.registerRequestModel.govermentIdImage == nil) ? false : true
                cell.vwMoreButtons.isHidden = (self.registerRequestModel.govermentIdImage == "" || self.registerRequestModel.govermentIdImage == nil) ? true : false
            }
        }else if(self.ArrPersonaldetails[indexPath.row].header == "Driving License"){
            if(isFromEditProfile){
                cell.btnUpload.isHidden = (SingletonClass.sharedInstance.UserProfilData?.driverDocs?.drivingLicence == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.drivingLicence == nil) ? false : true
                cell.vwMoreButtons.isHidden = (SingletonClass.sharedInstance.UserProfilData?.driverDocs?.drivingLicence == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.drivingLicence == nil) ? true : false
            }else{
                cell.btnUpload.isHidden = (self.registerRequestModel.driverLicenceImage == "" || self.registerRequestModel.driverLicenceImage == nil) ? false : true
                cell.vwMoreButtons.isHidden = (self.registerRequestModel.driverLicenceImage == "" || self.registerRequestModel.driverLicenceImage == nil) ? true : false
            }
        }else if(self.ArrPersonaldetails[indexPath.row].header == "Vehicle Registration"){
            if(isFromEditProfile){
                cell.btnUpload.isHidden = (SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleRegistration == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleRegistration == nil) ? false : true
                cell.vwMoreButtons.isHidden = (SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleRegistration == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleRegistration == nil) ? true : false
            }else{
                cell.btnUpload.isHidden = (self.registerRequestModel.vehicleRegistrationImage == "" || self.registerRequestModel.vehicleRegistrationImage == nil) ? false : true
                cell.vwMoreButtons.isHidden = (self.registerRequestModel.vehicleRegistrationImage == "" || self.registerRequestModel.vehicleRegistrationImage == nil) ? true : false
            }
        }else if(self.ArrPersonaldetails[indexPath.row].header == "Insurance policy"){
            if(isFromEditProfile){
                cell.btnUpload.isHidden = (SingletonClass.sharedInstance.UserProfilData?.driverDocs?.driverInsurancePolicy == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.driverInsurancePolicy == nil) ? false : true
                cell.vwMoreButtons.isHidden = (SingletonClass.sharedInstance.UserProfilData?.driverDocs?.driverInsurancePolicy == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.driverInsurancePolicy == nil) ? true : false
            }else{
                cell.btnUpload.isHidden = (self.registerRequestModel.driverInsuranceImage == "" || self.registerRequestModel.driverInsuranceImage == nil) ? false : true
                cell.vwMoreButtons.isHidden = (self.registerRequestModel.driverInsuranceImage == "" || self.registerRequestModel.driverInsuranceImage == nil) ? true : false
            }
        }else{
            
        }
        
        cell.uploadBtnClouser = {
            self.selectedCellPath = indexPath
            self.UploadImage(index: indexPath)
        }
        cell.MoreBtnClouser = {
            self.selectedCellPath = indexPath
            let options = (indexPath.row == 0) ? cell.optionsDropDown : cell.optionsDropDownwithExp
            self.Dropdown(Dropdown: cell.ImageDropDown, StringArray: options, control: cell.btnMore, displayView: cell.btnRight, cellIndex : indexPath)
            cell.ImageDropDown.show()
        }
        cell.btnInfoClouser = {
            self.showPopTip(index: indexPath, sender: cell.btnInfo)
        }
        
        cell.lblHeading.text = self.ArrPersonaldetails[indexPath.row].header
        cell.lblMessage.text = self.ArrPersonaldetails[indexPath.row].message
        cell.lblDateOfExpiry.text = self.ArrPersonaldetails[indexPath.row].dateofExp
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func Dropdown(Dropdown : DropDown?, StringArray : [String], control : UIView, displayView : UIView, cellIndex : IndexPath){
        Dropdown?.anchorView = displayView
        Dropdown?.dataSource = StringArray
        Dropdown?.selectionAction = { (index, item) in
            if(index == 0){
                self.imagePicked = cellIndex.row
                self.UploadImage(index: cellIndex)
            }else if(index == 1){
                self.imagePicked = cellIndex.row
                self.RemoveData()
            }else{
                self.imagePicked = cellIndex.row
                self.openDatePicker()
            }
        }
    }
}

//MARK:- UIImagePickerControllerDelegate Method
extension PersonalDocumentVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.showLoader()
        
        let pickedImage  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if pickedImage == nil{
            Utilities.showAlert(AppName, message: "Please select image to upload", vc: self)
        }else{
            
            if self.imagePicked == 0 {
                dismiss(animated: true)
                self.callUploadSingleDocApi(uploadImage: pickedImage!)
            } else if self.imagePicked == 1 {
                dismiss(animated: true)
                self.callUploadSingleDocApi(uploadImage: pickedImage!)
            } else if self.imagePicked == 2 {
                dismiss(animated: true)
                self.callUploadSingleDocApi(uploadImage: pickedImage!)
            } else if self.imagePicked == 3 {
                dismiss(animated: true)
                self.callUploadSingleDocApi(uploadImage: pickedImage!)
            } else if self.imagePicked == 4 {
                dismiss(animated: true)
                self.callUploadSingleDocApi(uploadImage: pickedImage!)
            }
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if(self.selectedCellPath != nil){
            self.hideLoader()
        }
        dismiss(animated: true, completion: nil)
    }
}

//MARK:- Api Call
extension PersonalDocumentVC{
    
    func callUploadSingleDocApi(uploadImage : UIImage){
        self.singleDocUploadModel.PersonalDocumentVC = self
        self.singleDocUploadModel.registerRequestModel = self.registerRequestModel
        
        let UploadDocReq = UploadDocReqModel()
        UploadDocReq.email = self.registerRequestModel.email ?? ""
        UploadDocReq.mobileNo = self.registerRequestModel.mobileNo ?? ""
        self.singleDocUploadModel.webserviceSingleDocUpload(reqModel: UploadDocReq, reqImage: uploadImage)
    }
    
    
    func callUpdatePersonalDocs(){
        self.singleDocUploadModel.PersonalDocumentVC = self
        
        let UploadDocReq = UpdatePersonalDocsReqModel()
        UploadDocReq.governmentIdCerti = SingletonClass.sharedInstance.UserProfilData?.driverDocs?.governmentId ?? ""
        UploadDocReq.governmentIdCertiExpDate = SingletonClass.sharedInstance.UserProfilData?.driverDocs?.governmentIdExpiryDate ?? ""
        UploadDocReq.driverLicenceImage = SingletonClass.sharedInstance.UserProfilData?.driverDocs?.drivingLicence ?? ""
        UploadDocReq.driverLicenceExpDate = SingletonClass.sharedInstance.UserProfilData?.driverDocs?.drivingLicenceExpiryDate ?? ""
        UploadDocReq.vehicleRegistrationCerti = SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleRegistration ?? ""
        UploadDocReq.vehicleRegistrationExpDate = SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleRegistrationExpiryDate ?? ""
        UploadDocReq.driverInsuranceCerti = SingletonClass.sharedInstance.UserProfilData?.driverDocs?.driverInsurancePolicy ?? ""
        UploadDocReq.driverInsurancePolicyExpDate = SingletonClass.sharedInstance.UserProfilData?.driverDocs?.driverInsurancePolicyExpiryDate ?? ""
        self.singleDocUploadModel.webserviceUpdatePersonalDocsAPI(reqModel: UploadDocReq)
    }
}

// MARK: - DatePickDelegate Delegate
extension PersonalDocumentVC: DatePickDelegate {
    func refreshDocScrren(strExpDate: String) {
        self.datePicked = strExpDate
        self.UpdateExpDate()
    }
}
