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
            if self.isVehicleDocument{
                self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Edit Vehicle Document", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
                self.vehicleDocuments()
            }else{
                self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Edit Personal Document", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
                self.personalDetails()
            }
            
        }else{
            if self.isVehicleDocument{
                self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Vehicle Document", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
                self.vehicleDocuments()
                self.btnNext.setTitle(isFromEditProfile ? "SAVE" : "SIGN UP", for: .normal)
                
            }else{
                self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Personal Document", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
                self.personalDetails()
            }
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
    func vehicleDocuments(){
        self.ArrPersonaldetails.append(PersonalDetails(header: "RC Book", message: "Vehicle Registration", dateofExp: "Date of expiry : 22/08/2022"))
        self.ArrPersonaldetails.append(PersonalDetails(header: "Insurance policy", message: "Insurance policy", dateofExp: "Date of expiry : 22/08/2022"))
        self.ArrPersonaldetails.append(PersonalDetails(header: "Owner certificate", message: "A passport is a travel document", dateofExp: "Date of expiry : 22/08/2022"))
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
        if self.imagePicked == 0 {
            self.registerRequestModel.profileImage = self.strImageURL
            self.tblPersonalDetails.reloadData()
        }else if self.imagePicked == 1 {
            self.registerRequestModel.govermentIdImage = self.strImageURL
            self.tblPersonalDetails.reloadData()
            self.openDatePicker()
        }else if self.imagePicked == 2 {
            self.registerRequestModel.driverLicenceImage = self.strImageURL
            self.tblPersonalDetails.reloadData()
            self.openDatePicker()
        }else if self.imagePicked == 3 {
            self.registerRequestModel.vehicleRegistrationImage = self.strImageURL
            self.tblPersonalDetails.reloadData()
            self.openDatePicker()
        }else if self.imagePicked == 4 {
            self.registerRequestModel.driverInsuranceImage = self.strImageURL
            self.tblPersonalDetails.reloadData()
            self.openDatePicker()
        }
    }
    
    func UpdateExpDate(){
        if self.imagePicked == 0 {
        }else if self.imagePicked == 1 {
            self.registerRequestModel.govermentIdExpDate = self.datePicked
            self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : \(self.registerRequestModel.govermentIdExpDate ?? "Date of expiry : ")"
            self.tblPersonalDetails.reloadData()
        }else if self.imagePicked == 2 {
            self.registerRequestModel.driverLicenceExpDate = self.datePicked
            self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : \(self.registerRequestModel.driverLicenceExpDate ?? "Date of expiry : ")"
            self.tblPersonalDetails.reloadData()
        }else if self.imagePicked == 3 {
            self.registerRequestModel.vehicleRegistrationExpDate = self.datePicked
            self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : \(self.registerRequestModel.vehicleRegistrationExpDate ?? "Date of expiry : ")"
            self.tblPersonalDetails.reloadData()
        }else if self.imagePicked == 4 {
            self.registerRequestModel.driverInsuranceExpDate = self.datePicked
            self.ArrPersonaldetails[self.imagePicked].dateofExp = "Date of expiry : \(self.registerRequestModel.driverInsuranceExpDate ?? "Date of expiry : ")"
            self.tblPersonalDetails.reloadData()
        }
    }
    
    func getExpDate() -> String{
        if self.imagePicked == 1 {
            return self.registerRequestModel.govermentIdExpDate ?? ""
        }else if self.imagePicked == 2 {
            return self.registerRequestModel.driverLicenceExpDate ?? ""
        }else if self.imagePicked == 3 {
            return self.registerRequestModel.vehicleRegistrationExpDate ?? ""
        }else if self.imagePicked == 4 {
            return self.registerRequestModel.driverInsuranceExpDate ?? ""
        }
        return ""
    }
    
    func RemoveData(){
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
        if(!self.validate()){
            Utilities.showAlert(AppName, message: "Please provide all document details.", vc: self)
        }else{
            if self.isFromEditProfile{
                self.navigationController?.popViewController(animated: true)
            }else{
                self.storeDataInRegisterModel()
            }
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
            cell.btnUpload.isHidden = (self.registerRequestModel.profileImage == "" || self.registerRequestModel.profileImage == nil) ? false : true
            cell.vwMoreButtons.isHidden = (self.registerRequestModel.profileImage == "" || self.registerRequestModel.profileImage == nil) ? true : false
        }else if(self.ArrPersonaldetails[indexPath.row].header == "Goverment ID"){
            cell.btnUpload.isHidden = (self.registerRequestModel.govermentIdImage == "" || self.registerRequestModel.govermentIdImage == nil) ? false : true
            cell.vwMoreButtons.isHidden = (self.registerRequestModel.govermentIdImage == "" || self.registerRequestModel.govermentIdImage == nil) ? true : false
        }else if(self.ArrPersonaldetails[indexPath.row].header == "Driving License"){
            cell.btnUpload.isHidden = (self.registerRequestModel.driverLicenceImage == "" || self.registerRequestModel.driverLicenceImage == nil) ? false : true
            cell.vwMoreButtons.isHidden = (self.registerRequestModel.driverLicenceImage == "" || self.registerRequestModel.driverLicenceImage == nil) ? true : false
        }else if(self.ArrPersonaldetails[indexPath.row].header == "Vehicle Registration"){
            cell.btnUpload.isHidden = (self.registerRequestModel.vehicleRegistrationImage == "" || self.registerRequestModel.vehicleRegistrationImage == nil) ? false : true
            cell.vwMoreButtons.isHidden = (self.registerRequestModel.vehicleRegistrationImage == "" || self.registerRequestModel.vehicleRegistrationImage == nil) ? true : false
        }else if(self.ArrPersonaldetails[indexPath.row].header == "Insurance policy"){
            cell.btnUpload.isHidden = (self.registerRequestModel.driverInsuranceImage == "" || self.registerRequestModel.driverInsuranceImage == nil) ? false : true
            cell.vwMoreButtons.isHidden = (self.registerRequestModel.driverInsuranceImage == "" || self.registerRequestModel.driverInsuranceImage == nil) ? true : false
        }else{
            
        }
        
        cell.uploadBtnClouser = {
            self.selectedCellPath = indexPath
            self.UploadImage(index: indexPath)
        }
        cell.MoreBtnClouser = {
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
}

// MARK: - DatePickDelegate Delegate
extension PersonalDocumentVC: DatePickDelegate {
    func refreshDocScrren(strExpDate: String) {
        self.datePicked = strExpDate
        self.UpdateExpDate()
    }
}
