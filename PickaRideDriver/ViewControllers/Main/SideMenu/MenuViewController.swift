
//
//  MenuViewController.swift
//  SideMenuExample
//
//  Created by kukushi on 11/02/2018.
//  Copyright © 2018 kukushi. All rights reserved.
//

import UIKit
import SideMenuSwift

class Preferences {
    static let shared = Preferences()
    var enableTransitionAnimation = false
}

class MenuViewController: UIViewController {
    
   
    var selectedMenuClosure : (() -> ())?
    var isDarkModeEnabled = false
    var selectedMenuIndex = 0
    
    
    @IBOutlet weak var tblSidemenuData: UITableView! {
        didSet {
            tblSidemenuData.dataSource = self
            tblSidemenuData.delegate = self
            tblSidemenuData.separatorStyle = .none
        }
    }
//    var myimgarr = [#imageLiteral(resourceName: "imgHome"),#imageLiteral(resourceName: "imgMyrides"),#imageLiteral(resourceName: "imgPayment"),#imageLiteral(resourceName: "imgNotification"),#imageLiteral(resourceName: "imgSettings"),#imageLiteral(resourceName: "imgAddFrind"),#imageLiteral(resourceName: "imgHelp"),#imageLiteral(resourceName: "imgLogout")]
    var myarray = [MyType]()
    let mylblarr = [MyType.MyRides.value,MyType.Earnings.value,MyType.Account.value,MyType.MyRating.value,MyType.withdraw.value,MyType.Help.value,MyType.Logout.value]
    
    @IBOutlet weak var selectionTableViewHeader: UILabel!

    @IBOutlet weak var lblLegal: versionLabel!
    @IBOutlet weak var lblVersion: versionLabel!
    
    @IBOutlet weak var selectionMenuTrailingConstraint: NSLayoutConstraint!
    private var themeColor = UIColor.white

    override func viewDidLoad() {
        super.viewDidLoad()

        isDarkModeEnabled = SideMenuController.preferences.basic.position == .under
        configureView()
        NotificationCenter.default.removeObserver(self, name: NotificationRefreshSideMenu, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshMenu), name: NotificationRefreshSideMenu, object: nil)
//        sideMenuController?.cache(viewControllerGenerator: {
//            self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
//        }, with: "1")
//
//        sideMenuController?.cache(viewControllerGenerator: {
//            self.storyboard?.instantiateViewController(withIdentifier: "ThirdViewController")
//        }, with: "2")

        sideMenuController?.delegate = self
        self.setupLocalization()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        print("[Example] Menu did appear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      
        print("[Example] Menu will disappear")
    }

    //MARK: -Other Methods
    @objc func refreshMenu() {
        DispatchQueue.main.async { [self] in
            self.selectedMenuIndex = 0
            self.tblSidemenuData.reloadData()
        }
    }
    func setupLocalization() {
        //lblLegal.text = "MenuVC_lblLegal".Localized()
        //lblVersion.text = String(format: "MenuVC_lblVersion".Localized(), kAPPVesion)
    }
    
    private func configureView() {
        if isDarkModeEnabled {
            themeColor = UIColor(red: 0.03, green: 0.04, blue: 0.07, alpha: 1.00)
            selectionTableViewHeader.textColor = .white
        } else {
            selectionMenuTrailingConstraint.constant = 0
            themeColor = UIColor(red: 0.98, green: 0.97, blue: 0.96, alpha: 1.00)
        }

        let sidemenuBasicConfiguration = SideMenuController.preferences.basic
        let showPlaceTableOnLeft = (sidemenuBasicConfiguration.position == .under) != (sidemenuBasicConfiguration.direction == .right)
        if showPlaceTableOnLeft {
           // selectionMenuTrailingConstraint.constant = -(view.frame.width)
            selectionMenuTrailingConstraint.constant = SideMenuController.preferences.basic.menuWidth - view.frame.width
        }

        view.backgroundColor = themeColor
        //tableView.backgroundColor = themeColor
    }

