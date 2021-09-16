//
//  RideDetailsVC.swift
//  PickaRideDriver
//
//  Created by Admin on 10/05/21.
//

import UIKit

class RideDetailsVC: BaseVC {

    @IBOutlet weak var stackviewRecieptBottom: NSLayoutConstraint!
    @IBOutlet weak var stackviewRecieptTop: NSLayoutConstraint!
    @IBOutlet weak var stackviewRecieptHeight: NSLayoutConstraint!
    @IBOutlet weak var vwMap: UIView!
    @IBOutlet weak var lblTime: RideDetailLabel!
    @IBOutlet weak var imgMapView: UIImageView!
    @IBOutlet weak var MyOfferView: UIView!
    @IBOutlet weak var lblRidigo: RideDetailLabel!
    @IBOutlet weak var lblCarName: RideDetailLabel!
    @IBOutlet weak var lblAddress: RideDetailLabel!
    @IBOutlet weak var lblPrice: RideDetailLabel!
    @IBOutlet weak var lblPickupLocation: RideDetailLabel!
    @IBOutlet weak var lblDestLocation: RideDetailLabel!
    @IBOutlet weak var imgProfilw: ProfileView!
    @IBOutlet weak var lblRideCustomerName: RideDetailLabel!
    @IBOutlet weak var imgRating: UIImageView!
    @IBOutlet weak var btnRepeateRide: UIButton!
    @IBOutlet weak var btnReceipt: RidesDetailsButton!
    
    var isFromUpcomming : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnRepeateRide.isUserInteractionEnabled = false
        btnReceipt.isHidden = isFromUpcomming ? true : false
        if isFromUpcomming{
            stackviewRecieptBottom.constant = 0
            stackviewRecieptHeight.constant = 0
        }
        setNavigationBarInViewController(controller: self, naviColor: colors.white.value, naviTitle: "Ride Details", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        shadowView(view: MyOfferView)
        MyOfferView.layer.cornerRadius = 4
        
    }
    @IBAction func btnReceiptTap(_ sender: Any) {
        let vc : RideReceiptDetailsVC = RideReceiptDetailsVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnRepeatRideTap(_ sender: Any) {
    }
    @IBAction func btnHelpTap(_ sender: Any) {
    }
    
    func shadowView(view : UIView){
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 4
    }
}

