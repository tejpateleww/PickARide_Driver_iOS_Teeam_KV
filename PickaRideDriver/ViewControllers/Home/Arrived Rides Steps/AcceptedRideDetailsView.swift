//
//  AcceptedRideDetailsView.swift
//  PickaRideDriver
//
//  Created by Mehul Panchal on 19/05/21.
//

import UIKit
import SDWebImage

enum status{
    case arrived, startride, complete
}

protocol AcceptedRideDetailsViewDelgate {
    func onArrivedUserLocation()
    func onCancelAcceptedRideRequest()
    func onChatRideRequest()
    func onCallRideRequest()
    func onNavigateAction()
    func onTripCompAction()
    func onTripTrackingStarted()
    func onVerifyOtpTap(StrCustOtp:String) -> Bool
}

class AcceptedRideDetailsView: UIView {
    
    //MARK:- IBOutlets
    @IBOutlet weak var stackContackview: UIStackView!
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var mainVWBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var txtfieldTripCode: UITextField!
    @IBOutlet weak var btnSubmit: themeButton!
    @IBOutlet weak var btnCancel: CancelButton!
    @IBOutlet weak var lblTime: CommonLabel!
    @IBOutlet weak var lblExtraTime: CommonLabel!
    @IBOutlet weak var lblMessage: CommonLabel!
    @IBOutlet weak var lblEnterTripCode: CommonLabel!
    @IBOutlet weak var ViewTripCode: UIView!
    @IBOutlet weak var vwLine: UIView!
    @IBOutlet weak var viewDropLocation: UIView!
    @IBOutlet weak var viewContactOptions: UIView!
    @IBOutlet weak var topVW: UIView!
    @IBOutlet weak var mainVW: UIView!
    @IBOutlet weak var timewVW: UIView!
    @IBOutlet weak var btnDownArrow: UIButton!
    @IBOutlet weak var btnSos: UIButton!
    @IBOutlet weak var btnNavigate: UIButton!
    @IBOutlet weak var lbDropLocation: UILabel!
    
    //MARK:- Variables
    var delegate : AcceptedRideDetailsViewDelgate?
    var isArrived : Bool = false
    var isComplete : Bool = false
    var isCompleteClicked : Bool = false
    var TextfieldCountIsFour = false
    var isNoTapFromCancelRide = false
    var isFromCloseBtn = false
    var isCancelFromArrived = false
    var isfrom = status.arrived
    var currentBookingModel : CurrentBookingDatum?
    var timerTracking : Timer?
    
