//
//  SettingCell.swift
//  PickaRideDriver
//
//  Created by Admin on 10/05/21.
//

import UIKit

class SettingCell: UITableViewCell {

    @IBOutlet weak var lblTitle: themeLabel!
    @IBOutlet weak var vwSwitch: UIView!
    @IBOutlet weak var vwArrow: UIView!
    @IBOutlet weak var notifSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        notifSwitch.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