    @IBAction func btnProfileTap(_ sender: Any) {
        sideMenuController?.hideMenu()
        let homeVC = self.parent?.children.first?.children.first as? HomeVC
        
        let vc : EditProfileVC = EditProfileVC.instantiate(fromAppStoryboard: .Main)
        homeVC?.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        let sideMenuBasicConfiguration = SideMenuController.preferences.basic
        let showPlaceTableOnLeft = (sideMenuBasicConfiguration.position == .under) != (sideMenuBasicConfiguration.direction == .right)
        selectionMenuTrailingConstraint.constant = showPlaceTableOnLeft ? SideMenuController.preferences.basic.menuWidth - size.width : 0
        view.layoutIfNeeded()
    }
}

extension MenuViewController: SideMenuControllerDelegate {
    func sideMenuController(_ sideMenuController: SideMenuController,
                            animationControllerFrom fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BasicTransitionAnimator(options: .transitionFlipFromLeft, duration: 0.6)
    }

    func sideMenuController(_ sideMenuController: SideMenuController, willShow viewController: UIViewController, animated: Bool) {
        print("[Example] View controller will show [\(viewController)]")
    }

    func sideMenuController(_ sideMenuController: SideMenuController, didShow viewController: UIViewController, animated: Bool) {
        print("[Example] View controller did show [\(viewController)]")
    }

    func sideMenuControllerWillHideMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu will hide")
    }

    func sideMenuControllerDidHideMenu(_ sideMenuController: SideMenuController) {
        
       
        
        print("[Example] Menu did hide.")
       
    }

    func sideMenuControllerWillRevealMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu will reveal.")
    }

    func sideMenuControllerDidRevealMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu did reveal.")
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return mylblarr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:sideCell = tblSidemenuData.dequeueReusableCell(withIdentifier: "sideCell", for: indexPath)as! sideCell
        cell.lblData?.text = mylblarr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedMenuIndex = indexPath.row
        tblSidemenuData.reloadData()
        sideMenuController?.hideMenu()
        
        let homeVC = self.parent?.children.first?.children.first as? HomeVC
        // let homeVC = HomeViewController()
        
        let strCellItemTitle = mylblarr[indexPath.row] // aryItemNames[indexPath.row]
        // let currentItem = aryList[indexPath.row]
        
        if strCellItemTitle == MyType.MyRides.value
        {
            let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: MyRidesVC.storyboardID)
            homeVC?.navigationController?.pushViewController(controller, animated: true)
            
        } else if strCellItemTitle == MyType.Earnings.value
        {
            let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: EarningViewController.storyboardID)
            homeVC?.navigationController?.pushViewController(controller, animated: true)
            
        }
        else if strCellItemTitle == MyType.Help.value
        {
            let vc : DummyVC = DummyVC.instantiate(fromAppStoryboard: .Main)
            vc.strTitle = "Help"
            vc.dataText = "This is Help Page"
            homeVC?.navigationController?.pushViewController(vc, animated: true)
//            let controller = AppStoryboard.Chat.instance.instantiateViewController(withIdentifier: ChatViewController.storyboardID) as! ChatViewController
//            homeVC?.navigationController?.pushViewController(controller, animated: true)
        }
        else if strCellItemTitle == MyType.Logout.value {
            let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                user_defaults.setValue(false, forKey: UserDefaultsKey.isUserLogin.rawValue)
                appDel.navigateToLogin()
                // (UIApplication.shared.delegate as! AppDelegate).GoToLogout()
                
            }
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alert.addAction(ok)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        } else if strCellItemTitle == MyType.Account.value {
            let controller = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: SettingVC.storyboardID)
            homeVC?.navigationController?.pushViewController(controller, animated: true)
        }
//        else if strCellItemTitle == MyType.Help.value {
//            let vc : DummyVC = DummyVC.instantiate(fromAppStoryboard: .Main)
//            vc.strTitle = "Help"
//            homeVC?.navigationController?.pushViewController(vc, animated: true)
//        }
    }
}
class sideCell:UITableViewCell{
    @IBOutlet weak var imgData: menuImageView?
    @IBOutlet weak var lblData: menuLabel?
}

enum MyType{
    case MyRides,Earnings,Account,MyRating,withdraw,Privacy,Help,Logout
    
    var value:String{
        switch self{
        case .MyRides:
            return "My Rides"
        case .Earnings:
            return "Earnings"
        case .Help:
            return "Help"
        case .Logout:
            return "Logout"
        case .Account:
            return "Account"
        case .MyRating :
            return "My Rating & Reviews"
        case .withdraw :
            return "Withdraw History"
        case .Privacy :
            return "Privacy Policy"
        }
    }
}
