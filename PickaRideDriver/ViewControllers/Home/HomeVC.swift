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
    var DriverLocMarker: GMSMarker?
    var arrMarkers: [GMSMarker] = []
    var homeViewModel = HomeViewModel()
    var timer : Timer?
    var newBookingResModel : NewBookingResBookingInfo?
    var currentBookingModel : CurrentBookingDatum?
    
    var moveMent: ARCarMovement?
    var oldCoordinate: CLLocationCoordinate2D!
    var path = GMSPath()
    var polyline : GMSPolyline!
    
    var index = 0
    var timerMap : Timer?
    
    var oldPoint:CLLocation!
    var newPoint:CLLocation!
    var coordinates : [CLLocation] = []
    
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
        self.setNavWithSOS()
        self.handleRideFlow(state: RideState.None)
        self.PrepareView()
    }
    
    //MARK:- Custom methods
    func PrepareView(){
        self.checkMapPermission()
        self.addNotificationObs()
        
        self.moveMent = ARCarMovement()
        self.moveMent?.delegate = self
        
    }
    
    func addNotificationObs(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.onCancelAcceptedRideRequest), name: Notification.Name("CancelTripFromDetail"), object: nil)
    }
    
    func setNavWithSOS(){
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.sos.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    
    func setNavWithoutSOS(){
        self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
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
        self.path = GMSPath()
        self.polyline = GMSPolyline()
        
        let mapInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.vwMap.padding = mapInsets
        
        self.CurrentLocLat = String(appDel.locationManager.currentLocation?.coordinate.latitude ?? 0.0)
        self.CurrentLocLong = String(appDel.locationManager.currentLocation?.coordinate.longitude ?? 0.0)
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(self.CurrentLocLat) ?? 0.0, longitude:  Double(self.CurrentLocLong) ?? 0.0, zoom: 13.6)
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
                    Utilities.displayAlert(UrlConstant.SomethingWentWrongSocket)
                }
            })
        }
    }
    
    func checkForCurrentBooking(){
        if(self.currentBookingModel != nil){
            let currentStatus = self.currentBookingModel?.status ?? ""
            if(currentStatus == "accepted"){
                self.setNavWithoutSOS()
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
        self.path = GMSPath()
        self.polyline = GMSPolyline()
        
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
            user_defaults.set("0", forKey: UserDefaultsKey.dutyStatus.rawValue)
            SingletonClass.sharedInstance.UserProfilData?.duty = "0"
        }else{
            self.lblOffline.text = "You're online"
            user_defaults.set("1", forKey: UserDefaultsKey.DeviceToken.rawValue)
            SingletonClass.sharedInstance.UserProfilData?.duty = "1"
        }
        self.btnOn.isSelected = (self.lblOffline.text == "You're online") ? true : false
    }
    
    //MARK:- Setup Route methods
    func setupPickupRoute(){
        self.vwMap.clear()
        self.path = GMSPath()
        self.polyline = GMSPolyline()
        
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
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(currentlat) ?? 0.0, longitude:  Double(currentlong) ?? 0.0, zoom: 13.6)
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
        self.DriverLocMarker = GMSMarker()
        self.DriverLocMarker?.position = CLLocationCoordinate2D(latitude: Double(currentlat) ?? 0.0, longitude: Double(currentlong) ?? 0.0)
        self.DriverLocMarker?.snippet = "Your Location"
        
        let markerView2 = MarkerPinView()
        markerView2.markerImage = UIImage(named: "car")
        markerView2.layoutSubviews()
        
        self.DriverLocMarker?.iconView = markerView2
        self.DriverLocMarker?.map = self.vwMap
        self.vwMap.selectedMarker = self.DropLocMarker
        
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
        self.path = GMSPath(fromEncodedPath: polyStr)!
        self.polyline = GMSPolyline(path: path)
        self.polyline.strokeWidth = 3.0
        self.polyline.strokeColor = UIColor.black
        self.polyline.map = self.vwMap
    }
    
    func setupTrackingMarker(){
        SingletonClass.sharedInstance.latitude = appDel.locationManager.currentLocation?.coordinate.latitude ?? 0.0
        SingletonClass.sharedInstance.longitude = appDel.locationManager.currentLocation?.coordinate.longitude ?? 0.0
        if(self.oldCoordinate == nil){
            self.oldCoordinate = CLLocationCoordinate2DMake(SingletonClass.sharedInstance.latitude, SingletonClass.sharedInstance.longitude)
        }
        if(self.DriverLocMarker == nil){
            self.DriverLocMarker = GMSMarker(position: self.oldCoordinate)
            self.DriverLocMarker?.icon = UIImage(named: "car")
            self.DriverLocMarker?.map = self.vwMap
        }
        let newCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(SingletonClass.sharedInstance.latitude), CLLocationDegrees(SingletonClass.sharedInstance.longitude))
        self.moveMent?.arCarMovement(marker: self.DriverLocMarker!, oldCoordinate: self.oldCoordinate, newCoordinate: newCoordinate, mapView: self.vwMap, bearing: Float(0))
        self.oldCoordinate = newCoordinate
        
        let camera = GMSCameraPosition.camera(withLatitude: newCoordinate.latitude, longitude: newCoordinate.longitude, zoom: 17)
        self.vwMap.animate(to: camera)
        
        
        let userLocation = CLLocation(latitude: SingletonClass.sharedInstance.latitude.rounded(toPlaces: 5), longitude: SingletonClass.sharedInstance.longitude.rounded(toPlaces: 5))
        let closest = self.coordinates.min(by:{ $0.distance(from: userLocation) < $1.distance(from: userLocation) })
        let Meters = closest?.distance(from: userLocation) ?? 0
        print("Distance from closest point---------- \(Meters.rounded(toPlaces: 2)) meters")
        if(Meters > 300){
            print("New route ---***---***---**--**--**--**----*****")
            self.setupPickupRoute()
            return
        }
        
        self.updateTravelledPath(currentLoc: newCoordinate)
        
        //Find Distance Logic
        let location: CLLocation?
        if(self.currentBookingModel?.status == "traveling"){
            location = CLLocation(latitude: Double(self.currentBookingModel?.dropoffLat ?? "0.0") ?? 0.0, longitude: Double(self.currentBookingModel?.dropoffLng ?? "0.0") ?? 0.0)
        }else{
            location = CLLocation(latitude: Double(self.currentBookingModel?.pickupLat ?? "0.0") ?? 0.0, longitude: Double(self.currentBookingModel?.pickupLng ?? "0.0") ?? 0.0)
        }
        
        let Current = CLLocation(latitude: SingletonClass.sharedInstance.latitude, longitude: SingletonClass.sharedInstance.longitude)
        let distanceInMeters = location?.distance(from: Current)
        if(distanceInMeters! <= 300){
            if(distanceInMeters! <= 50){
                if(self.currentBookingModel?.status == "traveling"){
                    Utilities.displayAlert("You're at DropOff Location \n(50 meters)")
                }else{
                    Utilities.displayAlert("You're at Pickup Location \n(50 meters)")
                }
            }
            if(!self.acceptedRideDetailsView.btnSubmit.isUserInteractionEnabled){
                Utilities.displayAlert("You're near pick Location \n(300 meters)")
                self.acceptedRideDetailsView.btnSubmit.isUserInteractionEnabled = true
                self.acceptedRideDetailsView.btnSubmit.alpha = 1
            }
        }
        
    }
    
    //MARK: - update TravelledPath Methods
    func updateTravelledPath(currentLoc: CLLocationCoordinate2D){
        var index = 0
        self.coordinates = []
        print("---------- Polyline Array ----------")
        for i in 0..<self.path.count(){
            let pathLat = Double(self.path.coordinate(at: i).latitude).rounded(toPlaces: 5)
            let pathLong = Double(self.path.coordinate(at: i).longitude).rounded(toPlaces: 5)
            print(" pathLat - \(pathLat) : pathLong - \(pathLong)")
            
            self.newPoint = CLLocation(latitude: pathLat, longitude: pathLong)
            if(self.oldPoint == nil){
                self.oldPoint = self.newPoint
            }
            self.getAllCoordinate(startPoint: self.oldPoint, endPoint: self.newPoint)
            self.oldPoint = self.newPoint
            
            let coord = CLLocation(latitude: pathLat, longitude: pathLong)
            self.coordinates.append(coord)
        }
        
        let userLocation = CLLocation(latitude: Double(currentLoc.latitude).rounded(toPlaces: 5), longitude: Double(currentLoc.longitude).rounded(toPlaces: 5))
        let closest = self.coordinates.min(by:{ $0.distance(from: userLocation) < $1.distance(from: userLocation) })
        index = self.coordinates.firstIndex{$0 === closest}!
        
        //Creating new path from the current location to the destination
        let newPath = GMSMutablePath()
        for i in index..<Int(self.coordinates.count){
            newPath.add(CLLocationCoordinate2D(latitude: self.coordinates[i].coordinate.latitude, longitude: self.coordinates[i].coordinate.longitude))
        }
        if (self.polyline != nil){
            polyline.map = nil
        }
        self.polyline = GMSPolyline(path: newPath)
        self.polyline.strokeColor = UIColor.black
        self.polyline.strokeWidth = 3.0
        self.polyline.map = self.vwMap
        
    }
    
    func getAllCoordinate(startPoint:CLLocation, endPoint:CLLocation){
        
        let yourTotalCoordinates = Double(5) //1 number of coordinates, change it as per your uses
        let latitudeDiff = startPoint.coordinate.latitude - endPoint.coordinate.latitude //2
        
        let longitudeDiff = startPoint.coordinate.longitude - endPoint.coordinate.longitude //3
        let latMultiplier = latitudeDiff / (yourTotalCoordinates + 1) //4
        let longMultiplier = longitudeDiff / (yourTotalCoordinates + 1) //5
        
        for index in 1...Int(yourTotalCoordinates) { //7
            let lat  = startPoint.coordinate.latitude - (latMultiplier * Double(index)) //8
            let long = startPoint.coordinate.longitude - (longMultiplier * Double(index)) //9
            let point = CLLocation(latitude: lat.rounded(toPlaces: 5), longitude: long.rounded(toPlaces: 5)) //10
            print(" pathLat - \(point.coordinate.latitude) : pathLong - \(point.coordinate.longitude)")
            self.coordinates.append(point) //11
        }
    }
    
    //MARK: - open GoogleMap Path Methods
    func openGoogleMap(){
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)){
            if(self.CurrentLocLat == "0.0" && self.CurrentLocLong == "0.0"){
                UIApplication.shared.open((NSURL(string:"https://maps.google.com/maps?saddr=&daddr=\(self.PickLocLat),\(self.PickLocLong)")! as URL), options: [:], completionHandler: nil)
            }
            else{
                UIApplication.shared.open((NSURL(string:"https://maps.google.com/maps?saddr=\(self.CurrentLocLat),\(self.CurrentLocLong)&daddr=\(self.PickLocLat),\(self.PickLocLong)")! as URL), options: [:], completionHandler: nil)
            }
        }else{
            if(self.CurrentLocLat == "0.0" && self.CurrentLocLong == "0.0"){
                UIApplication.shared.open((NSURL(string:"https://maps.google.com/maps?saddr=&daddr=\(self.PickLocLat),\(self.PickLocLong)")! as URL), options: [:], completionHandler: nil)
            }
            else{
                UIApplication.shared.open((NSURL(string:"https://maps.google.com/maps?saddr=\(self.CurrentLocLat),\(self.CurrentLocLong)&daddr=\(self.PickLocLat),\(self.PickLocLong)")! as URL), options: [:], completionHandler: nil)
            }
        }
    }
    
    //MARK:- handleRideFlow methods
    func handleRideFlow(state : Int){
        
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
        let camera = GMSCameraPosition.camera(withLatitude: Double(self.CurrentLocLat) ?? 0.0, longitude:  Double(self.CurrentLocLong) ?? 0.0, zoom: 13.6)
        self.vwMap.animate(to: camera)
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
        self.setNavWithSOS()
        self.changeDutyStatus()
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
        self.setNavWithSOS()
        self.btnOn.isHidden = false
    }
    
    func onCurrentBookingAPI() {
        self.callCurrentBookingAPI()
    }
}

