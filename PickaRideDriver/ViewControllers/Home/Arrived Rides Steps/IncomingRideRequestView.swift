//
//  IncomingRideRequestView.swift
//  PickaRideDriver
//
//  Created by Mehul Panchal on 17/05/21.
//

import UIKit
import Cosmos
import SDWebImage
import SocketIO

protocol IncomingRideRequestViewDelegate {
    func onAcceptRideRequest()
    func onCancelRideRequest()
    func onNoThanksRequest()
    func onCurrentBookingAPI()
}

class IncomingRideRequestView: UIView {
    
    //MARK:- IBOutlet
    @IBOutlet weak var vwHomeScreen: HomescreenView!
    @IBOutlet weak var viewCancelRide: UIView!
    @IBOutlet weak var btnNavigateWidth: NSLayoutConstraint!
    @IBOutlet weak var btnSos: UIButton!
    @IBOutlet weak var btnNavigate: UIButton!
    @IBOutlet weak var btnNoThanks: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var vwRating: CosmosView!
    @IBOutlet weak var lblDropUpAddress: CommonLabel!
    @IBOutlet weak var lblPickUpAddress: CommonLabel!
    @IBOutlet weak var btnAcceptRequest: themeButton!
    @IBOutlet weak var lblFare: CommonLabel!
    @IBOutlet weak var lblDistance: CommonLabel!
    @IBOutlet weak var lblDuration: CommonLabel!
    @IBOutlet weak var imageViewProfilePic: UIImageView!
    @IBOutlet weak var lblName: CommonLabel!
    @IBOutlet weak var lblRatings: CommonLabel!
    @IBOutlet weak var viewCount: UIView!
    @IBOutlet weak var lblCount: CommonLabel!
    @IBOutlet weak var lblNoThanks: CommonLabel!
    @IBOutlet weak var topVW: UIView!
    @IBOutlet weak var driverInfoVW: UIView!
    @IBOutlet weak var mainVWBottomConstraint: NSLayoutConstraint!
    
    //MARK:- Variables
    var delegate : IncomingRideRequestViewDelegate?
    var noThanksTapClosure : (()->())?
    var newBookingResModel : NewBookingResBookingInfo?
    var counter = 15
    var timer = Timer()
    
