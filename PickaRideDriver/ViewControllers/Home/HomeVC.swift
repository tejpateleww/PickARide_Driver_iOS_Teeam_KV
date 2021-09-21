//
//  HomeVC.swift
//  PickaRideDriver
//
//  Created by Admin on 08/05/21.
//

import UIKit
import GoogleMaps
import SocketIO

class HomeVC: BaseVC {
    
    //MARK:- IBOutlets
    @IBOutlet weak var vwMap: GMSMapView!
    @IBOutlet weak var btnOn: UIButton!
    @IBOutlet weak var lblOffline: themeLabel!
    
    //MARK:- Variables
    lazy var incomingRideRequestView : IncomingRideRequestView = IncomingRideRequestView.fromNib()
    lazy var acceptedRideDetailsView : AcceptedRideDetailsView = AcceptedRideDetailsView.fromNib()
    lazy var cancelRideView : CancelRideView = CancelRideView.fromNib()
    
    var isCloseTap = false
    var strDutyStatus = ""
    var strArrivedOtp = ""
    var strDutyStatusfromCurrentBooking = ""
    var CurrentLocLat:String = "0.0"
    var CurrentLocLong:String = "0.0"
    var PickLocLat:String = "0.0"
    var PickLocLong:String = "0.0"
    var CurrentLocMarker: GMSMarker?
    var DropLocMarker: GMSMarker?
    var arrMarkers: [GMSMarker] = []
    var homeViewModel = HomeViewModel()
    var timer : Timer?
    var newBookingResModel : NewBookingResBookingInfo?
    var currentBookingModel : CurrentBookingDatum?
    
    //MARK:- Life cycle methods
    override func viewWillAppear(_ animated: Bool) {
        self.SocketOnMethods()
        self.startTimer()
        self.changeDutyStatus()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.allSocketOffMethods()
        if(self.timer != nil){
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.callCurrentBookingAPI()
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.sos.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        self.handleRideFlow(state: RideState.None)
        self.PrepareView()
    }
    
    //MARK:- Custom methods
    func PrepareView(){
        self.checkMapPermission()
    }
    
    func checkMapPermission(){
        let LocationStatus = CLLocationManager.authorizationStatus()
        if LocationStatus == .notDetermined {
            appDel.locationManager.locationManager?.requestWhenInUseAuthorization()
        }else if LocationStatus == .restricted || LocationStatus == .denied {
            Utilities.showAlertWithTitleFromVC(vc: self, title: AppName, message: "Please turn on permission from settings, to track location in app.", buttons: ["Cancel","Settings"], isOkRed: false) { (ind) in
                if ind == 1{
                    if let settingsAppURL = URL(string: UIApplication.openSettingsURLString){
                        UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
                    }
                }
            }
        }else{
            self.setupMap()
        }
    }
    
    func setupMap(){
        self.vwMap.clear()
        
        let mapInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.vwMap.padding = mapInsets
        
        self.CurrentLocLat = String(appDel.locationManager.currentLocation?.coordinate.latitude ?? 0.0)
        self.CurrentLocLong = String(appDel.locationManager.currentLocation?.coordinate.longitude ?? 0.0)
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(self.CurrentLocLat) ?? 0.0, longitude:  Double(self.CurrentLocLong) ?? 0.0, zoom: 13.8)
        self.vwMap.camera = camera
        
        //Current Location pin setup
        self.CurrentLocMarker = GMSMarker()
        self.CurrentLocMarker?.position = CLLocationCoordinate2D(latitude: Double(self.CurrentLocLat) ?? 0.0, longitude: Double(self.CurrentLocLong) ?? 0.0)
        self.CurrentLocMarker?.snippet = "Your Location"
        
        let markerView2 = MarkerPinView()
        markerView2.markerImage = UIImage(named: "iconCurrentLocPin")
        markerView2.layoutSubviews()
        
        self.CurrentLocMarker?.iconView = markerView2
        self.CurrentLocMarker?.map = self.vwMap
        self.vwMap.selectedMarker = self.CurrentLocMarker
    }
    
