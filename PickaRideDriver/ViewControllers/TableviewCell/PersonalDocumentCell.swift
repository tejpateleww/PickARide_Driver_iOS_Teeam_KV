
//
//  PersonalDocumentCell.swift
//  PickaRideDriver
//
//  Created by Bhumi on 03/06/21.
//

import UIKit
import DropDown

class PersonalDocumentCell: UITableViewCell {

    @IBOutlet weak var vwMoreButtons: UIView!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var lblHeading: themeLabel!
    @IBOutlet weak var lblMessage: themeLabel!
    @IBOutlet weak var lblDateOfExpiry: themeLabel!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var btnUpload: themeButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    
    var uploadBtnClouser : (()->())?
    var MoreBtnClouser : (()->())?
    var btnInfoClouser : (()->())?
    
    let ImageDropDown = DropDown()
    var optionsDropDown = ["Edit","Remove"]
    var optionsDropDownwithExp = ["Edit","Remove","Expiry Date"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnUpload.tintColor = themeColor
        btnRight.tintColor = themeColor
        // Initialization code
        
        self.activity.color = themeColor
        self.activity.hidesWhenStopped = true
        self.contentView.addSubview(self.activity)
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func btnMoreClick(_ sender: UIButton) {
        if let obj = MoreBtnClouser{
            obj()
        }
    }
    
    @IBAction func btnRight(_ sender: UIButton) {
        
    }
    
    @IBAction func btnUploadClick(_ sender: Any) {
        if let obj = uploadBtnClouser{
            obj()
        }
    }
    
    @IBAction func btnInfoAction(_ sender: Any) {
        if let obj = btnInfoClouser{
            obj()
        }
    }
    
  
}