//MARK:- AcceptedRideDetailsViewDelgate
extension HomeVC : AcceptedRideDetailsViewDelgate{
    func onTripTrackingStarted() {
        if  SocketIOManager.shared.socket.status == .connected {
            self.emitSocket_liveTrackingp(CustId: self.currentBookingModel?.customerInfo?.id ?? "",
                                          lat: Double(self.currentBookingModel?.dropoffLat ?? "0.0") ?? 0.0,
                                          lng: Double(self.currentBookingModel?.dropoffLng ?? "0.0") ?? 0.0,
                                          pickup_lat: Double(self.currentBookingModel?.pickupLat ?? "0.0") ?? 0.0,
                                          pickup_lng: Double(self.currentBookingModel?.pickupLng ?? "0.0") ?? 0.0)
        }
        
        self.setupTrackingMarker()
    }
    
    func onArrivedUserLocation() {
        self.verifyCustomerAPI()
    }
    
    @objc func onCancelAcceptedRideRequest() {
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

//MARK:- ARCarMovementDelegate
extension HomeVC : ARCarMovementDelegate{
    func arCarMovementMoved(_ marker: GMSMarker) {
        
        self.DriverLocMarker = nil
        self.DriverLocMarker = marker
        self.DriverLocMarker?.map = self.vwMap
    }
    
}

