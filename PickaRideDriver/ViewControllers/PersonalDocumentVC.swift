//
//  PersonalDocumentVC.swift
//  PickaRideDriver
//
//  Created by Bhumi on 03/06/21.
//

import UIKit

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
    override func viewDidLoad() {
        super.viewDidLoad()
        if isFromEditProfile{
            btnNext.setTitle("SAVE", for: .normal)
            if isVehicleDocument{
                setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Edit Vehicle Document", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
                vehicleDocuments()
            }else{
                setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Edit Personal Document", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
                personalDetails()
            }
            
        }else{
        if isVehicleDocument{
            setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Vehicle Document", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
            vehicleDocuments()
            btnNext.setTitle(isFromEditProfile ? "SAVE" : "REGISTER", for: .normal)
            
        }else{
            setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: "Personal Document", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
           personalDetails()
        }
        }
        
        
        tblPersonalDetails.delegate = self
        tblPersonalDetails.dataSource = self
        let nib = UINib(nibName: PersonalDocumentCell.className, bundle: nil)
        tblPersonalDetails.register(nib, forCellReuseIdentifier: PersonalDocumentCell.className)
        tblPersonalDetails.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
    }

    func personalDetails(){
        ArrPersonaldetails.append(PersonalDetails(header: "Profile Photo", message: "Clear photo of yours", dateofExp: ""))
        ArrPersonaldetails.append(PersonalDetails(header: "Goverment ID", message: "ID is an offical Document", dateofExp: "Date of expiry : 22/08/ 2022"))
        ArrPersonaldetails.append(PersonalDetails(header: "Driving License", message: "A driving license is an offical Document", dateofExp: "Date of expiry : 22/08/ 2022"))
        ArrPersonaldetails.append(PersonalDetails(header: "Vehicle Registration", message: "Vehicle Registration", dateofExp: "Date of expiry : 22/08/ 2022"))
        ArrPersonaldetails.append(PersonalDetails(header: "Insurance policy", message: "Insurance policy", dateofExp: "Date of expiry : 22/08/ 2022"))
    }
    func vehicleDocuments(){
        ArrPersonaldetails.append(PersonalDetails(header: "RC Book", message: "Vehicle Registration", dateofExp: "Date of expiry : 22/08/ 2022"))
        ArrPersonaldetails.append(PersonalDetails(header: "Insurance policy", message: "Insurance policy", dateofExp: "Date of expiry : 22/08/ 2022"))
        ArrPersonaldetails.append(PersonalDetails(header: "Owner certificate", message: "A passport is a travel document", dateofExp: "Date of expiry : 22/08/ 2022"))
    }
    //MARK:- Custom Methods
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if(keyPath == "contentSize"){
            if let info = object, let collObj = info as? UITableView{
                
                if collObj == self.tblPersonalDetails{
                    self.tblPersonalDetailsHeight.constant = tblPersonalDetails.contentSize.height
                }
            }
            
        }
    }
    //MARK:- IBActions
    @IBAction func btnNextTap(_ sender: Any) {
        if isFromEditProfile{
            self.navigationController?.popViewController(animated: true)
        }else{
        if !isVehicleDocument{
            let vc : AddVehicleVC = AddVehicleVC.instantiate(fromAppStoryboard: .Main)
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc : WaitingForApprovalVC = WaitingForApprovalVC.instantiate(fromAppStoryboard: .Login)
            vc.NavigatetoHomeClosure = {
//                userDefault.setValue(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
//                appDel.navigateToMain()
                self.navigationController?.popToRootViewController(animated: true)
            }
        self.present(vc, animated: false, completion: nil)
        }
        }
    }
}
//MARK:- UITableview delegate and DataSource Method
extension PersonalDocumentVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrPersonaldetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblPersonalDetails.dequeueReusableCell(withIdentifier: PersonalDocumentCell.className) as! PersonalDocumentCell
        if isVehicleDocument{
            cell.btnUpload.isHidden = ArrPersonaldetails[indexPath.row].header == "Owner certificate" ? false : true
            cell.vwMoreButtons.isHidden = ArrPersonaldetails[indexPath.row].header == "Owner certificate" ? true : false

        }else{
            cell.btnUpload.isHidden = ArrPersonaldetails[indexPath.row].header == "Profile Photo" ? false : true
            cell.vwMoreButtons.isHidden = ArrPersonaldetails[indexPath.row].header == "Profile Photo" ? true : false
           
        }
        cell.lblHeading.text = ArrPersonaldetails[indexPath.row].header
        cell.lblMessage.text = ArrPersonaldetails[indexPath.row].message
        cell.lblDateOfExpiry.text = ArrPersonaldetails[indexPath.row].dateofExp
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
