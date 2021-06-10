//
//  EditProfileCell.swift
//  PickaRideDriver
//
//  Created by Admin on 08/05/21.
//

import UIKit

class EditProfileCell: UITableViewCell {

    @IBOutlet weak var lblEditProfile: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgArrow.tintColor = themeColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
