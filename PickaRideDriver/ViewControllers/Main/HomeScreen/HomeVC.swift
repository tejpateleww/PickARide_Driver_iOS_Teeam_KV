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
    
    @IBOutlet weak var vwMap: UIView!
    @IBOutlet weak var btnOn: UIButton!
    @IBOutlet weak var lblOffline: themeLabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.none.value, leftImage: NavItemsLeft.menu.value, rightImages: [NavItemsRight.sos.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnOnClick(_ sender: Any)
    {
        let customView : IncomingRideRequestView = IncomingRideRequestView.fromNib()
        customView.delegate = self
        customView.isUserInteractionEnabled = true
        customView.frame = self.view.frame
        self.view.addSubview(customView)
    }
}


extension HomeVC : IncomingRideRequestViewDelegate
{
    func onCancelRideRequest() {
        
    }
    
    func onAcceptRideRequest() {
      
        let customView : AcceptedRideDetailsView = AcceptedRideDetailsView.fromNib()
        //customView.delegate = self
        customView.isUserInteractionEnabled = true
        customView.frame = self.view.frame
        self.view.addSubview(customView)
    }
}
