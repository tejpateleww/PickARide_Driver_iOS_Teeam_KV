//
//  MyRideCell.swift
//  PickaRideDriver
//
//  Created by Admin on 10/05/21.
//

import UIKit

class MyRideCell: UITableViewCell {

    @IBOutlet weak var lblMyrides: myRidesLabel!
    @IBOutlet weak var lblRideName: myRidesLabel!
    @IBOutlet weak var lblAddress: myRidesLabel!
    @IBOutlet weak var lblPrice: myRidesLabel!
    @IBOutlet weak var lblAmount: myRidesLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
