//
//  VehicleDocumentVC.swift
//  PickaRideDriver
//
//  Created by Tej on 07/09/21.
//

import UIKit
import DropDown
import EasyTipView

struct VehicleDetails{
    var header : String?
    var message : String?
    var dateofExp : String?
}

class VehicleDocumentVC: BaseVC {
    
    //MARK:- IBOutlets
    @IBOutlet weak var tblPersonalDetails: UITableView!
    @IBOutlet weak var btnNext: themeButton!
    @IBOutlet weak var tblPersonalDetailsHeight: NSLayoutConstraint!
    
    //MARK:- Properties
    var isFromEditProfile : Bool = false
    var ArrVehicleDetails = [VehicleDetails]()
    var registerRequestModel = RegisterFinalRequestModel()
    var imagePicker = UIImagePickerController()
    var imagePicked = 0
    var datePicked = ""
    var strImageURL = ""
    var singleDocUploadModel = SingleDocUploadModel()
    var registerUserFinalModel = RegisterUserFinalModel()
    var selectedCellPath: IndexPath?
    
    var preferences = EasyTipView.Preferences()
    var tipView: EasyTipView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.PrepareView()
        self.btnNext.setTitle(isFromEditProfile ? "SAVE" : "SIGN UP", for: .normal)
        
        if isFromEditProfile{
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Edit Vehicle Document", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
            self.editVehicleDocuments()
        }else{
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Vehicle Document", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
            self.vehicleDocuments()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if(keyPath == "contentSize"){
            if let info = object, let collObj = info as? UITableView{
                
                if collObj == self.tblPersonalDetails{
                    self.tblPersonalDetailsHeight.constant = self.tblPersonalDetails.contentSize.height
                }
            }
        }
    }
    
    //MARK:- Custom Methods
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
    
    func vehicleDocuments(){
        self.ArrVehicleDetails.append(VehicleDetails(header: "RC Book", message: "Vehicle Registration", dateofExp: "Date of expiry : \(self.registerRequestModel.rcBookExpDate ?? "")"))
        self.ArrVehicleDetails.append(VehicleDetails(header: "Insurance policy", message: "Insurance policy", dateofExp: "Date of expiry : \(self.registerRequestModel.vehicleInsuranceExpDate ?? "")"))
        self.ArrVehicleDetails.append(VehicleDetails(header: "Owner certificate", message: "A passport is a travel document", dateofExp: ""))
    }
    
