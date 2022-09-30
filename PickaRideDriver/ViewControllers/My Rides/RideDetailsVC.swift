//
//  RideDetailsVC.swift
//  PickaRideDriver
//
//  Created by Admin on 10/05/21.
//

import UIKit
import SDWebImage
import Cosmos
import GoogleMaps

protocol AcceptBookingReqDelgate {
    func onAcceptBookingReq()
}

class RideDetailsVC: BaseVC {
    
    //MARK: -IBActions
    @IBOutlet weak var stackviewRecieptBottom: NSLayoutConstraint!
    @IBOutlet weak var stackviewRecieptHeight: NSLayoutConstraint!
    @IBOutlet weak var vwMap: UIView!
    @IBOutlet weak var lblTime: RideDetailLabel!
    @IBOutlet weak var MyOfferView: UIView!
    @IBOutlet weak var lblRidigo: RideDetailLabel!
    @IBOutlet weak var lblPrice: RideDetailLabel!
    @IBOutlet weak var lblPickupLocation: RideDetailLabel!
    @IBOutlet weak var lblDestLocation: RideDetailLabel!
    @IBOutlet weak var imgProfilw: ProfileView!
    @IBOutlet weak var lblRideCustomerName: RideDetailLabel!
    @IBOutlet weak var btnRepeateRide: UIButton!
    @IBOutlet weak var ratingVw: CosmosView!
    @IBOutlet weak var btnAccept: themeButton!
    @IBOutlet weak var btnReject: CancelButton!
    @IBOutlet weak var imgStatus: UIImageView!
    lazy var mapView = GMSMapView(frame: .zero)
    
