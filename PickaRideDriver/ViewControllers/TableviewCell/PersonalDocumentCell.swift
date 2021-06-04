
//
//  PersonalDocumentCell.swift
//  PickaRideDriver
//
//  Created by Bhumi on 03/06/21.
//

import UIKit

class PersonalDocumentCell: UITableViewCell {

    @IBOutlet weak var vwMoreButtons: UIView!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var lblHeading: themeLabel!
    @IBOutlet weak var lblMessage: themeLabel!
    @IBOutlet weak var vwLoder: UIView!
    @IBOutlet weak var lblDateOfExpiry: themeLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        btnUpload.tintColor = themeColor
        btnRight.tintColor = themeColor
        // Initialization code
    }
    @IBOutlet weak var btnUpload: themeButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnMoreClick(_ sender: UIButton) {
        
    }
    
    @IBAction func btnRight(_ sender: UIButton) {
        
    }
    @IBAction func btnUploadClick(_ sender: Any) {
    }
}