    func editVehicleDocuments(){
        self.ArrVehicleDetails.append(VehicleDetails(header: "RC Book", message: "Vehicle Registration", dateofExp: "Date of expiry : \(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.rcBookExpiryDate ?? "")"))
        self.ArrVehicleDetails.append(VehicleDetails(header: "Insurance policy", message: "Insurance policy", dateofExp: "Date of expiry : \(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleInsurancePolicyExpiryDate ?? "")"))
        self.ArrVehicleDetails.append(VehicleDetails(header: "Owner certificate", message: "A passport is a travel document", dateofExp: ""))
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
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.rcBook = self.strImageURL
                self.openDatePicker()
            }else if self.imagePicked == 1 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleInsurancePolicy = self.strImageURL
                self.openDatePicker()
            }else if self.imagePicked == 2 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.ownerCertificate = self.strImageURL
            }
        }else{
            if self.imagePicked == 0 {
                self.registerRequestModel.rcBookImage = self.strImageURL
                self.openDatePicker()
            }else if self.imagePicked == 1 {
                self.registerRequestModel.vehicleInsuranceImage = self.strImageURL
                self.openDatePicker()
            }else if self.imagePicked == 2 {
                self.registerRequestModel.ownerCertificateImage = self.strImageURL
            }
        }
        self.tblPersonalDetails.reloadData()
    }
    
    func UpdateExpDate(){
        if(isFromEditProfile){
            if self.imagePicked == 0 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.rcBookExpiryDate = self.datePicked
                self.ArrVehicleDetails[self.imagePicked].dateofExp = "Date of expiry : \(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.rcBookExpiryDate ?? "Date of expiry : ")"
            }else if self.imagePicked == 1 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleInsurancePolicyExpiryDate = self.datePicked
                self.ArrVehicleDetails[self.imagePicked].dateofExp = "Date of expiry : \(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleInsurancePolicyExpiryDate ?? "Date of expiry : ")"
            }else if self.imagePicked == 2 {
            }
        }else{
            if self.imagePicked == 0 {
                self.registerRequestModel.rcBookExpDate = self.datePicked
                self.ArrVehicleDetails[self.imagePicked].dateofExp = "Date of expiry : \(self.registerRequestModel.rcBookExpDate ?? "Date of expiry : ")"
            }else if self.imagePicked == 1 {
                self.registerRequestModel.vehicleInsuranceExpDate = self.datePicked
                self.ArrVehicleDetails[self.imagePicked].dateofExp = "Date of expiry : \(self.registerRequestModel.vehicleInsuranceExpDate ?? "Date of expiry : ")"
            }else if self.imagePicked == 2 {
            }
        }
        self.tblPersonalDetails.reloadData()
    }
    
    func getExpDate() -> String{
        if(isFromEditProfile){
            if self.imagePicked == 0 {
                return SingletonClass.sharedInstance.UserProfilData?.driverDocs?.rcBookExpiryDate ?? ""
            }else if self.imagePicked == 1 {
                return SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleInsurancePolicyExpiryDate ?? ""
            }
        }else{
            if self.imagePicked == 0 {
                return self.registerRequestModel.rcBookExpDate ?? ""
            }else if self.imagePicked == 1 {
                return self.registerRequestModel.vehicleInsuranceExpDate ?? ""
            }
        }
        return ""
    }
    
    func RemoveData(){
        if(isFromEditProfile){
            if self.imagePicked == 0 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.rcBook = ""
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.rcBookExpiryDate = ""
                self.ArrVehicleDetails[self.imagePicked].dateofExp = "Date of expiry : "
            }else if self.imagePicked == 1 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleInsurancePolicy = ""
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleInsurancePolicyExpiryDate = ""
                self.ArrVehicleDetails[self.imagePicked].dateofExp = "Date of expiry : "
            }else if self.imagePicked == 2 {
                SingletonClass.sharedInstance.UserProfilData?.driverDocs?.ownerCertificate  = ""
            }
        }else{
            if self.imagePicked == 0 {
                self.registerRequestModel.rcBookImage = ""
                self.registerRequestModel.rcBookExpDate = ""
                self.ArrVehicleDetails[self.imagePicked].dateofExp = "Date of expiry : "
            }else if self.imagePicked == 1 {
                self.registerRequestModel.vehicleInsuranceImage = ""
                self.registerRequestModel.vehicleInsuranceExpDate = ""
                self.ArrVehicleDetails[self.imagePicked].dateofExp = "Date of expiry : "
            }else if self.imagePicked == 2 {
                self.registerRequestModel.ownerCertificateImage = ""
            }
        }
        self.tblPersonalDetails.reloadData()
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
            if(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.rcBook == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.rcBook == nil  || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.rcBookExpiryDate == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.rcBookExpiryDate == nil){
                return false
            }else if(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleInsurancePolicy == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleInsurancePolicy == nil || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleInsurancePolicyExpiryDate == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleInsurancePolicyExpiryDate == nil){
                return false
            }else if(SingletonClass.sharedInstance.UserProfilData?.driverDocs?.ownerCertificate == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.ownerCertificate == nil ){
                return false
            }
        }else{
            if(self.registerRequestModel.rcBookImage == "" || self.registerRequestModel.rcBookImage == nil){
                return false
            }else if(self.registerRequestModel.vehicleInsuranceImage == "" || self.registerRequestModel.vehicleInsuranceImage == nil || self.registerRequestModel.vehicleInsuranceExpDate == "" || self.registerRequestModel.vehicleInsuranceExpDate == nil){
                return false
            }else if(self.registerRequestModel.ownerCertificateImage == "" || self.registerRequestModel.ownerCertificateImage == nil ){
                return false
            }
        }
        return true
    }
    
    func goToWaitingForApproval(){
        let vc : WaitingForApprovalVC = WaitingForApprovalVC.instantiate(fromAppStoryboard: .Login)
        self.present(vc, animated: false, completion: nil)
    }
    
    func showPopTip(index : IndexPath, sender: UIButton){
        if let tipView = self.tipView {
            tipView.dismiss(withCompletion: {
                print("Completion called!")
                self.tipView = nil
            })
        } else {
            let view = EasyTipView(text: self.ArrVehicleDetails[index.row].message ?? "", preferences: self.preferences)
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
            if(isFromEditProfile){
                self.callUpdateVehicleDocs()
            }else{
                self.registerDriverApi()
            }
        }else{
            Utilities.showAlert(AppName, message: "Please provide all vehicle document details.", vc: self)
        }
    }
    
}