    var isExpandCategory:  Bool  = false {
        didSet {
            mainVWBottomConstraint.constant = isExpandCategory ? 0 : (-mainVW.frame.height + topVW.frame.height + timewVW.frame.height + 35)
            btnDownArrow.isHidden = !isExpandCategory
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState], animations: {
                self.layoutIfNeeded()
            }) { (success) in
                
            }
        }
    }
    
    //MARK:- Initial methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
        self.setupViewCategory()
    }
    
    override func layoutSubviews() {
        viewDropLocation.cornerRadius = viewDropLocation.frame.size.height / 2
    }
    
    //MARK:- custom methods
    func setupView() {
        
        self.ViewTripCode.isHidden = true
        self.txtfieldTripCode.tintColor = themeColor
        self.txtfieldTripCode.font = UIFont.regular(ofSize: FontsSize.Medium)
        self.txtfieldTripCode.textAlignment = .center
        self.txtfieldTripCode.textColor = themeColor
        self.txtfieldTripCode.delegate = self
        
        self.lblTime.font = UIFont.bold(ofSize: FontsSize.Regular)
        self.lblTime.text = ""
        
        self.lblExtraTime.font = UIFont.bold(ofSize: FontsSize.Regular)
        self.lblExtraTime.text = ""
        
        self.lblMessage.font =  UIFont.regular(ofSize: FontsSize.Small)
        self.lblMessage.text = ""
        
        self.lbDropLocation.font = UIFont.regular(ofSize: FontsSize.ExtraSmall)
        self.lbDropLocation.text = ""
        
        self.lblEnterTripCode.font = UIFont.bold(ofSize: FontsSize.Medium)
        self.lblEnterTripCode.text = ConstantString.LABEL_TITLE_HOME_ENTER_TRIP_CODE
        
        self.btnSubmit.setTitle(ConstantString.BUTTON_TITLE_HOME_ARRIVED, for: .normal)
    }
    
    func setupViewCategory() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.topVW.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.topVW.addGestureRecognizer(swipeDown)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            self.endEditing(true)
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
                self.isExpandCategory = false
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
                self.isExpandCategory = true
            default:
                break
            }
        }
    }
    
    @objc func setBottomViewOnclickofViewTop(){
        self.isExpandCategory = !self.isExpandCategory
    }
    
    func setRideDetails() {
        
        let strUrl = "\(APIEnvironment.Profilebu.rawValue)" + "\(self.currentBookingModel?.customerInfo?.profileImage ?? "")"
        let strURl = URL(string: strUrl)
        self.imageViewProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.imageViewProfile.sd_setImage(with: strURl, placeholderImage: UIImage(named: "nav_dummy_userImage"), options: .refreshCached, completed: nil)
        
        let custName = (self.currentBookingModel?.customerInfo?.firstName)! + " " + (self.currentBookingModel?.customerInfo?.lastName)!
        self.lblTime.text = "\(self.currentBookingModel?.tripDuration ?? "0") min"
        self.lblExtraTime.text = "\(self.currentBookingModel?.distance ?? "0") km"
        self.lblMessage.text = "Picking up \(custName)"
        self.lbDropLocation.text = "\(self.currentBookingModel?.pickupLocation ?? "")"
        
        self.setupFlow(TripStatus: self.currentBookingModel?.status ?? "")
    }
    
    func setRideDetailsForTripStart() {
        
        let strUrl = "\(APIEnvironment.Profilebu.rawValue)" + "\(self.currentBookingModel?.customerInfo?.profileImage ?? "")"
        let strURl = URL(string: strUrl)
        self.imageViewProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.imageViewProfile.sd_setImage(with: strURl, placeholderImage: UIImage(named: "nav_dummy_userImage"), options: .refreshCached, completed: nil)
        
        let custName = (self.currentBookingModel?.customerInfo?.firstName)! + " " + (self.currentBookingModel?.customerInfo?.lastName)!
        self.lblTime.text = "\(self.currentBookingModel?.tripDuration ?? "0") min"
        self.lblExtraTime.text = "\(self.currentBookingModel?.distance ?? "0") km"
        self.lblMessage.text = "Dropping up \(custName)"
        self.lbDropLocation.text = "\(self.currentBookingModel?.dropoffLocation ?? "")"
        
        self.setupFlow(TripStatus: self.currentBookingModel?.status ?? "")
    }
    
    func setupFlow(TripStatus:String){
        switch TripStatus {
        case "accepted":
            self.TripAccepted()
        case "traveling":
            self.TripStart()
        default:
            print("Default")
        }
    }
    
    func TripAccepted(){
        self.btnCancel.isHidden = true
        self.btnSubmit.setTitle("ARRIVED", for: .normal)
        self.isComplete = false
        self.isCompleteClicked = false
        self.btnDownArrow.isHidden = false
        self.viewContactOptions.isHidden = false
        self.btnNavigate.isHidden = false
    }
    
    func TripStart(){
        self.isFromCloseBtn = false
        self.btnCancel.isHidden = false
        self.btnSubmit.setTitle("COMPLETE", for: .normal)
        self.isComplete = false
        self.btnDownArrow.isHidden = true
        self.isCompleteClicked = true
        self.ViewTripCode.isHidden = true
        self.viewContactOptions.isHidden = true
        self.btnNavigate.isHidden = false
        
        self.startTimer()
    }
    
    func startTimer() {
        if(self.timerTracking == nil){
            self.timerTracking = Timer.scheduledTimer(withTimeInterval: 7, repeats: true, block: { (timer) in
                print("Track Timer Start ......")
                self.delegate?.onTripTrackingStarted()
            })
        }
    }
    
    func endTimer(){
        if(self.timerTracking != nil){
            self.timerTracking?.invalidate()
            self.timerTracking = nil
            print("Track Timer End ......")
        }
    }
    
    //MARK:- Button action methods
    @IBAction func btnNavigateTap(_ sender: Any) {
        self.delegate?.onNavigateAction()
    }
    
    @IBAction func btnSubmitButtonClickAction(_ sender: Any) {
        
        if  self.isCompleteClicked{
            self.endTimer()
            self.delegate?.onTripCompAction()
        }else if isComplete{
            let status = delegate?.onVerifyOtpTap(StrCustOtp: self.txtfieldTripCode.text ?? "")
            if(status ?? false){
                self.txtfieldTripCode.text = ""
                self.TripStart()
            }else{
                
            }
        }else if isArrived{
            
        }else{
            self.isFromCloseBtn = true
            self.ViewTripCode.isHidden = false
            self.isfrom = status.startride
            self.btnSubmit.setTitle("START RIDE", for: .normal)
            self.btnNavigate.isHidden = false
            self.lblMessage.text = "Arrived \((self.currentBookingModel?.customerInfo?.firstName)! + " " + (self.currentBookingModel?.customerInfo?.lastName)!)"
            self.isArrived = false
            self.isComplete = true
            self.btnCancel.isHidden = true
            self.delegate?.onArrivedUserLocation()
        }
    }
    
    @IBAction func btnSosTap(_ sender: Any) {
    }
    
    @IBAction func btnCallClickAction(_ sender: Any) {
        self.delegate?.onCallRideRequest()
    }
    
    @IBAction func btnMessageClickAction(_ sender: Any) {
        self.delegate?.onChatRideRequest()
    }
    
    @IBAction func btnCancelClickAction(_ sender: Any) {
        self.isFromCloseBtn = true
        self.delegate?.onCancelAcceptedRideRequest()
    }
    
    @IBAction func btnArrowUpDownClickAction(_ sender: Any) {
        if self.btnSubmit.title(for: .normal) == "COMPLETE"{
            
        }else{
            UIView.animate(withDuration: 0.3, animations: { [unowned self] in
                self.ViewTripCode.isHidden = !self.ViewTripCode.isHidden
            })
            self.txtfieldTripCode.endEditing(self.ViewTripCode.isHidden ? false : true)
        }
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        sender.text?.removeAll { !("0"..."9" ~= $0) }
        let text = sender.text ?? ""
        for index in text.indices.reversed() {
            if text.distance(from: text.endIndex, to: index).isMultiple(of: 1) &&
                index != text.startIndex &&
                index != text.endIndex {
                sender.text?.insert(" ", at: index)
                sender.text?.insert(" ", at: index)
            }
        }
        print(sender.text!)
    }
}

extension AcceptedRideDetailsView {
    internal override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event){
                return true
            }
        }
        return false
    }
}

extension AcceptedRideDetailsView : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 10
    }
}
