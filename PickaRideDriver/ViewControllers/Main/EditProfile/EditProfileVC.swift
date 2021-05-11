//
//  EditProfileVC.swift
//  PickaRideDriver
//
//  Created by Admin on 08/05/21.
//

import UIKit

class EditProfileVC: BaseVC {
    let arrEditProfile = ["Edit Bank Details","Edit Personal Details","Edit Vehicle Details","Edit Vehicle Documents"]
    var selectedImage : UIImage?
    private var imagePicker : ImagePicker!
    var isRemovePhoto = false
    @IBOutlet weak var vwMobile: UIView!
    @IBOutlet weak var tblEditProfile: UITableView!
    @IBOutlet weak var tblEditProfileHeight: NSLayoutConstraint!
    @IBOutlet weak var btnUpdatePicture: UIButton!
    @IBOutlet weak var imgProfile: ProfileView!{ didSet{ imgProfile.layer.cornerRadius = imgProfile.frame.size.height / 2}}
    @IBOutlet weak var txtName: themeTextField!
    @IBOutlet weak var txtEmail: themeTextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtPassword: themeTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.cancel.value, rightImages: [NavItemsRight.EditProfile.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        tblEditProfile.delegate = self
        tblEditProfile.dataSource = self
        tblEditProfile.reloadData()
        vwMobile.layer.borderWidth = 1
        vwMobile.layer.borderColor = colors.textfieldbordercolor.value.cgColor
        self.imagePicker = ImagePicker(presentationController: self, delegate: self, allowsEditing: false)
        self.imagePicker = ImagePicker(presentationController: self, delegate: self, allowsEditing: true)
        tblEditProfile.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        // Do any additional setup after loading the view.
    }
    @IBAction func btnEditProfile(_ sender: Any) {
        resignFirstResponder()
        if (self.imgProfile.image != nil || self.selectedImage != nil) && ((self.imgProfile.image?.isEqualToImage(UIImage.init(named: "Dummy-Profile")!)) != nil){
            self.imagePicker.present(from: self.imgProfile, viewPresented: self.view, isRemove: true)
        } else {
            self.imagePicker.present(from: self.imgProfile, viewPresented: self.view, isRemove: false)
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if(keyPath == "contentSize"){
            self.tblEditProfileHeight.constant = tblEditProfile.contentSize.height < 122.5 ? 122.5: tblEditProfile.contentSize.height
        }
    }
}
extension EditProfileVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEditProfile.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EditProfileCell = tblEditProfile.dequeueReusableCell(withIdentifier: EditProfileCell.className, for: indexPath)as! EditProfileCell
        cell.lblEditProfile.text = arrEditProfile[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
// MARK: - ImagePickerDelegate
extension EditProfileVC:ImagePickerDelegate {
    
    func didSelect(image: UIImage?, SelectedTag:Int) {
        //        isRemovePhoto = false
        if(image == nil && SelectedTag == 101){
            self.selectedImage = UIImage()
            self.isRemovePhoto = true
            self.imgProfile.image = UIImage.init(named: "Dummy-Profile")
            //webservice_RemoveProfilePicture()
        }else if image != nil{
            let fixedOrientedImage = image?.fixOrientation()
            self.imgProfile.image = fixedOrientedImage
            self.selectedImage = self.imgProfile.image
        }else{
            return
        }
    }
}