//MARK:- UITableview delegate and DataSource Method
extension VehicleDocumentVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ArrVehicleDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblPersonalDetails.dequeueReusableCell(withIdentifier: PersonalDocumentCell.className) as! PersonalDocumentCell
        
        if(self.ArrVehicleDetails[indexPath.row].header == "RC Book"){
            if(isFromEditProfile){
                cell.btnUpload.isHidden = (SingletonClass.sharedInstance.UserProfilData?.driverDocs?.rcBook == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.rcBook == nil) ? false : true
                cell.vwMoreButtons.isHidden = (SingletonClass.sharedInstance.UserProfilData?.driverDocs?.rcBook == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.rcBook == nil) ? true : false
            }else{
                cell.btnUpload.isHidden = (self.registerRequestModel.rcBookImage == "" || self.registerRequestModel.rcBookImage == nil) ? false : true
                cell.vwMoreButtons.isHidden = (self.registerRequestModel.rcBookImage == "" || self.registerRequestModel.rcBookImage == nil) ? true : false
            }
        }else if(self.ArrVehicleDetails[indexPath.row].header == "Insurance policy"){
            if(isFromEditProfile){
                cell.btnUpload.isHidden = (SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleInsurancePolicy == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleInsurancePolicy == nil) ? false : true
                cell.vwMoreButtons.isHidden = (SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleInsurancePolicy == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleInsurancePolicy == nil) ? true : false
            }else{
                cell.btnUpload.isHidden = (self.registerRequestModel.vehicleInsuranceImage == "" || self.registerRequestModel.vehicleInsuranceImage == nil) ? false : true
                cell.vwMoreButtons.isHidden = (self.registerRequestModel.vehicleInsuranceImage == "" || self.registerRequestModel.vehicleInsuranceImage == nil) ? true : false
            }
        }else if(self.ArrVehicleDetails[indexPath.row].header == "Owner certificate"){
            if(isFromEditProfile){
                cell.btnUpload.isHidden = (SingletonClass.sharedInstance.UserProfilData?.driverDocs?.ownerCertificate == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.ownerCertificate == nil) ? false : true
                cell.vwMoreButtons.isHidden = (SingletonClass.sharedInstance.UserProfilData?.driverDocs?.ownerCertificate == "" || SingletonClass.sharedInstance.UserProfilData?.driverDocs?.ownerCertificate == nil) ? true : false
            }else{
                cell.btnUpload.isHidden = (self.registerRequestModel.ownerCertificateImage == "" || self.registerRequestModel.ownerCertificateImage == nil) ? false : true
                cell.vwMoreButtons.isHidden = (self.registerRequestModel.ownerCertificateImage == "" || self.registerRequestModel.ownerCertificateImage == nil) ? true : false
            }
        }else{
            
        }
        
        cell.uploadBtnClouser = {
            self.selectedCellPath = indexPath
            self.UploadImage(index: indexPath)
        }
        cell.MoreBtnClouser = {
            let options = (indexPath.row == 2) ? cell.optionsDropDown : cell.optionsDropDownwithExp
            self.Dropdown(Dropdown: cell.ImageDropDown, StringArray: options, control: cell.btnMore, displayView: cell.btnRight, cellIndex : indexPath)
            cell.ImageDropDown.show()
        }
        cell.btnInfoClouser = {
            self.showPopTip(index: indexPath, sender: cell.btnInfo)
        }
        
        cell.lblHeading.text = self.ArrVehicleDetails[indexPath.row].header
        cell.lblMessage.text = self.ArrVehicleDetails[indexPath.row].message
        cell.lblDateOfExpiry.text = self.ArrVehicleDetails[indexPath.row].dateofExp
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
extension VehicleDocumentVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
extension VehicleDocumentVC{
    
    func callUploadSingleDocApi(uploadImage : UIImage){
        self.singleDocUploadModel.vehicleDocumentVC = self
        self.singleDocUploadModel.registerRequestModel = self.registerRequestModel
        
        let UploadDocReq = UploadDocReqModel()
        UploadDocReq.email = self.registerRequestModel.email ?? ""
        UploadDocReq.mobileNo = self.registerRequestModel.mobileNo ?? ""
        self.singleDocUploadModel.webserviceSingleDocUpload(reqModel: UploadDocReq, reqImage: uploadImage)
    }
    
    
    func callUpdateVehicleDocs(){
        self.singleDocUploadModel.vehicleDocumentVC = self
        
        let UploadDocReq = UpdateVehicleDocsReqModel()
        UploadDocReq.rcBookCerti = SingletonClass.sharedInstance.UserProfilData?.driverDocs?.rcBook ?? ""
        UploadDocReq.rcBookExpDate = SingletonClass.sharedInstance.UserProfilData?.driverDocs?.rcBookExpiryDate ?? ""
        UploadDocReq.vehicleInsuranceCerti = SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleInsurancePolicy ?? ""
        UploadDocReq.vehicleInsuranceExpDate = SingletonClass.sharedInstance.UserProfilData?.driverDocs?.vehicleInsurancePolicyExpiryDate ?? ""
        UploadDocReq.ownerCerti = SingletonClass.sharedInstance.UserProfilData?.driverDocs?.ownerCertificate ?? ""
        self.singleDocUploadModel.webserviceUpdateVehicleDocsAPI(reqModel: UploadDocReq)
    }
    
    
    func registerDriverApi(){
        self.registerUserFinalModel.vehicleDocumentVC = self
        self.registerUserFinalModel.webserviceRegister(reqModel: self.registerRequestModel)
    }
}

// MARK: - DatePickDelegate Delegate
extension VehicleDocumentVC: DatePickDelegate {
    func refreshDocScrren(strExpDate: String) {
        self.datePicked = strExpDate
        self.UpdateExpDate()
    }
}
