//
//  AddVehicleVC.swift
//  PickaRideDriver
//
//  Created by Admin on 08/05/21.
//

import UIKit
import DropDown

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
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.GetManufacturerList()
    }
    
    //MARK: - custom methods
    func prepareView(){
        if self.isFromEditProfile{
            self.btnNext.setTitle("SAVE", for: .normal)
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Edit Vehicle Details", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
            self.txtServiceType.text = "Micro"
            self.txtBrand.text = "BMW"
            self.txtModel.text = "ABC"
            self.txtManufacturer.text = "BMW"
            self.txtNumberPlate.text = "YT1234"
            self.txtCarYear.text = "2012"
            self.carColor.text = "Red"
        }else{
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.Addvehicle.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        }
        self.txtServiceType.isUserInteractionEnabled = false
        self.txtManufacturer.isUserInteractionEnabled = false
        self.setupTextFields()
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
        if(self.txtBrand.text == "" || self.brandID == ""){
            Utilities.showAlertAction(AppName, message: "Please select vehicle brand", vc: self)
            return false
        }else if(self.txtModel.text == "" || self.modelID == ""){
            Utilities.showAlertAction(AppName, message: "Please select vehicle model", vc: self)
            return false
        }else if(self.txtServiceType.text == "" || self.serviceTypeID == ""){
            Utilities.showAlertAction(AppName, message: "Please select vehicle ServiceType", vc: self)
            return false
        }else if(self.txtManufacturer.text == ""){
            Utilities.showAlertAction(AppName, message: "Please enter vehicle Manufacturer", vc: self)
            return false
        }else if(self.txtNumberPlate.text == ""){
            Utilities.showAlertAction(AppName, message: "Please enter vehicle NumberPlate", vc: self)
            return false
        }else if(self.txtCarYear.text == ""){
            Utilities.showAlertAction(AppName, message: "Please enter vehicle Year", vc: self)
            return false
        }else if(self.carColor.text == ""){
            Utilities.showAlertAction(AppName, message: "Please enter vehicle Color", vc: self)
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
                self.navigationController?.popViewController(animated: true)
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