    func startTimer() {
        self.emitSocket_UpdateLocation(latitute: appDel.locationManager.currentLocation?.coordinate.latitude ?? 0.0, long: appDel.locationManager.currentLocation?.coordinate.longitude ?? 0.0)
        if(self.timer == nil){
            self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                if  SocketIOManager.shared.socket.status == .connected {
                    self.emitSocket_UpdateLocation(latitute: appDel.locationManager.currentLocation?.coordinate.latitude ?? 0.0, long: appDel.locationManager.currentLocation?.coordinate.longitude ?? 0.0)
                }else{
                    print("socket not connected")
                    Utilities.displayAlert(UrlConstant.SomethingWentWrong)
                }
            })
        }
    }
    
    func checkForCurrentBooking(){
        if(self.currentBookingModel != nil){
            let currentStatus = self.currentBookingModel?.status ?? ""
            if(currentStatus == "accepted"){
                self.handleRideFlow(state: RideState.RequestAccepted)
                self.btnOn.isHidden = true
                self.setupPickupRoute()
            }else if(currentStatus == "traveling"){
                self.handleRideFlow(state: RideState.StartRide)
                self.btnOn.isHidden = true
                self.setupPickupRoute()
            }else{
                self.handleRideFlow(state: RideState.None)
                self.setupMap()
            }
        }
    }
    
    func openReviewScreen(){
        self.vwMap.clear()
        self.setupMap()
        self.handleRideFlow(state: RideState.None)
        
        let vc : RatingAndReviewVC = RatingAndReviewVC.instantiate(fromAppStoryboard: .Main)
        vc.modalPresentationStyle = .overFullScreen
        vc.currentBookingModel = self.currentBookingModel
        vc.delegate = self
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    
    //MARK:- changeDutyStatus methods
    func changeDutyStatus(){
        if(SingletonClass.sharedInstance.UserProfilData?.duty == "0"){
            self.strDutyStatus = "You're offline"
        }else{
            self.strDutyStatus = "You're online"
        }
        self.lblOffline.text = self.strDutyStatus
        self.btnOn.isSelected = (self.lblOffline.text == "You're online") ? true : false
    }
    
    func changeDutyStatusBasedOnCurrentBooking(){
        if(self.strDutyStatusfromCurrentBooking == "0" || self.strDutyStatusfromCurrentBooking == "offline"){
            self.lblOffline.text = "You're offline"
        }else{
            self.lblOffline.text = "You're online"
        }
        self.btnOn.isSelected = (self.lblOffline.text == "You're online") ? true : false
    }
    
    //MARK:- Setup Route methods
    func setupPickupRoute(){
        self.vwMap.clear()
        
        self.CurrentLocLat = String(appDel.locationManager.currentLocation?.coordinate.latitude ?? 0.0)
        self.CurrentLocLong = String(appDel.locationManager.currentLocation?.coordinate.longitude ?? 0.0)
        self.PickLocLat =  (self.currentBookingModel?.status == "traveling") ? self.currentBookingModel?.dropoffLat ?? "0.0" : self.currentBookingModel?.pickupLat ?? "0.0"
        self.PickLocLong = (self.currentBookingModel?.status == "traveling") ? self.currentBookingModel?.dropoffLng ?? "0.0" : self.currentBookingModel?.pickupLng ?? "0.0"
        
        self.MapSetup(currentlat: CurrentLocLat, currentlong: CurrentLocLong, droplat: PickLocLat, droplog: PickLocLong)
    }
    
    func MapSetup(currentlat: String, currentlong:String, droplat: String, droplog:String)
    {
        let mapInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 300.0, right: 0.0)
        self.vwMap.padding = mapInsets
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(currentlat) ?? 0.0, longitude:  Double(currentlong) ?? 0.0, zoom: 13.8)
        self.vwMap.camera = camera
        
        //Drop Location pin setup
        self.DropLocMarker = GMSMarker()
        self.DropLocMarker?.position = CLLocationCoordinate2D(latitude: Double(droplat) ?? 0.0, longitude: Double(droplog) ?? 0.0)
        self.DropLocMarker?.snippet = (self.currentBookingModel?.status == "traveling") ? self.currentBookingModel?.dropoffLocation ?? "Drop Location" : self.currentBookingModel?.pickupLocation ?? "PickUp Location"
        
        let markerView = MarkerPinView()
        markerView.markerImage = UIImage(named: "iconDropLocPin")
        markerView.layoutSubviews()
        
        self.DropLocMarker?.iconView = markerView
        self.DropLocMarker?.map = self.vwMap
        
        //Current Location pin setup
        self.CurrentLocMarker = GMSMarker()
        self.CurrentLocMarker?.position = CLLocationCoordinate2D(latitude: Double(currentlat) ?? 0.0, longitude: Double(currentlong) ?? 0.0)
        self.CurrentLocMarker?.snippet = "Your Location"
        
        let markerView2 = MarkerPinView()
        markerView2.markerImage = UIImage(named: "iconCurrentLocPin")
        markerView2.layoutSubviews()
        
        self.CurrentLocMarker?.iconView = markerView2
        self.CurrentLocMarker?.map = self.vwMap
        self.vwMap.selectedMarker = self.CurrentLocMarker
        
        //For Displaying both markers in screen centered
        self.arrMarkers.append(self.CurrentLocMarker!)
        self.arrMarkers.append(self.DropLocMarker!)
        var bounds = GMSCoordinateBounds()
        for marker in self.arrMarkers
        {
            bounds = bounds.includingCoordinate(marker.position)
        }
        let update = GMSCameraUpdate.fit(bounds, withPadding: 80)
        self.vwMap.animate(with: update)
        
        self.fetchRoute(currentlat: currentlat, currentlong: currentlong, droplat: droplat, droplog: droplog)
    }
    
    func fetchRoute(currentlat: String, currentlong:String, droplat: String, droplog:String) {
        
        let CurrentLatLong = "\(currentlat),\(currentlong)"
        let DestinationLatLong = "\(droplat),\(droplog)"
        let param = "origin=\(CurrentLatLong)&destination=\(DestinationLatLong)&mode=driving&key=\(AppInfo.Google_API_Key)"
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?\(param)")!
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]?, let jsonResponse = jsonResult else {
                print("error in JSONSerialization")
                return
            }
            
            guard let routes = jsonResponse["routes"] as? [Any] else {
                return
            }
            
            guard let route = routes[0] as? [String: Any] else {
                return
            }
            
            guard let overview_polyline = route["overview_polyline"] as? [String: Any] else {
                return
            }
            
            guard let polyLineString = overview_polyline["points"] as? String else {
                return
            }
            
            //Call this method to draw path on map
            self.drawPath(from: polyLineString)
        })
        task.resume()
    }
    
    func drawPath(from polyStr: String){
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.strokeColor = UIColor.black
        polyline.map = self.vwMap
    }
    
    //MARK: - open GoogleMap Path Methods
    func openGoogleMap()
    {
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL))
        {
            if(self.CurrentLocLat == "0.0" && self.CurrentLocLong == "0.0")
            {
                UIApplication.shared.open((NSURL(string:
                                                    "https://maps.google.com/maps?saddr=&daddr=\(self.PickLocLat),\(self.PickLocLong)")! as URL), options: [:], completionHandler: nil)
            }
            else
            {
                UIApplication.shared.open((NSURL(string:
                                                    "https://maps.google.com/maps?saddr=\(self.CurrentLocLat),\(self.CurrentLocLong)&daddr=\(self.PickLocLat),\(self.PickLocLong)")! as URL), options: [:], completionHandler: nil)
            }
        }
        else
        {
            NSLog("Can't use comgooglemaps://");
            if(self.CurrentLocLat == "0.0" && self.CurrentLocLong == "0.0")
            {
                UIApplication.shared.open((NSURL(string:
                                                    "https://maps.google.com/maps?saddr=&daddr=\(self.PickLocLat),\(self.PickLocLong)")! as URL), options: [:], completionHandler: nil)
            }
            else
            {
                UIApplication.shared.open((NSURL(string:
                                                    "https://maps.google.com/maps?saddr=\(self.CurrentLocLat),\(self.CurrentLocLong)&daddr=\(self.PickLocLat),\(self.PickLocLong)")! as URL), options: [:], completionHandler: nil)
            }
        }
    }
    
    //MARK:- handleRideFlow methods
    func handleRideFlow(state : Int) {
        
        if (state == RideState.None){
            
            self.incomingRideRequestView.delegate = self
            self.incomingRideRequestView.isUserInteractionEnabled = true
            self.incomingRideRequestView.frame = self.view.frame
            self.incomingRideRequestView.removeFromSuperview()
            self.view.addSubview(self.incomingRideRequestView)
            
            self.acceptedRideDetailsView.delegate = self
            self.acceptedRideDetailsView.isUserInteractionEnabled = true
            self.acceptedRideDetailsView.frame = self.view.frame
            self.acceptedRideDetailsView.removeFromSuperview()
            self.view.addSubview(self.acceptedRideDetailsView)
            
            self.cancelRideView.delegate = self
            self.cancelRideView.isUserInteractionEnabled = true
            self.cancelRideView.frame = self.view.frame
            self.cancelRideView.removeFromSuperview()
            self.view.addSubview(self.cancelRideView)
            
            self.incomingRideRequestView.isHidden = true
            self.acceptedRideDetailsView.isHidden = true
            self.cancelRideView.isHidden = true
            
            self.btnOn.isHidden = false
            
        }else if (state == RideState.NewRequest){
            
            self.incomingRideRequestView.isHidden = false
            self.acceptedRideDetailsView.isHidden = true
            self.cancelRideView.isHidden = true
            //Btn_On/Off
            self.btnOn.isHidden = true
            //Btn_On/Off
            self.incomingRideRequestView.newBookingResModel = self.newBookingResModel
            self.incomingRideRequestView.setRideDetails()
            
        }else if (state == RideState.RequestAccepted){
            
            self.incomingRideRequestView.isHidden = true
            self.acceptedRideDetailsView.isHidden = false
            self.cancelRideView.isHidden = true
            self.cancelRideView.noCancelClosure = {
                if self.isCloseTap{
                    self.acceptedRideDetailsView.isNoTapFromCancelRide = true
                }
                //self.acceptedRideDetailsView.isCompleted()
            }
            self.cancelRideView.YesCancelClosure = {
                //self.acceptedRideDetailsView.completeTap()
            }
            self.acceptedRideDetailsView.currentBookingModel = self.currentBookingModel
            self.acceptedRideDetailsView.setRideDetails()
            
        }else if (state == RideState.StartRide){
            self.incomingRideRequestView.isHidden = true
            self.acceptedRideDetailsView.isHidden = false
            self.cancelRideView.isHidden = true
            self.cancelRideView.noCancelClosure = {
                if self.isCloseTap{
                    self.acceptedRideDetailsView.isNoTapFromCancelRide = true
                }
                //self.acceptedRideDetailsView.isCompleted()
            }
            self.cancelRideView.YesCancelClosure = {
                //self.acceptedRideDetailsView.completeTap()
            }
            
            self.acceptedRideDetailsView.currentBookingModel = self.currentBookingModel
            self.acceptedRideDetailsView.setRideDetailsForTripStart()
        }else if (state == RideState.CancelAcceptedRide){
            
            self.incomingRideRequestView.isHidden = true
            self.acceptedRideDetailsView.isHidden = true
            self.cancelRideView.isHidden = false
            self.cancelRideView.currentBookingModel = self.currentBookingModel
            self.cancelRideView.setRideDetails()
        }
    }
    
    //MARK:- Button action methods
    @IBAction func btnOnClick(_ sender: UIButton){
        self.callChangeDutyStatusAPI()
    }
    
    @IBAction func btnReCenterAction(_ sender: Any) {
        let camera = GMSCameraPosition.camera(withLatitude: Double(self.CurrentLocLat) ?? 0.0, longitude:  Double(self.CurrentLocLong) ?? 0.0, zoom: 13.8)
        self.vwMap.camera = camera
    }
    
}

