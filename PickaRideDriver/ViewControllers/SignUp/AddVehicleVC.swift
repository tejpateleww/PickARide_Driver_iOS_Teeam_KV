//
//  AddVehicleVC.swift
//  PickaRideDriver
//
//  Created by Admin on 08/05/21.
//

import UIKit
import DropDown

class AddVehicleVC: BaseVC, UITextFieldDelegate {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isFromEditProfile{
            btnNext.setTitle("SAVE", for: .normal)
            setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Edit Vehicle Details", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
            txtServiceType.text = "Micro"
            txtBrand.text = "BMW"
            txtModel.text = "ABC"
            txtManufacturer.text = "BMW"
            txtNumberPlate.text = "YT1234"
            txtCarYear.text = "2012"
            carColor.text = "Red"
            
        }else{
            setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.Addvehicle.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        }
        
        self.txtServiceType.isUserInteractionEnabled = false
        self.txtManufacturer.isUserInteractionEnabled = false
        
        setupTextfields(textfield: txtBrand)
        setupTextfields(textfield: txtModel)
        setupTextfields(textfield: txtCarYear)
        
        self.GetManufacturerList()
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
    
    func Dropdown(Dropdown : DropDown?, StringArray : [String], control : UITextField, displayView : UIView){
        Dropdown?.anchorView = displayView
        Dropdown?.dataSource = StringArray
        Dropdown?.selectionAction = { (index, item) in
            print("Selected Item: \(item) at index: \(index)")
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
    
    func setupModelData(strBrand : String){
        self.modelDropDown = []
        let Brand = self.ManufacturerList?.data
        for brand in Brand ?? [] {
            let Model = brand.vehicleModel
            for model in Model ?? [] {
                if(brand.manufacturerName == strBrand){
                    self.modelDropDown.append(model.vehicleTypeModelName ?? "")
                }
            }
            self.Dropdown(Dropdown: self.ModelDropDown, StringArray: self.modelDropDown, control: self.txtModel, displayView: lblModelLine)
        }
    }
    
    func setupModelServiceType(strModel : String){
        let Brand = self.ManufacturerList?.data
        for brand in Brand ?? [] {
            let Model = brand.vehicleModel
            for model in Model ?? [] {
                if(model.vehicleTypeModelName == strModel){
                    self.txtServiceType.text = model.vehicleTypeName ?? ""
                }
            }
            self.Dropdown(Dropdown: self.ModelDropDown, StringArray: self.modelDropDown, control: self.txtModel, displayView: lblModelLine)
        }
    }
    
    @IBAction func btnNextTap(_ sender: Any) {
        if isFromEditProfile{
            self.navigationController?.popViewController(animated: true)
        }else{
            let vc : PersonalDocumentVC = PersonalDocumentVC.instantiate(fromAppStoryboard: .Login)
            vc.isVehicleDocument = true
            self.navigationController?.pushViewController(vc, animated: true)
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
