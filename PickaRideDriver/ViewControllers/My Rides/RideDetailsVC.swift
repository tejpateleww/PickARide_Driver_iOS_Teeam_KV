//
//  RideDetailsVC.swift
//  PickaRideDriver
//
//  Created by Admin on 10/05/21.
//

import UIKit
import SDWebImage
import Cosmos

class RideDetailsVC: BaseVC {
    
    //MARK: -IBActions
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
    @IBOutlet weak var btnRepeateRide: UIButton!
    @IBOutlet weak var btnReceipt: RidesDetailsButton!
    @IBOutlet weak var ratingVw: CosmosView!
    @IBOutlet weak var btnAccept: themeButton!
    @IBOutlet weak var btnReject: CancelButton!
    @IBOutlet weak var imgStatus: UIImageView!
    
    //MARK: - Variables
    var isFromUpcomming : Bool = false
    var isFromPast : Bool = false
    var isFromInprogress : Bool = false
    var PastBookingData : PastBookingResDatum?
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareView()
        self.setupData()
    }
    
    //MARK: - Custom methods
    func prepareView(){
        self.setNavigationBarInViewController(controller: self, naviColor: colors.white.value, naviTitle: "Ride Details", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        
        let BookingStatus = self.PastBookingData?.bookingInfo?.status ?? ""
        
        if(self.isFromPast){
            self.btnAccept.isHidden = true
            self.btnReject.isHidden = true
            self.btnRepeateRide.isHidden = true
            if(BookingStatus == "canceled"){
                self.imgStatus.image = #imageLiteral(resourceName: "Cancel")
                self.btnReceipt.isHidden = true
                self.stackviewRecieptHeight.constant = 0
            }else if(BookingStatus == "completed"){
                self.imgStatus.image = #imageLiteral(resourceName: "Completed")
                self.btnReceipt.isHidden = false
                self.stackviewRecieptHeight.constant = 40
            }
            
            let timestamp: TimeInterval =  Double(self.PastBookingData?.bookingInfo?.acceptTime ?? "") ?? 0.0
            let date = Date(timeIntervalSince1970: timestamp)
            let formatedDate = date.timeAgoSinceDate(isForNotification: false)
            self.lblTime.text = formatedDate
            
        }else if(self.isFromInprogress){
            self.btnReject.setTitle("CANCEL", for: .normal)
            self.btnReject.isHidden = false
            self.btnReceipt.isHidden = true
            self.btnAccept.isHidden = true
            self.btnRepeateRide.isHidden = true
            self.imgStatus.image = #imageLiteral(resourceName: "OnGoing")
            
            let timestamp: TimeInterval =  Double(self.PastBookingData?.bookingInfo?.bookingTime ?? "") ?? 0.0
            let date = Date(timeIntervalSince1970: timestamp)
            let formatedDate = date.timeAgoSinceDate(isForNotification: false)
            self.lblTime.text = formatedDate
            
        }else{
            self.btnAccept.isHidden = false
            self.btnReject.isHidden = false
            self.btnReceipt.isHidden = true
            self.btnRepeateRide.isHidden = true
            self.imgStatus.image = #imageLiteral(resourceName: "Pending")
            
            let timestamp: TimeInterval =  Double(self.PastBookingData?.bookingInfo?.pickupDateTime ?? "") ?? 0.0
            let date = Date(timeIntervalSince1970: timestamp)
            let formatedDate = date.timeAgoSinceDate(isForNotification: false)
            self.lblTime.text = formatedDate
        }
        
        self.shadowView(view: MyOfferView)
        self.MyOfferView.layer.cornerRadius = 4
        self.ratingVw.isUserInteractionEnabled = false
    }
    
    func setupData(){
        if(self.PastBookingData != nil){
            
            if(isFromUpcomming){
                self.lblRidigo.text = "\(self.PastBookingData?.bookingInfo?.vehicleName ?? "")"
                self.lblCarName.text = ""
            }else{
                self.lblRidigo.text = "\(self.PastBookingData?.bookingInfo?.vehicleName ?? "")(\(self.PastBookingData?.driverVehicleInfo?.plateNumber ?? "")"
                self.lblCarName.text = " - \(self.PastBookingData?.driverVehicleInfo?.vehicleTypeManufacturerName ?? "") \(self.PastBookingData?.driverVehicleInfo?.vehicleTypeModelName ?? ""))"
            }
            
            self.lblPrice.text = "$\(self.PastBookingData?.bookingInfo?.driverAmount ?? "0")"
            self.lblAddress.text = self.PastBookingData?.bookingInfo?.pickupLocation ?? ""
            self.lblPickupLocation.text = self.PastBookingData?.bookingInfo?.pickupLocation ?? ""
            self.lblDestLocation.text = self.PastBookingData?.bookingInfo?.dropoffLocation ?? ""
            
            
            let strUrl = "\(APIEnvironment.Profilebu.rawValue)" + "\(self.PastBookingData?.customerInfo?.profileImage ?? "")"
            let strURl = URL(string: strUrl)
            self.imgProfilw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgProfilw.sd_setImage(with: strURl, placeholderImage: UIImage(named: "nav_dummy_userImage"), options: .refreshCached, completed: nil)
            
            let custName = (self.PastBookingData?.customerInfo?.firstName ?? "")! + " " + (self.PastBookingData?.customerInfo?.lastName ?? "")!
            self.lblRideCustomerName.text = custName
            self.ratingVw.rating = Double(self.PastBookingData?.customerInfo?.rating ?? "0.0") ?? 0.0
        }
    }
    
    func shadowView(view : UIView){
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 4
    }
    
    func cancelRide() {
        NotificationCenter.default.post(name: Notification.Name("CancelTripFromDetail"), object: nil)
        self.navigationController?.popToViewController(ofClass: HomeVC.self)
    }
    
    func rejectRide() {
        print("reject ride..")
    }
    
    func acceptRide() {
        print("accept ride..")
    }
    
    //MARK: - Button action methods
    @IBAction func btnReceiptTap(_ sender: Any) {
        let vc : RideReceiptDetailsVC = RideReceiptDetailsVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnRepeatRideTap(_ sender: Any) {
    }
    
    @IBAction func btnHelpTap(_ sender: Any) {
    }
    
    @IBAction func btnAcceptAction(_ sender: Any) {
        self.acceptRide()
    }
    
    @IBAction func btnRejectAction(_ sender: Any) {
        if(self.isFromInprogress){self.cancelRide()}else{self.rejectRide()}
    }
    
}