//MARK:- Api Calls
extension HomeVC{
    
    func callChangeDutyStatusAPI(){
        self.homeViewModel.homeVC = self
        
        let DutyReq = ChangeDutyStatusReqModel()
        DutyReq.lat = String(appDel.locationManager.currentLocation?.coordinate.latitude ?? 0.0)
        DutyReq.lng = String(appDel.locationManager.currentLocation?.coordinate.longitude ?? 0.0)
        
        self.homeViewModel.webserviceChangeDutyStatusAPI(reqModel: DutyReq)
    }
    
    func callCurrentBookingAPI(){
        self.homeViewModel.homeVC = self
        self.homeViewModel.webserviceGetCurrentBookingAPI()
    }
    
    func CompleteTripAPI(){
        self.homeViewModel.homeVC = self
        
        let CompleteTripReq = CompleteTripReqModel()
        CompleteTripReq.bookingId = self.currentBookingModel?.id ?? ""
        CompleteTripReq.lat = self.currentBookingModel?.dropoffLat ?? "0.0"
        CompleteTripReq.lng = self.currentBookingModel?.dropoffLng ?? "0.0"
        
        self.homeViewModel.webserviceCompBookingAPI(reqModel: CompleteTripReq)
    }
    
    func verifyCustomerAPI(){
        self.homeViewModel.homeVC = self
        
        let verifyCustomerReqModel = VerifyCustomerReqModel()
        verifyCustomerReqModel.bookingId = self.currentBookingModel?.id ?? ""
        verifyCustomerReqModel.customerId = self.currentBookingModel?.customerInfo?.id ?? "0"
        
        self.homeViewModel.webserviceVerifyCustomerAPI(reqModel: verifyCustomerReqModel)
    }
    
