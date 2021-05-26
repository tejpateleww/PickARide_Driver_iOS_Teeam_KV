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
        static let RequestCanceled = 2
        static let ArrivedAtLocation = 3
        static let StartRide = 4
        static let EndRide = 5
    }
    
    @IBOutlet weak var vwMap: UIView!
    @IBOutlet weak var btnOn: UIButton!
    @IBOutlet weak var lblOffline: themeLabel!
    
    lazy var incomingRideRequestView : IncomingRideRequestView = IncomingRideRequestView.fromNib()

    lazy var acceptedRideDetailsView : AcceptedRideDetailsView = AcceptedRideDetailsView.fromNib()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.sos.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        handleRideFlow(state: RideState.None)
    }
    
    @IBAction func btnOnClick(_ sender: Any)
    {
        handleRideFlow(state: RideState.NewRequest)
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
            
            incomingRideRequestView.isHidden = true
            acceptedRideDetailsView.isHidden = true
        
        }else if (state == RideState.NewRequest)
        {
            incomingRideRequestView.setRideDetails()
            incomingRideRequestView.isHidden = false
            acceptedRideDetailsView.isHidden = true

        }else if (state == RideState.RequestAccepted)
        {
            acceptedRideDetailsView.setRideDetails()
            incomingRideRequestView.isHidden = true
            acceptedRideDetailsView.isHidden = false

        }
        
    }
    
}

extension HomeVC : IncomingRideRequestViewDelegate
{
    func onCancelRideRequest() {
    }
    
    func onAcceptRideRequest() {
        handleRideFlow(state: RideState.RequestAccepted)
    }
}

extension HomeVC : AcceptedRideDetailsViewDelgate
{
    func onArrivedUserLocation() {
    }
    
    func onCancelAcceptedRideRequest() {
        
    }
}
