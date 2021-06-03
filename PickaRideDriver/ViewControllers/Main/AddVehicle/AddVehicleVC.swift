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
    
    let BrandDropDown = DropDown()
    let ModelDropDown = DropDown()
    let CarYearDropDown = DropDown()
    var brandDropDown = ["Tata","Neno"]
    var modelDropDown = ["Tata Harrier","Hundai i20"]
    var carYearDropDown = ["2020","2021"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtBrand.tag = 101
        self.txtModel.tag = 102
        self.txtCarYear.tag = 103
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.Addvehicle.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        setupTextfields(textfield: txtBrand)
        setupTextfields(textfield: txtModel)
        setupTextfields(textfield: txtCarYear)
        // Do any additional setup after loading the view.
    }
    func setupTextfields(textfield : UITextField) {
        let button = UIButton(type: .custom)
        button.isSelected = true
        button.setImage(UIImage(named: "showpassword"), for: .normal)
        button.setImage(UIImage(named: "hidepassword"), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: -16, bottom: -5, right: 0)
        button.frame = CGRect(x: CGFloat(textfield.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.tag = textfield.tag
        button.addTarget(self, action: #selector(self.showHidePassword), for: .touchUpInside)
        textfield.rightView = button
        textfield.rightViewMode = .always
    }
    
    func Brand(){
        txtBrand.inputView = UIView()
        self.txtBrand.delegate = self
//            textfieldRightbtn(image: #imageLiteral(resourceName: "ic_DownReg"), textfield: txtBrand)
//        txtCountry.setIcon(#imageLiteral(resourceName: "imgDropDown"))
        BrandDropDown.anchorView =  txtBrand
        //  GenderDropdown.direction = .bottom
        BrandDropDown.dataSource = self.brandDropDown
        BrandDropDown.selectionAction = { [unowned self] (index, item) in
            print("Selected Item: \(item) at index: \(index)")
            self.txtBrand.text = self.BrandDropDown.selectedItem
//                self.txtSelectBank.textField.textColor = .black
            
    }
    }
    func model(){
        DispatchQueue.main.async {
            self.txtModel.inputView = UIView()
            self.txtModel.delegate = self
            self.textfieldRightbtn(image: #imageLiteral(resourceName: "ic_DownReg"), textfield: self.txtModel)
    //        txtCountry.setIcon(#imageLiteral(resourceName: "imgDropDown"))
            self.ModelDropDown.anchorView =  self.txtModel
            self.ModelDropDown.direction = .bottom
            self.ModelDropDown.dataSource = self.modelDropDown
            self.ModelDropDown.selectionAction = { [unowned self] (index, item) in
                print("Selected Item: \(item) at index: \(index)")
                self.txtModel.text = self.ModelDropDown.selectedItem
        }
        
//                self.txtSelectBank.textField.textColor = .black
            
    }
    }
    func textfieldRightbtn(image : UIImage, textfield : UITextField){
//        textfield.rightViewMode = .always
//        textfield.rightViewMode = UITextField.ViewMode.always
//        let vwRight = UIView(frame: CGRect(x: textfield.frame.width - 66, y: 0, width: 50, height: textfield.frame.height))
//
//        let frame =  CGRect(x: 0, y: 0, width: 50, height: vwRight.frame.height)
//
//        let button = UIButton(frame: frame)
////         let image1 = UIImage(named: "imgVisiblePw")
//        button.setImage(image, for: .normal)
//        button.tag = textfield.tag
//        button.addTarget(self, action: #selector(iconAction(sender:)), for: .touchUpInside)
//        button.imageView?.contentMode = .scaleAspectFit
////        button.isUserInteractionEnabled = true
//        vwRight.addSubview(button)
//        textfield.rightView = vwRight
//         imageView1.contentMode = .scaleAspectFit
        
        let btn = UIButton(frame: CGRect(x: textfield.frame.width - 30, y: textfield.frame.height / 2 - 15, width: 30, height: 30))
        btn.setImage(image, for: .normal)
        btn.tag = textfield.tag
        btn.addTarget(self, action: #selector(iconAction(sender:)), for: .touchUpInside)
        textfield.rightView = btn
        btn.isUserInteractionEnabled = false
        textfield.rightViewMode = .always
    }
    @objc func iconAction(sender: UIButton){
        self.model()
//        self.onTxtBtnPressed!(sender.tag)
    }
    func carYear(){
        txtCarYear.inputView = UIView()
        self.txtCarYear.delegate = self
//            textfieldRightbtn(image: #imageLiteral(resourceName: "ic_DownReg"), textfield: txtBrand)
//        txtCountry.setIcon(#imageLiteral(resourceName: "imgDropDown"))
        CarYearDropDown.anchorView =  txtCarYear
        //  GenderDropdown.direction = .bottom
        CarYearDropDown.dataSource = self.carYearDropDown
        CarYearDropDown.selectionAction = { [unowned self] (index, item) in
            print("Selected Item: \(item) at index: \(index)")
            self.txtCarYear.text = self.CarYearDropDown.selectedItem
//                self.txtSelectBank.textField.textColor = .black
            
    }
    }
    @IBAction func showHidePassword(_ sender : UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.tag == 101 {
//            sender.isSelected = !sender.isSelected
          
           Brand()
        } else if sender.tag == 102 {
//            sender.isSelected = !sender.isSelected
           model()
        } else if sender.tag == 103 {
            
           
            carYear()
        }
        
    }
    @IBAction func btnNextTap(_ sender: Any) {
        let vc : PersonalDocumentVC = PersonalDocumentVC.instantiate(fromAppStoryboard: .Login)
        vc.isVehicleDocument = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
