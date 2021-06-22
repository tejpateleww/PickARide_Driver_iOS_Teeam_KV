//
//  HomeVC.swift
//  PickaRideDriver
//
//  Created by Admin on 08/05/21.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

class HomeVC: BaseVC {
 
    enum RideState {
        static let None = 0
        static let NewRequest = 1
        static let RequestAccepted = 2
        static let RequestCancel = 3
        static let CancelAcceptedRide = 4
        static let ArrivedAtLocation = 5
        static let StartRide = 6
        static let EndRide = 7
    }
    
    @IBOutlet weak var vwMap: UIView!
    @IBOutlet weak var btnOn: UIButton!
    @IBOutlet weak var lblOffline: themeLabel!
    
    lazy var incomingRideRequestView : IncomingRideRequestView = IncomingRideRequestView.fromNib()
    lazy var acceptedRideDetailsView : AcceptedRideDetailsView = AcceptedRideDetailsView.fromNib()
    lazy var cancelRideView : CancelRideView = CancelRideView.fromNib()

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.sos.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        handleRideFlow(state: RideState.None)
//        vwMap
    }
    
    
    @IBAction func btnOnClick(_ sender: Any)
    {
        handleRideFlow(state: RideState.NewRequest)
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
        
}

fileprivate extension HomeVC {
    
    func handleRideFlow(state : Int) {
        
        if (state == RideState.None)
        {
            incomingRideRequestView.delegate = self
            incomingRideRequestView.isUserInteractionEnabled = true
            incomingRideRequestView.frame = self.view.frame
            incomingRideRequestView.removeFromSuperview()
            self.view.addSubview(incomingRideRequestView)
            
            acceptedRideDetailsView.delegate = self
            acceptedRideDetailsView.isUserInteractionEnabled = true
            acceptedRideDetailsView.frame = self.view.frame
            acceptedRideDetailsView.removeFromSuperview()
            self.view.addSubview(acceptedRideDetailsView)
            
            cancelRideView.delegate = self
            cancelRideView.isUserInteractionEnabled = true
            cancelRideView.frame = self.view.frame
            cancelRideView.removeFromSuperview()
            self.view.addSubview(cancelRideView)
            
            incomingRideRequestView.isHidden = true
            acceptedRideDetailsView.isHidden = true
//            incomingRideRequestView.noThanksTapClosure = {
//
//            }
            cancelRideView.isHidden = true
        
        }else if (state == RideState.NewRequest)
        {
            incomingRideRequestView.isHidden = false
            acceptedRideDetailsView.isHidden = true
            cancelRideView.isHidden = true
            incomingRideRequestView.setRideDetails()


        }else if (state == RideState.RequestAccepted)
        {
            incomingRideRequestView.isHidden = true
            acceptedRideDetailsView.isHidden = false
            cancelRideView.isHidden = true
            acceptedRideDetailsView.setRideDetails()

        
        }else if (state == RideState.CancelAcceptedRide)
        {
            incomingRideRequestView.isHidden = true
            acceptedRideDetailsView.isHidden = true
            cancelRideView.isHidden = false
            cancelRideView.setRideDetails()
        }
    
    }
    
}

extension HomeVC : IncomingRideRequestViewDelegate
{
    func onCancelRideRequest() {
        
    }
    
    func onNoThanksRequest(){
        handleRideFlow(state: RideState.None)
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.sos.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    
    func onAcceptRideRequest() {
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        handleRideFlow(state: RideState.RequestAccepted)
    }
}

extension HomeVC : AcceptedRideDetailsViewDelgate
{
    func onArrivedUserLocation() {
        self.handleRideFlow(state: RideState.None)
        let vc : RatingAndReviewVC = RatingAndReviewVC.instantiate(fromAppStoryboard: .Main)
        vc.modalPresentationStyle = .overFullScreen
        vc.reviewBtnTapClosure = {
//            self.handleRideFlow(state: RideState.None)
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.sos.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        }
        vc.btnDoneTapClosure = {
            self.setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.sos.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        }
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    
    func onCancelAcceptedRideRequest() {
        handleRideFlow(state: RideState.CancelAcceptedRide)
    }
}

extension HomeVC : CancelRideViewDelgate
{
    func onRideCanelDecision(decision: Int)
    {
        if (decision == 1) //Yes
        {
            let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: CancelRideVC.storyboardID) as! CancelRideVC
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