    var isExpandCategory:  Bool  = false {
        didSet {
            mainVWBottomConstraint.constant = isExpandCategory ? 0 : (-viewContainer.frame.height + topVW.frame.height + driverInfoVW.frame.height + 22)
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState], animations: {
                self.layoutIfNeeded()
            }) { (success) in
                
            }
        }
    }
    
    //MARK:- awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwRating.isUserInteractionEnabled = false
        self.viewCancelRide.backgroundColor = themeColor
        self.setupView()
        self.setupViewCategory()
        self.SocketOnMethods()
    }
    
    override func layoutSubviews() {
        self.viewCount.cornerRadius = self.viewCount.frame.size.height / 2
        self.imageViewProfilePic.cornerRadius = self.imageViewProfilePic.frame.size.height / 2
    }
    
    //MARK:- custom methods
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
    
    
    internal override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
    
    func setRideDetails()
    {
        let strUrl = "\(APIEnvironment.Profilebu.rawValue)" + "\(self.newBookingResModel?.customerInfo.profileImage ?? "")"
        let strURl = URL(string: strUrl)
        self.imageViewProfilePic.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.imageViewProfilePic.sd_setImage(with: strURl, placeholderImage: UIImage(named: "nav_dummy_userImage"), options: .refreshCached, completed: nil)
        
        let custName = (self.newBookingResModel?.customerInfo?.firstName ?? "")! + " " + (self.newBookingResModel?.customerInfo?.lastName ?? "")!
        self.lblName.text = custName
        self.lblRatings.text = "(\(self.newBookingResModel?.customerInfo.rating ?? "0"))"
        self.lblDuration.text = "~ \(self.newBookingResModel?.tripDuration ?? "0") min"
        self.lblFare.text = "~ $\(self.newBookingResModel?.estimatedFare ?? "")"
        self.lblDistance.text = "\(self.newBookingResModel?.distance ?? "") km"
        self.lblPickUpAddress.text = self.newBookingResModel?.pickupLocation ?? ""
        self.lblDropUpAddress.text = self.newBookingResModel?.dropoffLocation ?? ""
        self.vwRating.rating = Double(self.newBookingResModel?.customerInfo.rating ?? "0") ?? 0.0
        self.lblCount.text = "15"
        self.setTimer()
    }
    
    func callCurrentBookingAPI(){
        self.delegate?.onCurrentBookingAPI()
    }
    
    func setTimer(){
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        if self.counter > 0{
            self.counter -= 1
            self.lblCount.text =  "\(self.counter)"
        } else {
            self.counter = 15
            self.timer.invalidate()
            if(SocketIOManager.shared.socket.status == .connected){
                let BookingId = self.newBookingResModel?.id ?? "0"
                self.emitSocket_forwardBookingRequestToAnotherDriver(bookingId: BookingId)
            }
            self.delegate?.onCancelRideRequest()
        }
    }
    
    //MARK:- btn action methods
    @IBAction func btnAcceptRequestClickAction(_ sender: Any) {
        self.counter = 15
        self.timer.invalidate()
        if(SocketIOManager.shared.socket.status == .connected){
            let BookingId = Int(self.newBookingResModel?.id ?? "0") ?? 0
            let BookingType = self.newBookingResModel?.bookingType ?? ""
            self.emitSocketAcceptBookingRequest(bookingId: BookingId, bookingType: BookingType)
        }
    }
    
    @IBAction func btnNoThanksTap(_ sender: UIButton) {
        self.delegate?.onNoThanksRequest()
    }
    
    @IBAction func btnCancelRideClickAction(_ sender: Any) {
        self.counter = 15
        self.timer.invalidate()
        if(SocketIOManager.shared.socket.status == .connected){
            let BookingId = self.newBookingResModel?.id ?? "0"
            self.emitSocket_forwardBookingRequestToAnotherDriver(bookingId: BookingId)
        }
        self.delegate?.onCancelRideRequest()
    }
    
    @IBAction func btnNavigateTap(_ sender: Any) {
        
    }
    
    @IBAction func btnSosTap(_ sender: Any) {
        
    }
    
}

fileprivate extension IncomingRideRequestView {
    
    func setupView() {
        
        self.lblName.text = ""
        self.lblName.font = UIFont.medium(ofSize: FontsSize.Regular)
        
        self.lblRatings.text = ""
        self.lblRatings.font = UIFont.regular(ofSize: FontsSize.Regular)
        
        self.lblDuration.text = ""
        self.lblDuration.font = UIFont.bold(ofSize: FontsSize.Medium)
        
        self.lblFare.text = ""
        self.lblFare.font = UIFont.regular(ofSize: FontsSize.Regular)
        
        self.lblDistance.text = ""
        self.lblDistance.font = UIFont.regular(ofSize: FontsSize.Regular)
        
        self.lblDropUpAddress.text = ""
        self.lblDropUpAddress.font = UIFont.regular(ofSize: FontsSize.ExtraSmall)
        
        self.lblPickUpAddress.text = ""
        self.lblPickUpAddress.font = UIFont.regular(ofSize: FontsSize.ExtraSmall)
        
        self.viewCount.backgroundColor = themeColorBlack.withAlphaComponent(0.2)
        
        self.lblCount.text = ""
        self.lblCount.font = UIFont.bold(ofSize: FontsSize.Tiny)
        self.lblCount.textColor = UIColor.white
        
        self.lblNoThanks.text = ConstantString.LABEL_TITLE_HOME_NO_THANKS
        self.lblNoThanks.font = UIFont.regular(ofSize: FontsSize.ExtraSmall)
        self.lblNoThanks.textColor = .white
        self.btnAcceptRequest.setTitle(ConstantString.BUTTON_TITLE_HOME_TAP_TO_ACCCEPT, for: .normal)
    }    
}

enum VerticalLocation: String {
    case bottom
    case top
}

extension UIView {
    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -10), color: color, opacity: opacity, radius: radius)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
