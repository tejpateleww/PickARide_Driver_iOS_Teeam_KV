//
//  AcceptedRideDetailsView.swift
//  PickaRideDriver
//
//  Created by Mehul Panchal on 19/05/21.
//

import UIKit

protocol AcceptedRideDetailsViewDelgate {
    func onArrivedUserLocation()
    func onCancelRideRequest()
}

class AcceptedRideDetailsView: UIView {
    
    @IBOutlet weak var btnSubmit: CommonButton!
    @IBOutlet weak var stackViewTripCode: UIStackView!
    @IBOutlet weak var lblTime: CommonLabel!
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var lblExtraTime: CommonLabel!
    @IBOutlet weak var lblMessage: CommonLabel!
    @IBOutlet weak var viewDropLocation: UIView!
    @IBOutlet weak var lbDropLocation: UILabel!
    @IBOutlet weak var lblEnterTripCode: CommonLabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setupView()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    override func layoutSubviews() {
        viewDropLocation.cornerRadius = viewDropLocation.frame.size.height / 2
    }
    
    
    @IBAction func btnSubmitButtonClickAction(_ sender: Any) {
        
    }
    
    @IBAction func btnCallClickAction(_ sender: Any) {
        
    }
    
    @IBAction func btnMessageClickAction(_ sender: Any) {
        
    }
    
    @IBAction func btnCancelClickAction(_ sender: Any) {
        
    }
    
    @IBAction func btnArrowUpDownClickAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.stackViewTripCode.isHidden = !self.stackViewTripCode.isHidden
            self.layoutIfNeeded()
        })
    }
}

extension AcceptedRideDetailsView {
    
    func setupView() {
        
        lblTime.font = UIFont.bold(ofSize: FontsSize.Regular)
        lblTime.text = ""
        
        lblExtraTime.font = UIFont.bold(ofSize: FontsSize.Regular)
        lblExtraTime.text = ""
        
        lblMessage.font =  UIFont.regular(ofSize: FontsSize.Small)
        lblMessage.text = ""
        
        lbDropLocation.font = UIFont.regular(ofSize: FontsSize.ExtraSmall)
        lbDropLocation.text = ""
        
        lblEnterTripCode.text = ConstantString.LABEL_TITLE_HOME_ENTER_TRIP_CODE
        
        btnSubmit.setTitle(ConstantString.BUTTON_TITLE_EARNING_WEEKLY.Localized(), for: .normal)
    }
    
    func setRideDetails(/*Pass model class here*/) {
        lblTime.text = "2 min"
        lblExtraTime.text = "0.5 min"
        lblMessage.text = "Picking up James smith"
    }
    
}
