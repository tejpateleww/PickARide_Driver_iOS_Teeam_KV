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
    var strDutyStatusfromCurrentBooking = ""
    var CurrentLocLat:String = "0.0"
    var CurrentLocLong:String = "0.0"
    var CurrentLocMarker: GMSMarker?
    var homeViewModel = HomeViewModel()
    var timer : Timer?
    var newBookingResModel : NewBookingResBookingInfo?
    
    //MARK:- Life cycle methods
    override func viewWillAppear(_ animated: Bool) {
        self.SocketOnMethods()
        self.callCurrentBookingAPI()
        self.startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.allSocketOffMethods()
        if(self.timer != nil){
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.sos.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        self.handleRideFlow(state: RideState.None)
        
        self.PrepareView()
    }
    
    //MARK:- Custom methods
    func PrepareView(){
        self.checkMapPermission()
        
    }
    
    func startTimer() {
        if(self.timer == nil){
            self.timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (timer) in
                if  SocketIOManager.shared.socket.status == .connected {
                    self.emitSocket_UpdateLocation(latitute: appDel.locationManager.currentLocation?.coordinate.latitude ?? 0.0, long: appDel.locationManager.currentLocation?.coordinate.longitude ?? 0.0)
                    //self.emitSocket_forwardBookingRequestToAnotherDriver(bookingId: 0)
                }else{
                    print("socket not connected")
                }
            })
        }
    }
    
    func setupMap(){
        
        self.CurrentLocLat = String(appDel.locationManager.currentLocation?.coordinate.latitude ?? 0.0)
        self.CurrentLocLong = String(appDel.locationManager.currentLocation?.coordinate.longitude ?? 0.0)
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(self.CurrentLocLat) ?? 0.0, longitude:  Double(self.CurrentLocLong) ?? 0.0, zoom: 13.8)
        self.vwMap.camera = camera
        
        //Current Location pin setup
        self.CurrentLocMarker = GMSMarker()
        self.CurrentLocMarker?.position = CLLocationCoordinate2D(latitude: Double(self.CurrentLocLat) ?? 0.0, longitude: Double(self.CurrentLocLong) ?? 0.0)
        self.CurrentLocMarker?.snippet = "Your Location"
        
        let markerView2 = MarkerPinView()
        markerView2.markerImage = UIImage(named: "iconCurrentLocPin")?.withRenderingMode(.alwaysTemplate)
        markerView2.tintColor = themeColor
        markerView2.layoutSubviews()
        
        self.CurrentLocMarker?.iconView = markerView2
        self.CurrentLocMarker?.map = self.vwMap
        self.vwMap.selectedMarker = self.CurrentLocMarker
    }
    
    func checkMapPermission(){
        let LocationStatus = CLLocationManager.authorizationStatus()
        if LocationStatus == .notDetermined {
            appDel.locationManager.locationManager?.requestWhenInUseAuthorization()
        }else if LocationStatus == .restricted || LocationStatus == .denied {
            Utilities.showAlertWithTitleFromVC(vc: self, title: AppName, message: "Please turn on permission from settings, to track location in app.", buttons: ["Cancel","Settings"], isOkRed: false) { (ind) in
                if ind == 0{
                
                }else{
                    if let settingsAppURL = URL(string: UIApplication.openSettingsURLString){
                        UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
                    }
                }
            }
        }else{
            self.setupMap()
        }
    }
    
    func changeDutyStatus(){
        self.lblOffline.text = self.strDutyStatus
        self.btnOn.isSelected = (self.lblOffline.text == "You're online") ? true : false
    }
    
    func changeDutyStatusBasedOnCurrentBooking(){
        if(self.strDutyStatusfromCurrentBooking == "0"){
            self.lblOffline.text = "You're offline"
        }else{
            self.lblOffline.text = "You're online"
        }
        self.btnOn.isSelected = (self.lblOffline.text == "You're online") ? true : false
    }
    
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
            
        }else if (state == RideState.NewRequest){
            
            self.incomingRideRequestView.isHidden = false
            self.acceptedRideDetailsView.isHidden = true
            self.cancelRideView.isHidden = true
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
                self.acceptedRideDetailsView.isCompleted()
            }
            self.cancelRideView.YesCancelClosure = {
                self.acceptedRideDetailsView.completeTap()
            }
            
            self.acceptedRideDetailsView.setRideDetails()
            
        }else if (state == RideState.CancelAcceptedRide){
            
            self.incomingRideRequestView.isHidden = true
            self.acceptedRideDetailsView.isHidden = true
            self.cancelRideView.isHidden = false
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

//MARK:- Api Call
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
}

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
}

extension HomeVC : AcceptedRideDetailsViewDelgate{
    
    func onArrivedUserLocation() {
        self.handleRideFlow(state: RideState.None)
        let vc : RatingAndReviewVC = RatingAndReviewVC.instantiate(fromAppStoryboard: .Main)
        vc.modalPresentationStyle = .overFullScreen
        vc.reviewBtnTapClosure = {
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.sos.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
            self.btnOn.isHidden = false
            self.lblOffline.text = "You're offline"
        }
        vc.btnDoneTapClosure = {
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.sos.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
            self.btnOn.isHidden = false
            self.lblOffline.text = "You're offline"
        }
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    
    func onCancelAcceptedRideRequest() {
        self.handleRideFlow(state: RideState.CancelAcceptedRide)
        self.btnOn.isHidden = false
    }
    
    func onChatRideRequest() {
        let vc : ChatViewController = ChatViewController.instantiate(fromAppStoryboard: .Chat)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func onCallRideRequest() {
        guard let number = URL(string: "tel://" + "0123456789") else { return }
        UIApplication.shared.open(number)
    }
}

extension HomeVC : CancelRideViewDelgate{
    
    func onRideCanelDecision(decision: Int)
    {
        if (decision == 1) //Yes
        {
            let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: CancelRideVC.storyboardID) as! CancelRideVC
            controller.doneCancelClosure = {
                self.isCloseTap = true
            }
            controller.cancelReqClosure = {
                self.handleRideFlow(state: RideState.None)
            }
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
