//
//  RideReceiptDetailsVC.swift
//  PickaRideDriver
//
//  Created by Admin on 11/05/21.
//

import UIKit
import Cosmos
class RideReceiptDetailsVC: BaseVC {
    
    @IBOutlet weak var stackViewRating: UIView!
    @IBOutlet weak var vwRatingTop: NSLayoutConstraint!
    @IBOutlet weak var vwRatingBottom: NSLayoutConstraint!
    @IBOutlet weak var lblDiscription: themeLabel!
    
    @IBOutlet weak var lblRatedName: themeLabel!
    @IBOutlet weak var imgRatedProfile: ProfileView!
    @IBOutlet weak var vwCosmos: CosmosView!
    @IBOutlet weak var lblYourRated: themeLabel!
    @IBOutlet weak var imgYourRatedProfile: ProfileView!
    @IBOutlet weak var vwCosmosRated: CosmosView!
    
    @IBOutlet weak var lblPickUpAddress: themeLabel!
    @IBOutlet weak var lblDropOffAddress: themeLabel!
    @IBOutlet weak var lblTotalEarning: themeLabel!
    @IBOutlet weak var tripDuration: themeLabel!
    @IBOutlet weak var tripDistance: themeLabel!
    @IBOutlet weak var lblTripDateTime: themeLabel!
    @IBOutlet weak var lblTripServiceTYpe: themeLabel!
    @IBOutlet weak var lblTripRideType: themeLabel!
    @IBOutlet weak var lblCustNAme: themeLabel!
    @IBOutlet weak var lblPriceRideFare: themeLabel!
    @IBOutlet weak var lblPriceTaxiFee: themeLabel!
    @IBOutlet weak var lblPriceTax: themeLabel!
    @IBOutlet weak var lblPriceTolls: themeLabel!
    @IBOutlet weak var lblPriceDiscount: themeLabel!
    @IBOutlet weak var lblPriceTopUp: themeLabel!
    @IBOutlet weak var lblPriceYourPayment: themeLabel!
    
    var PastBookingData : PastBookingResDatum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareView()
        self.setupData()
    }
    
    func prepareView(){
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.RideDetails.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.help.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        self.stackViewRating.isHidden = true
        self.vwRatingBottom.constant = 0
        self.vwRatingTop.constant = 0
        
        let attributedString = NSMutableAttributedString(string: lblDiscription.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        self.lblDiscription.attributedText = attributedString
    }
    
    func setupData(){
        self.lblPickUpAddress.text = self.PastBookingData?.bookingInfo?.pickupLocation ?? ""
        self.lblDropOffAddress.text = self.PastBookingData?.bookingInfo?.dropoffLocation ?? ""
        self.lblTotalEarning.text = self.PastBookingData?.bookingInfo?.driverAmount?.toCurrencyString()
        self.tripDistance.text = "\(self.PastBookingData?.bookingInfo?.tripDuration ?? "") min"
        self.tripDistance.text = "\(self.PastBookingData?.bookingInfo?.distance ?? "") mi"
        self.lblTripServiceTYpe.text = self.PastBookingData?.bookingInfo?.vehicleName ?? ""
        self.lblTripRideType.text = self.PastBookingData?.bookingInfo?.bookingType ?? ""
        
        let timestamp: TimeInterval =  Double(self.PastBookingData?.bookingInfo?.dropoffTime ?? "") ?? 0.0
        let date = Date(timeIntervalSince1970: timestamp)
        let formatedDate = date.timeAgoSinceDate(isForNotification: false)
        self.lblTripDateTime.text = formatedDate
        
        self.lblPriceRideFare.text = self.PastBookingData?.bookingInfo?.baseFare?.toCurrencyString()
        self.lblPriceTaxiFee.text = self.PastBookingData?.bookingInfo?.companyAmount?.toCurrencyString()
        self.lblPriceTax.text = self.PastBookingData?.bookingInfo?.tax?.toCurrencyString()
        self.lblPriceTolls.text =  self.PastBookingData?.bookingInfo?.extraCharge?.toCurrencyString()
        self.lblPriceDiscount.text = self.PastBookingData?.bookingInfo?.discount?.toCurrencyString()
        self.lblPriceTopUp.text = self.PastBookingData?.bookingInfo?.tips?.toCurrencyString()
        self.lblPriceYourPayment.text = self.PastBookingData?.bookingInfo?.driverAmount?.toCurrencyString()
    }
    
}