    func callCancelBookingAPI(strReason : String){
        self.homeViewModel.homeVC = self
        
        let cancelBookingReqModel = CancelBookingReqModel()
        cancelBookingReqModel.bookingId = self.currentBookingModel?.id ?? ""
        cancelBookingReqModel.cancelReason = strReason
        
        self.homeViewModel.webserviceCancelBookingAPI(reqModel: cancelBookingReqModel)
    }
}

//MARK:- HomeNavigationBarDelegate
extension HomeVC : HomeNavigationBarDelegate{
    func onClosePopup() {
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.sos.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
}

//MARK:- IncomingRideRequestViewDelegate
extension HomeVC : IncomingRideRequestViewDelegate{
    
    func onCancelRideRequest() {
        self.btnOn.isHidden = false
        self.incomingRideRequestView.isHidden = true
    }
    
    func onNoThanksRequest(){
        self.handleRideFlow(state: RideState.None)
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.sos.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        self.btnOn.isHidden = false
    }
    
    func onAcceptRideRequest() {
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        self.handleRideFlow(state: RideState.RequestAccepted)
    }
    
    func onCurrentBookingAPI() {
        self.callCurrentBookingAPI()
    }
}

//MARK:- AcceptedRideDetailsViewDelgate
extension HomeVC : AcceptedRideDetailsViewDelgate{
    
