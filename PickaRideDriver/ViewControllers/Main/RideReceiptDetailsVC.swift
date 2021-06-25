//
//  RideReceiptDetailsVC.swift
//  PickaRideDriver
//
//  Created by Admin on 11/05/21.
//

import UIKit
import Cosmos
class RideReceiptDetailsVC: BaseVC {

    @IBOutlet weak var vwRatingTop: NSLayoutConstraint!
    @IBOutlet weak var vwRatingBottom: NSLayoutConstraint!
    @IBOutlet weak var lblDiscription: themeLabel!
    @IBOutlet weak var lblAddres: themeLabel!
    @IBOutlet weak var lblArea: themeLabel!
    @IBOutlet weak var lblPrice: themeLabel!
    @IBOutlet weak var lblTime: themeLabel!
    @IBOutlet weak var lblDistance: themeLabel!
    @IBOutlet weak var lblDateTime: themeLabel!
    @IBOutlet weak var lblServiceType: themeLabel!
    @IBOutlet weak var lblRideType: themeLabel!
    @IBOutlet weak var lblRatedName: themeLabel!
    @IBOutlet weak var imgRatedProfile: ProfileView!
    @IBOutlet weak var vwCosmos: CosmosView!
    @IBOutlet weak var lblYourRated: themeLabel!
    @IBOutlet weak var imgYourRatedProfile: ProfileView!
    @IBOutlet weak var vwCosmosRated: CosmosView!
    @IBOutlet weak var lblRideFares: themeLabel!
    @IBOutlet weak var lblTaxiFee: themeLabel!
    @IBOutlet weak var lblTax: themeLabel!
    @IBOutlet weak var lblTolls: themeLabel!
    @IBOutlet weak var lblDiscount: themeLabel!
    @IBOutlet weak var lblTopupAdded: themeLabel!
    @IBOutlet weak var lblYourPayment: themeLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        vwRatingBottom.constant = 0
        vwRatingTop.constant = 0
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.RideDetails.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.help.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        let attributedString = NSMutableAttributedString(string: lblDiscription.text ?? "")

        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()

        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points

        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        // *** Set Attributed String to your label ***
        lblDiscription.attributedText = attributedString
        // Do any additional setup after loading the view.
    }
}