    //MARK: - Variables
    var isFromUpcomming : Bool = false
    var isFromPast : Bool = false
    var isFromInprogress : Bool = false
    var PastBookingData : PastBookingResDatum?
    var rideDeatilViewModel = RideDeatilViewModel()
    var delegate : AcceptBookingReqDelgate?
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareView()
        self.setupData()
    }
    
    //MARK: - Custom methods
    func prepareView(){
        self.setNavigationBarInViewController(controller: self, naviColor: colors.white.value, naviTitle: "Ride Details", leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        setMap()
        let BookingStatus = self.PastBookingData?.bookingInfo?.status?.rawValue ?? ""
        let BookingType = self.PastBookingData?.bookingInfo?.bookingType ?? ""
        
        if(self.isFromPast){
            self.btnAccept.isHidden = true
            self.btnReject.isHidden = true
            self.btnRepeateRide.isHidden = true
            if(BookingStatus == "canceled"){
                self.imgStatus.image = #imageLiteral(resourceName: "Cancel")
                self.stackviewRecieptHeight.constant = 0
            }else if(BookingStatus == "completed"){
                self.imgStatus.image = #imageLiteral(resourceName: "Completed")
                self.stackviewRecieptHeight.constant = 40
            }
            
            let timestamp: TimeInterval =  Double(self.PastBookingData?.bookingInfo?.acceptTime ?? "") ?? 0.0
            let date = Date(timeIntervalSince1970: timestamp)
            let formatedDate = date.timeAgoSinceDate(isForNotification: false)
            self.lblTime.text = formatedDate
            
        }else if(self.isFromInprogress){
            self.btnReject.setTitle("CANCEL", for: .normal)
            self.btnReject.isHidden = (BookingType == "book_later") ? true : false
            self.stackviewRecieptHeight.constant = (BookingType == "book_later") ? 0 : 40
            self.btnAccept.isHidden = true
            self.btnRepeateRide.isHidden = true
            self.imgStatus.image = #imageLiteral(resourceName: "OnGoing")
            
            let timestamp: TimeInterval =  Double(self.PastBookingData?.bookingInfo?.bookingTime ?? "") ?? 0.0
            let date = Date(timeIntervalSince1970: timestamp)
            let formatedDate = date.timeAgoSinceDate(isForNotification: false)
            self.lblTime.text = formatedDate
            
        }else{
            self.stackviewRecieptHeight.constant = 40
            self.btnAccept.isHidden = false
            if(BookingStatus == "accepted"){
                self.btnAccept.isHidden = true
                self.btnReject.isHidden = false
                self.btnReject.setTitle("CANCEL", for: .normal)
            }else{
                self.btnReject.isHidden = true
                self.btnAccept.isHidden = false
            }
            self.btnRepeateRide.isHidden = true
            self.imgStatus.image = #imageLiteral(resourceName: "Pending-Status")
            
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
            
            if(self.isFromPast){
                self.lblPrice.text = self.PastBookingData?.bookingInfo?.driverAmount?.toCurrencyString()
            }else if(self.isFromInprogress){
                self.lblPrice.text = self.PastBookingData?.bookingInfo?.estimatedFare?.toCurrencyString()
            }else{
                self.lblPrice.text = self.PastBookingData?.bookingInfo?.estimatedFare?.toCurrencyString()
            }
         
            self.lblPickupLocation.text = self.PastBookingData?.bookingInfo?.pickupLocation ?? ""
            self.lblDestLocation.text = self.PastBookingData?.bookingInfo?.dropoffLocation ?? ""
            
            let strUrl = "\(APIEnvironment.Profilebu.rawValue)" + "\(self.PastBookingData?.customerInfo?.profileImage ?? "")"
            let strURl = URL(string: strUrl)
            self.imgProfilw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgProfilw.sd_setImage(with: strURl, placeholderImage: UIImage(named: "nav_dummy_userImage"), options: .refreshCached, completed: nil)
            
            let custName = (self.PastBookingData?.customerInfo?.firstName ?? "")! + " " + (self.PastBookingData?.customerInfo?.lastName ?? "")!
            self.lblRideCustomerName.text = custName
            self.ratingVw.rating = Double(self.PastBookingData?.customerInfo?.rating ?? "0.0") ?? 0.0
            
            self.lblRidigo.text = custName
        }
    }
    
    func setMap() {
        guard let info = self.PastBookingData?.bookingInfo else {
            return
        }
        
        vwMap.addSubview(mapView)
        mapView.setAllSideContraints(.zero)
        guard let pickup = info.pickupCoordinate, let drop = info.dropOffCoordinate else {
            return
        }
        fetchRoute(pickup: pickup, drop: drop)
        let bounds = GMSCoordinateBounds(coordinate: pickup, coordinate: drop)
        let cameraWithPadding: GMSCameraUpdate = GMSCameraUpdate.fit(bounds, withPadding: 40.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.mapView.animate(with: cameraWithPadding)
            let pickUpMarker = GMSMarker(position: pickup)
            pickUpMarker.icon = UIImage(named: "iconCurrentLocPin")
            pickUpMarker.map = self.mapView
            let dropOffMarker = GMSMarker(position: drop)
            dropOffMarker.icon = GMSMarker.themeMarkerImage
            dropOffMarker.map = self.mapView
        }
    }
    
    func fetchRoute(pickup: CLLocationCoordinate2D, drop: CLLocationCoordinate2D) {
        
        let CurrentLatLong = "\(pickup.latitude),\(pickup.longitude)"
        let DestinationLatLong = "\(drop.latitude),\(drop.longitude)"
        let param = "origin=\(CurrentLatLong)&destination=\(DestinationLatLong)&mode=driving&key=\(AppInfo.Google_API_Key)"
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?\(param)")!
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]?,
                    let jsonResponse = jsonResult else {
                print("error in JSONSerialization")
                return
            }
            
            guard let status = jsonResponse["status"] as? String else {
                return
            }
            
            if(status == "REQUEST_DENIED" || status == "ZERO_RESULTS"){
                print("Map Error : \(jsonResponse["error_message"] as? String ?? "REQUEST_DENIED")")
                return
            }
            
            guard let routes = jsonResponse["routes"] as? [Any] else {
                return
            }
            
            guard let route = routes[0] as? [String: Any] else {
                return
            }
            
            // For polyline
            guard let overview_polyline = route["overview_polyline"] as? [String: Any] else {
                return
            }
            
            guard let polyLineString = overview_polyline["points"] as? String else {
                return
            }
            

            
            //Call this method to draw path on map
            DispatchQueue.main.async {
                self.drawPath(from: polyLineString)
            }
        })
        task.resume()
    }
    
    func drawPath(from polyStr: String){
        let path = GMSPath(fromEncodedPath: polyStr)!
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.strokeColor = UIColor.black
        polyline.map = self.mapView
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
        self.callAcceptBookingRideAPI(Id: self.PastBookingData?.bookingInfo?.id ?? "")
    }
    
    func popBack(){
        self.delegate?.onAcceptBookingReq()
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Button action methods
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


//MARK:- Api Calls
extension RideDetailsVC{
    
    func callAcceptBookingRideAPI(Id : String){
        self.rideDeatilViewModel.rideDetailsVC = self
        let reqModel = RidesRequestModel()
        reqModel.bookingId = Id
        self.rideDeatilViewModel.webserviceAcceptBookingRideAPI(reqModel: reqModel)
    }
}

extension GMSMarker {
   static var themeMarkerImage: UIImage {
        GMSMarker.markerImage(with: ThemeColorEnum.Theme.rawValue)
    }
}