    func onArrivedUserLocation() {
        self.verifyCustomerAPI()
    }
    
    func onCancelAcceptedRideRequest() {
        self.handleRideFlow(state: RideState.CancelAcceptedRide)
        self.btnOn.isHidden = false
    }
    
    func onChatRideRequest() {
        let vc : ChatViewController = ChatViewController.instantiate(fromAppStoryboard: .Chat)
        vc.currentBookingModel = self.currentBookingModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func onCallRideRequest() {
        guard let number = URL(string: "tel://" + "\(self.currentBookingModel?.customerInfo?.mobileNo ?? "123456789")") else { return }
        UIApplication.shared.open(number)
    }
    
    func onNavigateAction() {
        self.openGoogleMap()
    }
    
    func onVerifyOtpTap(StrCustOtp: String) -> Bool {
        if(self.strArrivedOtp == StrCustOtp.replacingOccurrences(of: "  ", with: "")){
            if  SocketIOManager.shared.socket.status == .connected {
                self.emitSocket_startTrip(bookingId: self.currentBookingModel?.id ?? "")
            }else{
                Toast.show(title: UrlConstant.Failed, message: "Socket Offline", state: .failure)
            }
            return true
        }else{
            Toast.show(title: UrlConstant.Failed, message: "Please enter correct otp", state: .failure)
            return false
        }
    }
    
    func onTripCompAction() {
        self.CompleteTripAPI()
    }
    
}

//MARK:- CancelRideViewDelgate
extension HomeVC : CancelRideViewDelgate{
    
    func onRideCanelDecision(decision: Int)
    {
        if (decision == 1) //Yes
        {
            let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: CancelRideVC.storyboardID) as! CancelRideVC
            controller.delegate = self
            self.navigationController?.pushViewController(controller, animated: true)
        }else //No
        {
            handleRideFlow(state: RideState.RequestAccepted)
        }
    }
    
    func onSubmitCancelReason()
    {
        handleRideFlow(state: RideState.None)
    }
}

//MARK:- IncomingRideRequestViewDelegate
extension HomeVC : CancelTripReasonDelgate{
    func onCancelTripReject() {
        self.isCloseTap = true
    }
    
    func onCancelTripConfirm(strReason: String) {
        print(strReason)
        self.callCancelBookingAPI(strReason: strReason)
    }
}
