//
//  MyRideCell.swift
//  PickaRideDriver
//
//  Created by Admin on 10/05/21.
//

import UIKit
import UIView_Shimmer

class MyRideCell: UITableViewCell{ //ShimmeringViewProtocol 

//    @IBOutlet weak var lblMyrides: myRidesLabel!
//    @IBOutlet weak var lblRideName: myRidesLabel!
//    @IBOutlet weak var lblAddress: myRidesLabel!
//    @IBOutlet weak var lblPrice: myRidesLabel!
//    @IBOutlet weak var lblAmount: myRidesLabel!
    
    @IBOutlet weak var lblDate: themeLabel!
    @IBOutlet weak var lblAddress: themeLabel!
    @IBOutlet weak var lblAmount: themeLabel!
    @IBOutlet weak var lblRideName: themeLabel!
    @IBOutlet weak var imgMap: UIImageView!
    @IBOutlet weak var impPin: UIImageView!
    @IBOutlet weak var lblPrice: themeLabel!
    
//    var shimmeringAnimatedItems: [UIView] {
//        [
//            lblDate,
//            lblAddress,
//            lblAmount,
//            lblRideName,
//            lblPrice,
//            impPin,
//            imgMap
//        ]
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
