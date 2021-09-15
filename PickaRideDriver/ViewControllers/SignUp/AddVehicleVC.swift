//
//  AddVehicleVC.swift
//  PickaRideDriver
//
//  Created by Admin on 08/05/21.
//

import UIKit
import DropDown
import IQKeyboardManagerSwift

class AddVehicleVC: BaseVC {
    
    //MARK: - IBOutlets
    @IBOutlet weak var txtServiceType: themeTextField!
    @IBOutlet weak var txtBrand: themeTextField!
    @IBOutlet weak var txtModel: themeTextField!
    @IBOutlet weak var txtManufacturer: themeTextField!
    @IBOutlet weak var txtNumberPlate: themeTextField!
    @IBOutlet weak var txtCarYear: themeTextField!
    @IBOutlet weak var carColor: themeTextField!
    @IBOutlet weak var btnNext: themeButton!
    @IBOutlet weak var lblBrandLine: BGColor!
    @IBOutlet weak var lblModelLine: BGColor!
    @IBOutlet weak var lblCarYearLine: BGColor!
    
    //MARK: - Variables
    let BrandDropDown = DropDown()
    let ModelDropDown = DropDown()
    let CarYearDropDown = DropDown()
    var brandDropDown : [String] = []
    var modelDropDown : [String] = []
    var carYearDropDown : [String] = []
    var onTxtBtnPressed: ( (Int) -> () )?
    var isFromEditProfile : Bool = false
    var addVehicleUserModel = AddVehicleUserModel()
    var registerRequestModel = RegisterFinalRequestModel()
    var ManufacturerList : ManufacturerListModel?
    var brandID = ""
    var modelID = ""
    var serviceTypeID = ""
    var vehicleTypeManufacturerId = ""
    var vehicleInfoViewModel = VehicleInfoViewModel()
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.GetManufacturerList()
    }
    
    //MARK: - custom methods
    func prepareView(){
        if self.isFromEditProfile{
            self.setupDataForProfile()
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Edit Vehicle Details", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        }else{
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.Addvehicle.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        }
        
        self.txtServiceType.isUserInteractionEnabled = false
        self.txtManufacturer.isUserInteractionEnabled = false
        self.setupTextFields()
        
        if(isFromEditProfile){
            self.brandID = SingletonClass.sharedInstance.UserProfilData?.vehicleInfo?[0].companyId ?? ""
            self.modelID = SingletonClass.sharedInstance.UserProfilData?.vehicleInfo?[0].vehicleTypeModelId ?? ""
            self.serviceTypeID = SingletonClass.sharedInstance.UserProfilData?.vehicleInfo?[0].vehicleType ?? ""
            self.vehicleTypeManufacturerId = SingletonClass.sharedInstance.UserProfilData?.vehicleInfo?[0].vehicleTypeManufacturerId ?? ""
        }
    }
    
    func setupDataForProfile(){
        self.txtBrand.text = SingletonClass.sharedInstance.UserProfilData?.vehicleInfo?[0].vehicleTypeManufacturerName ?? ""
        self.txtModel.text = SingletonClass.sharedInstance.UserProfilData?.vehicleInfo?[0].vehicleTypeModelName ?? ""
        self.txtServiceType.text = SingletonClass.sharedInstance.UserProfilData?.vehicleInfo?[0].vehicleTypeName ?? ""
        self.txtManufacturer.text = SingletonClass.sharedInstance.UserProfilData?.vehicleInfo?[0].vehicleTypeManufacturerName ?? ""
        self.txtNumberPlate.text = SingletonClass.sharedInstance.UserProfilData?.vehicleInfo?[0].plateNumber ?? ""
        self.txtCarYear.text = SingletonClass.sharedInstance.UserProfilData?.vehicleInfo?[0].yearOfManufacture ?? ""
        self.carColor.text = SingletonClass.sharedInstance.UserProfilData?.vehicleInfo?[0].color ?? ""
        self.btnNext.setTitle("SAVE", for: .normal)
    }
    
    func setupTextFields(){
        self.setupTextfields(textfield: txtBrand)
        self.setupTextfields(textfield: txtModel)
        self.setupTextfields(textfield: txtCarYear)
    }
    
    func setupTextfields(textfield : UITextField) {
        let button = UIButton(type: .custom)
        button.isSelected = true
        button.setImage(#imageLiteral(resourceName: "ic_DownReg"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "ic_DownReg"), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(textfield.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.isUserInteractionEnabled = false
        button.tag = textfield.tag
        textfield.rightView = button
        textfield.rightViewMode = .always
    }
    
    func setupData(){
        let yearData = self.ManufacturerList?.yearList
        for year in yearData ?? [] {
            self.carYearDropDown.append(String(year))
        }
        let Brand = self.ManufacturerList?.data
        for brand in Brand ?? [] {
            self.brandDropDown.append(brand.manufacturerName ?? "")
        }
        self.Dropdown(Dropdown: self.BrandDropDown, StringArray: self.brandDropDown, control: self.txtBrand, displayView: lblBrandLine)
        self.Dropdown(Dropdown: self.CarYearDropDown, StringArray: self.carYearDropDown, control: self.txtCarYear, displayView: lblCarYearLine)
    }
    
    func validation() -> Bool{
        if(self.txtBrand.text == ""){
            Toast.show(title: UrlConstant.Required, message: "Please select vehicle brand", state: .failure)
            return false
        }else if(self.txtModel.text == "" || self.modelID == ""){
            Toast.show(title: UrlConstant.Required, message: "Please select vehicle model", state: .failure)
            return false
        }else if(self.txtServiceType.text == "" || self.serviceTypeID == ""){
            Toast.show(title: UrlConstant.Required, message: "Please select vehicle ServiceType", state: .failure)
            return false
        }else if(self.txtManufacturer.text == ""){
            Toast.show(title: UrlConstant.Required, message: "Please enter vehicle Manufacturer", state: .failure)
            return false
        }else if(self.txtNumberPlate.text == ""){
            Toast.show(title: UrlConstant.Required, message: "Please enter vehicle NumberPlate", state: .failure)
            return false
        }else if(self.txtCarYear.text == ""){
            Toast.show(title: UrlConstant.Required, message: "Please enter vehicle Year", state: .failure)
            return false
        }else if(self.carColor.text == ""){
            Toast.show(title: UrlConstant.Required, message: "Please enter vehicle Color", state: .failure)
            return false
        }
        return true
    }
    
    //MARK: - Dropdown methods
    func Dropdown(Dropdown : DropDown?, StringArray : [String], control : UITextField, displayView : UIView){
        Dropdown?.anchorView = displayView
        Dropdown?.dataSource = StringArray
        Dropdown?.selectionAction = { (index, item) in
            control.text = Dropdown?.selectedItem
            control.textColor = .black
            
            if(Dropdown == self.BrandDropDown){
                self.setupModelData(strBrand: item)
                self.txtManufacturer.text = item
                self.txtModel.text = ""
                self.txtServiceType.text = ""
            }
            if(Dropdown == self.ModelDropDown){
                self.setupModelServiceType(strModel: item)
            }
        }
    }
    
    func setupModelData(strBrand : String){
        self.modelDropDown = []
        let Brand = self.ManufacturerList?.data
        for brand in Brand ?? [] {
            if(brand.manufacturerName == strBrand){
                self.brandID = brand.id ?? ""
                let Model = brand.vehicleModel
                for model in Model ?? [] {
                    self.modelDropDown.append(model.vehicleTypeModelName ?? "")
                }
            }
        }
        self.Dropdown(Dropdown: self.ModelDropDown, StringArray: self.modelDropDown, control: self.txtModel, displayView: lblModelLine)
    }
    
    func setupModelServiceType(strModel : String){
        let Brand = self.ManufacturerList?.data
        for brand in Brand ?? [] {
            let Model = brand.vehicleModel
            for model in Model ?? [] {
                if(model.vehicleTypeModelName == strModel){
                    self.txtServiceType.text = model.vehicleTypeName ?? ""
                    self.modelID = model.id ?? ""
                    self.serviceTypeID = model.vehicleTypeId ?? ""
                    self.vehicleTypeManufacturerId = model.vehicleTypeManufacturerId ?? ""
                }
            }
            self.Dropdown(Dropdown: self.ModelDropDown, StringArray: self.modelDropDown, control: self.txtModel, displayView: lblModelLine)
        }
    }
    
    func storeDataInRegisterModel(){
        self.registerRequestModel.plateNumber = self.txtNumberPlate.text ?? ""
        self.registerRequestModel.yearOfManufacture = self.txtCarYear.text ?? ""
        self.registerRequestModel.color = self.carColor.text ?? ""
        self.registerRequestModel.vehicleTypeManufacturerId = self.vehicleTypeManufacturerId
        self.registerRequestModel.vehicleTypeModelId = self.modelID
        self.registerRequestModel.vehicleType = self.serviceTypeID
        
        let vc : VehicleDocumentVC = VehicleDocumentVC.instantiate(fromAppStoryboard: .Login)
        vc.registerRequestModel = self.registerRequestModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: -  btn action methods
    @IBAction func btnNextTap(_ sender: Any) {
        if validation(){
            if isFromEditProfile{
                self.callUpdateVehicleInfoAPI()
            }else{
                self.storeDataInRegisterModel()
            }
        }
    }
    
}

//MARK:- Api Call
extension AddVehicleVC{
    func GetManufacturerList(){
        self.addVehicleUserModel.addVehicleVC = self
        self.addVehicleUserModel.registerRequestModel = self.registerRequestModel
        self.addVehicleUserModel.webserviceGetManufacturerList()
    }
    
    func callUpdateVehicleInfoAPI(){
        self.vehicleInfoViewModel.addVehicleVC = self
        
        let UploadDocReq = UpdateVehicleInfoReqModel()
        UploadDocReq.color = self.carColor.text ?? ""
        UploadDocReq.vehicleType = self.serviceTypeID
        UploadDocReq.plateNumber = self.txtNumberPlate.text ?? ""
        UploadDocReq.yearOfManufacture = self.txtCarYear.text ?? ""
        UploadDocReq.vehicleTypeModelId = self.modelID
        UploadDocReq.vehicleTypeManufacturerId = self.vehicleTypeManufacturerId
        
        self.vehicleInfoViewModel.webserviceUpdateVehicleInfoAPI(reqModel: UploadDocReq)
    }
}

//MARK:- UITextFieldDelegate methods
extension AddVehicleVC: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtBrand{
            self.BrandDropDown.show()
        }else if textField == self.txtModel{
            self.ModelDropDown.show()
        }else if textField == self.txtCarYear{
            self.CarYearDropDown.show()
        }
        return !(textField == self.txtBrand || textField == self.txtModel || textField == self.txtCarYear)
    }
  
}
