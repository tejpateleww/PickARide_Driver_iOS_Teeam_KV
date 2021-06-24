//
//  AcceptedRideDetailsView.swift
//  PickaRideDriver
//
//  Created by Mehul Panchal on 19/05/21.
//

import UIKit

protocol AcceptedRideDetailsViewDelgate {
    func onArrivedUserLocation()
    func onCancelAcceptedRideRequest()
    func onChatRideRequest()
}

class AcceptedRideDetailsView: UIView {
    
    var delegate : AcceptedRideDetailsViewDelgate?
    
    @IBOutlet weak var stackContackview: UIStackView!
    @IBOutlet weak var btnDownArrow: UIButton!
    @IBOutlet weak var btnSubmit: CommonButton!
    @IBOutlet weak var ViewTripCode: UIView!
    @IBOutlet weak var lblTime: CommonLabel!
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var btnSos: UIButton!
    @IBOutlet weak var lblExtraTime: CommonLabel!
    @IBOutlet weak var btnNavigate: UIButton!
    @IBOutlet weak var vwLine: UIView!
    @IBOutlet weak var lblMessage: CommonLabel!
    @IBOutlet weak var viewDropLocation: UIView!
    @IBOutlet weak var lbDropLocation: UILabel!
    @IBOutlet weak var lblEnterTripCode: CommonLabel!
    @IBOutlet weak var viewContactOptions: UIView!
    @IBOutlet weak var txtfieldTripCode: UITextField!
    
    var isArrived : Bool = false
    var isComplete : Bool = false
    var isCompleteClicked : Bool = false
    var TextfieldCountIsFour = false
    var space = "                               "
    override func awakeFromNib() {
        super.awakeFromNib()
         setupView()
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    init() {
//        super.init(frame: CGRect.zero)
//    }
    
    override func layoutSubviews() {
        viewDropLocation.cornerRadius = viewDropLocation.frame.size.height / 2
    }
    
    func setRideDetails(/*Pass model class here*/) {
        lblTime.text = "2 min"
        lblExtraTime.text = "0.5 min"
        lblMessage.text = "Picking up James smith"
        lbDropLocation.text = "1 Ash Park, Pembroke Dock, SA7254, Drury Lane, Oldham, OL9 7PH"
    }
    
    @IBAction func btnNavigateTap(_ sender: Any) {
        
    }
    @IBAction func btnSubmitButtonClickAction(_ sender: Any) {
        if  isCompleteClicked{
            isComplete = false
            isCompleteClicked = false
            delegate?.onArrivedUserLocation()
            btnSubmit.setTitle("ARRIVED", for: .normal)
            viewContactOptions.isHidden = false
            btnNavigate.isHidden = false
//            btnDownArrow.isHidden = false
        }else if isComplete{
            btnSubmit.setTitle("COMPLETE", for: .normal)
            isComplete = false
            isCompleteClicked = true
            ViewTripCode.isHidden = true
            viewContactOptions.isHidden = true
            btnNavigate.isHidden = false
//            btnDownArrow.isHidden = true
//            delegate?.onArrivedUserLocation()
        }else if isArrived{
            
//            ViewTripCode.isHidden = true
//            btnSubmit.setTitle("START RIDE", for: .normal)
//            btnNavigate.isHidden = false
//            lblMessage.text = "Arrived Rockden"
//            isArrived = false
//            isComplete = true
        }else{
            ViewTripCode.isHidden = false
            btnSubmit.setTitle("START RIDE", for: .normal)
            btnNavigate.isHidden = false
            lblMessage.text = "Arrived Rockden"
            isArrived = false
            isComplete = true
            
//            ViewTripCode.isHidden = false
//            btnSubmit.setTitle(ConstantString.BUTTON_TITLE_OK, for: .normal)
//            if btnSubmit.title(for: .normal) == ConstantString.BUTTON_TITLE_OK{
//                isArrived = true
//            }
        }
        
    }
    @IBAction func btnSosTap(_ sender: Any) {
    }
    
    @IBAction func btnCallClickAction(_ sender: Any) {
        
    }
    
    @IBAction func btnMessageClickAction(_ sender: Any) {
        delegate?.onChatRideRequest()
        
    }
    
    @IBAction func btnCancelClickAction(_ sender: Any) {
        delegate?.onCancelAcceptedRideRequest()
    }
    
    @IBAction func btnArrowUpDownClickAction(_ sender: Any) {
        if btnSubmit.title(for: .normal) == "COMPLETE"{
//            UIView.animate(withDuration: 0.3, animations: { [unowned self] in
//                self.vwLine.isHidden = !self.vwLine.isHidden
//            })
        }else{
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.ViewTripCode.isHidden = !self.ViewTripCode.isHidden
        })
        self.txtfieldTripCode.endEditing(self.ViewTripCode.isHidden ? false : true)
    }
    }
}

extension AcceptedRideDetailsView {
    
    func setupView() {
        
        ViewTripCode.isHidden = true
        txtfieldTripCode.tintColor = themeColor
        txtfieldTripCode.defaultTextAttributes.updateValue(31.0, forKey: NSAttributedString.Key.kern)
        txtfieldTripCode.font = UIFont.regular(ofSize: FontsSize.Medium)
        txtfieldTripCode.textAlignment = .center
        txtfieldTripCode.textColor = themeColor
        txtfieldTripCode.delegate = self

        lblTime.font = UIFont.bold(ofSize: FontsSize.Regular)
        lblTime.text = ""
        
        lblExtraTime.font = UIFont.bold(ofSize: FontsSize.Regular)
        lblExtraTime.text = ""
        
        lblMessage.font =  UIFont.regular(ofSize: FontsSize.Small)
        lblMessage.text = ""
        
        lbDropLocation.font = UIFont.regular(ofSize: FontsSize.ExtraSmall)
        lbDropLocation.text = ""
        
        lblEnterTripCode.font = UIFont.bold(ofSize: FontsSize.Medium)
        lblEnterTripCode.text = ConstantString.LABEL_TITLE_HOME_ENTER_TRIP_CODE
        
        btnSubmit.setTitle(ConstantString.BUTTON_TITLE_HOME_ARRIVED, for: .normal)
    }
        
}

extension AcceptedRideDetailsView : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 4
    }
}
