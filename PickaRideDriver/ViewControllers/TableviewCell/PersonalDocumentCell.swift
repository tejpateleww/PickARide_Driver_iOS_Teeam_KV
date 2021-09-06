
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
    @IBOutlet weak var vwLoder: UIView!
    @IBOutlet weak var lblDateOfExpiry: themeLabel!
    
    var uploadBtnClouser : (()->())?
    var MoreBtnClouser : (()->())?
    
    let ImageDropDown = DropDown()
    var optionsDropDown = ["Edit","Remove"]
    var optionsDropDownwithExp = ["Edit","Remove","Expiry Date"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnUpload.tintColor = themeColor
        btnRight.tintColor = themeColor
        // Initialization code
        
        
    }
    @IBOutlet weak var btnUpload: themeButton!
    
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
  
}
