//
//  IncomingRideRequestView.swift
//  PickaRideDriver
//
//  Created by Mehul Panchal on 17/05/21.
//

import UIKit

protocol IncomingRideRequestViewDelegate {
    func onAcceptRideRequest()
    func onCancelRideRequest()
}

class IncomingRideRequestView: UIView {
    
    var delegate : IncomingRideRequestViewDelegate?
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblDropUpAddress: CommonLabel!
    @IBOutlet weak var lblPickUpAddress: CommonLabel!
    @IBOutlet weak var btnAcceptRequest: SubmitButton!
    @IBOutlet weak var lblFare: CommonLabel!
    @IBOutlet weak var lblDistance: CommonLabel!
    @IBOutlet weak var lblDuration: CommonLabel!
    @IBOutlet weak var imageViewProfilePic: UIImageView!
    @IBOutlet weak var lblName: CommonLabel!
    @IBOutlet weak var lblRatings: CommonLabel!
    @IBOutlet weak var viewCount: UIView!
    @IBOutlet weak var lblCount: CommonLabel!
    @IBOutlet weak var lblNoThanks: CommonLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         setupView()
    }
    
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    init() {
//        super.init(frame: CGRect.zero)
//    }
    
    override func layoutSubviews() {
        viewCount.cornerRadius = viewCount.frame.size.height / 2
        imageViewProfilePic.cornerRadius = imageViewProfilePic.frame.size.height / 2
    }
    
    @IBAction func btnAcceptRequestClickAction(_ sender: Any) {
        delegate?.onAcceptRideRequest()
    }
    
    @IBAction func btnCancelRideClickAction(_ sender: Any) {
        delegate?.onCancelRideRequest()
    }
    
    func setRideDetails(/*Pass model class here*/)
    {
        lblName.text = "James smith"
        lblRatings.text = "⭑ 3.5"
        lblDuration.text = "~ 25 min"
        lblFare.text = "~ $12.50"
        lblDistance.text = "4.5 km"
        lblPickUpAddress.text = "1 Ash Park, Pembroke Dock, SA72"
        lblDropUpAddress.text = "54 Hollybank Rd, Southampton"
        lblCount.text = "15"
    }
}
    
fileprivate extension IncomingRideRequestView {
    
    func setupView() {
        
        lblName.text = ""
        lblName.font = UIFont.medium(ofSize: FontsSize.Regular)
        
        lblRatings.text = ""
        lblRatings.font = UIFont.regular(ofSize: FontsSize.Regular)
        
        lblDuration.text = ""
        lblDuration.font = UIFont.bold(ofSize: FontsSize.Medium)
        
        lblFare.text = ""
        lblFare.font = UIFont.regular(ofSize: FontsSize.Regular)
        
        lblDistance.text = ""
        lblDistance.font = UIFont.regular(ofSize: FontsSize.Regular)
        
        lblDropUpAddress.text = ""
        lblDropUpAddress.font = UIFont.regular(ofSize: FontsSize.ExtraSmall)
        
        lblPickUpAddress.text = ""
        lblPickUpAddress.font = UIFont.regular(ofSize: FontsSize.ExtraSmall)
        
        viewCount.backgroundColor = themeColorBlack.withAlphaComponent(0.2)
        
        lblCount.text = ""
        lblCount.font = UIFont.bold(ofSize: FontsSize.Tiny)
        lblCount.textColor = UIColor.white


        lblNoThanks.text = ConstantString.LABEL_TITLE_HOME_NO_THANKS
        lblNoThanks.font = UIFont.regular(ofSize: FontsSize.ExtraSmall)
        
        btnAcceptRequest.setTitle(ConstantString.BUTTON_TITLE_HOME_TAP_TO_ACCCEPT, for: .normal)
    }
        
}
