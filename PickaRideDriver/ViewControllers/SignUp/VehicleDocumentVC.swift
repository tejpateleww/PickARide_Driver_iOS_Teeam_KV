//
//  VehicleDocumentVC.swift
//  PickaRideDriver
//
//  Created by Tej on 07/09/21.
//

import UIKit
import DropDown

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.PrepareView()
        
        if isFromEditProfile{
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Edit Vehicle Document", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
            self.vehicleDocuments()
        }else{
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Vehicle Document", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
            self.vehicleDocuments()
        }
        self.btnNext.setTitle(isFromEditProfile ? "SAVE" : "SIGN UP", for: .normal)
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
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(Gallery)
        alert.addAction(Camera)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func UpdateData(){
        if self.imagePicked == 0 {
            self.registerRequestModel.rcBookImage = self.strImageURL
            self.tblPersonalDetails.reloadData()
            self.openDatePicker()
        }else if self.imagePicked == 1 {
            self.registerRequestModel.vehicleInsuranceImage = self.strImageURL
            self.tblPersonalDetails.reloadData()
            self.openDatePicker()
        }else if self.imagePicked == 2 {
            self.registerRequestModel.ownerCertificateImage = self.strImageURL
            self.tblPersonalDetails.reloadData()
        }
    }
    
    func UpdateExpDate(){
        if self.imagePicked == 0 {
            self.registerRequestModel.rcBookExpDate = self.datePicked
            self.ArrVehicleDetails[self.imagePicked].dateofExp = "Date of expiry : \(self.registerRequestModel.rcBookExpDate ?? "Date of expiry : ")"
            self.tblPersonalDetails.reloadData()
        }else if self.imagePicked == 1 {
            self.registerRequestModel.vehicleInsuranceExpDate = self.datePicked
            self.ArrVehicleDetails[self.imagePicked].dateofExp = "Date of expiry : \(self.registerRequestModel.vehicleInsuranceExpDate ?? "Date of expiry : ")"
            self.tblPersonalDetails.reloadData()
        }else if self.imagePicked == 2 {
        }
    }
    
    func getExpDate() -> String{
        if self.imagePicked == 0 {
            return self.registerRequestModel.rcBookExpDate ?? ""
        }else if self.imagePicked == 1 {
            return self.registerRequestModel.vehicleInsuranceExpDate ?? ""
        }
        return ""
    }
    
    func RemoveData(){
        if self.imagePicked == 0 {
            self.registerRequestModel.rcBookImage = ""
            self.registerRequestModel.rcBookExpDate = ""
            self.ArrVehicleDetails[self.imagePicked].dateofExp = "Date of expiry : "
            self.tblPersonalDetails.reloadData()
        }else if self.imagePicked == 1 {
            self.registerRequestModel.vehicleInsuranceImage = ""
            self.registerRequestModel.vehicleInsuranceExpDate = ""
            self.ArrVehicleDetails[self.imagePicked].dateofExp = "Date of expiry : "
            self.tblPersonalDetails.reloadData()
        }else if self.imagePicked == 2 {
            self.registerRequestModel.ownerCertificateImage = ""
            self.tblPersonalDetails.reloadData()
        }
    }
    
    func openDatePicker(){
        let vc : PopUpVC = PopUpVC.instantiate(fromAppStoryboard: .Main)
        vc.modalPresentationStyle = .overFullScreen
        vc.delegateDatePick = self
        vc.strDate = getExpDate()
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    func validate() -> Bool{
        if(self.registerRequestModel.rcBookImage == "" || self.registerRequestModel.rcBookImage == nil){
            return false
        }else if(self.registerRequestModel.vehicleInsuranceImage == "" || self.registerRequestModel.vehicleInsuranceImage == nil || self.registerRequestModel.vehicleInsuranceExpDate == "" || self.registerRequestModel.vehicleInsuranceExpDate == nil){
            return false
        }else if(self.registerRequestModel.ownerCertificateImage == "" || self.registerRequestModel.ownerCertificateImage == nil ){
            return false
        }
        return true
    }
    
    func goToWaitingForApproval(){
        let vc : WaitingForApprovalVC = WaitingForApprovalVC.instantiate(fromAppStoryboard: .Login)
        self.present(vc, animated: false, completion: nil)
    }
    
    //MARK:- IBActions
    @IBAction func btnNextTap(_ sender: Any) {
        if(!self.validate()){
            Utilities.showAlert(AppName, message: "Please provide all vehicle document details.", vc: self)
        }else{
            if self.isFromEditProfile{
                self.navigationController?.popViewController(animated: true)
            }else{
                self.registerDriverApi()
            }
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
            cell.btnUpload.isHidden = (self.registerRequestModel.rcBookImage == "" || self.registerRequestModel.rcBookImage == nil) ? false : true
            cell.vwMoreButtons.isHidden = (self.registerRequestModel.rcBookImage == "" || self.registerRequestModel.rcBookImage == nil) ? true : false
        }else if(self.ArrVehicleDetails[indexPath.row].header == "Insurance policy"){
            cell.btnUpload.isHidden = (self.registerRequestModel.vehicleInsuranceImage == "" || self.registerRequestModel.vehicleInsuranceImage == nil) ? false : true
            cell.vwMoreButtons.isHidden = (self.registerRequestModel.vehicleInsuranceImage == "" || self.registerRequestModel.vehicleInsuranceImage == nil) ? true : false
        }else if(self.ArrVehicleDetails[indexPath.row].header == "Owner certificate"){
            cell.btnUpload.isHidden = (self.registerRequestModel.ownerCertificateImage == "" || self.registerRequestModel.ownerCertificateImage == nil) ? false : true
            cell.vwMoreButtons.isHidden = (self.registerRequestModel.ownerCertificateImage == "" || self.registerRequestModel.ownerCertificateImage == nil) ? true : false
        }else{
            
        }
        
        cell.uploadBtnClouser = {
            self.UploadImage(index: indexPath)
        }
        cell.MoreBtnClouser = {
            let options = (indexPath.row == 2) ? cell.optionsDropDown : cell.optionsDropDownwithExp
            self.Dropdown(Dropdown: cell.ImageDropDown, StringArray: options, control: cell.btnMore, displayView: cell.btnRight, cellIndex : indexPath)
            cell.ImageDropDown.show()
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
