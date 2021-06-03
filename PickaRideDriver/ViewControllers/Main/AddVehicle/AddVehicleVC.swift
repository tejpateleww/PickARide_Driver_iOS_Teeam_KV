//
//  AddVehicleVC.swift
//  PickaRideDriver
//
//  Created by Admin on 08/05/21.
//

import UIKit
import DropDown

class AddVehicleVC: BaseVC, UITextFieldDelegate {

    @IBOutlet weak var txtServiceType: themeWBorderTextField!
    @IBOutlet weak var txtBrand: themeWBorderTextField!
    @IBOutlet weak var txtModel: themeWBorderTextField!
    @IBOutlet weak var txtManufacturer: themeWBorderTextField!
    @IBOutlet weak var txtNumberPlate: themeWBorderTextField!
    @IBOutlet weak var txtCarYear: themeWBorderTextField!
    @IBOutlet weak var carColor: themeWBorderTextField!
    @IBOutlet weak var btnNext: themeButton!
    @IBOutlet weak var lblBrandLine: BGColor!
    @IBOutlet weak var lblModelLine: BGColor!
    @IBOutlet weak var lblCarYearLine: BGColor!
    
    let BrandDropDown = DropDown()
    let ModelDropDown = DropDown()
    let CarYearDropDown = DropDown()
    var brandDropDown = ["Tata","Neno"]
    var modelDropDown = ["Tata Harrier","Hundai i20"]
    var carYearDropDown = ["2020","2021"]
    var onTxtBtnPressed: ( (Int) -> () )?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Dropdown(Dropdown: self.BrandDropDown, StringArray: self.brandDropDown, control: self.txtBrand, displayView: lblBrandLine)
        self.Dropdown(Dropdown: self.ModelDropDown, StringArray: self.modelDropDown, control: self.txtModel, displayView: lblModelLine)
        self.Dropdown(Dropdown: self.CarYearDropDown, StringArray: self.carYearDropDown, control: self.txtCarYear, displayView: lblCarYearLine)
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.Addvehicle.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        setupTextfields(textfield: txtBrand)
        setupTextfields(textfield: txtModel)
        setupTextfields(textfield: txtCarYear)
        
        
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
    
    @IBAction func btnNextTap(_ sender: Any) {
        let vc : PersonalDocumentVC = PersonalDocumentVC.instantiate(fromAppStoryboard: .Login)
        vc.isVehicleDocument = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
