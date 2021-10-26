//
//  BaseVC.swift
//  Cluttrfly-HAULER Driver
//
//  Created by Raju Gupta on 15/02/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit
import SafariServices
import AVKit
import SDWebImage

class BaseVC: UIViewController, UIGestureRecognizerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.UpdateView()
    }
//
//    var lblNavNotifBadge = badgeLabel()
//    var btnNavProfile = buttonForProfile()
//    var switchNavLanguage = switchLanguageSegment()
    var navBtnProfile = UIButton()
    var navBtnDone = UIButton()
    
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        let bounds = self.navigationController!.navigationBar.bounds
//        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 48)
//    }
    
    func setNavigationBarInViewController (controller : UIViewController,naviColor : UIColor, naviTitle : String, leftImage : String , rightImages : [String], isTranslucent : Bool, CommonViewTitles : [String], isTwoLabels:Bool, isDisableBack:Bool = false, leftimageLeftAllign : Double = 0)
    {
        UIApplication.shared.statusBarStyle = .lightContent
        controller.navigationController?.isNavigationBarHidden = false
        controller.navigationController?.navigationBar.isOpaque = false
        
        controller.navigationController?.navigationBar.isTranslucent = isTranslucent
        
        controller.navigationController?.navigationBar.barTintColor = naviColor;
        controller.navigationController?.navigationBar.tintColor = colors.white.value;
        
   //     controller.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: (controller.navigationController?.navigationBar.frame.size.width)!, height: 48)
        if naviTitle == NavTitles.Home.value {
            controller.navigationItem.titleView = UIView()
        } else {
            if isTwoLabels {
                let label = UILabel()
                label.frame = CGRect(x: 0, y: 0, width: (controller.navigationController?.navigationBar.frame.size.width ?? 0), height: 44)
                let newNavTitle = naviTitle.replacingOccurrences(of: "MultiLine", with: "")
                let fullNameArr = newNavTitle.split{$0 == "\n"}.map(String.init)
                print(fullNameArr)
                
                let myMutableString1 = NSMutableAttributedString(string: fullNameArr[0], attributes: [NSAttributedString.Key.font : CustomFont.bold.returnFont(18)])
                let myMutableString2 = NSMutableAttributedString(string: "\n\(fullNameArr[1])", attributes: [NSAttributedString.Key.font : CustomFont.medium.returnFont(13)])
                myMutableString1.addAttribute(NSAttributedString.Key.foregroundColor, value: colors.loginPlaceHolderColor.value, range: NSRange(location: 0, length: fullNameArr[0].count - 1))
                myMutableString2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hexString: "#ACB1C0"), range: NSRange(location: 0, length: fullNameArr[1].count + 1))
                
                let combination = NSMutableAttributedString()

                combination.append(myMutableString1)
              
                combination.append(myMutableString2)
                
                label.attributedText = combination
                label.textAlignment = .center
                label.numberOfLines = 0
                label.adjustsFontSizeToFitWidth = true
                controller.navigationItem.titleView = label
            }
            
            else if naviTitle == "CommonView" {
                var w = (controller.navigationController?.navigationBar.frame.size.width)!
                if #available(iOS 13.0, *) {
                    w = w - 10
                }
                let viewForTop = UIView()
                viewForTop.frame = CGRect(x: 0, y: 0, width: (controller.navigationController?.navigationBar.frame.size.width ?? 0), height: 44)
                viewForTop.backgroundColor = .clear
                let xibView : navigationCommonView = navigationCommonView.loadFromXib()
                xibView.frame = CGRect(x: 0, y: 0, width: w, height: 44)
                xibView.lblEndRideAddress.text = CommonViewTitles[1]
                xibView.lblStartRideAddress.text = CommonViewTitles[0]
                if !isDisableBack {
                    xibView.btnNavigation.addTarget(self, action: #selector(self.btnBackAction), for: .touchUpInside)
                }
                viewForTop.addSubview(xibView)
                controller.navigationItem.titleView?.backgroundColor = .red
                controller.navigationItem.titleView = viewForTop
            } else {
                let label = UILabel()
                label.text = naviTitle
                label.textColor = colors.loginPlaceHolderColor.value
                label.font = CustomFont.bold.returnFont(18)
                if naviTitle == "NavigationTitle_Rating".Localized() {
                    label.textColor = colors.white.value
                }
                label.numberOfLines = 0
                label.textAlignment = .center
                label.adjustsFontSizeToFitWidth = true
               // controller.navigationItem.title = naviTitle //.Localized()
                controller.navigationItem.titleView = label
            }
        }
        
        // controller.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : colors.black.value, NSAttributedString.Key.font: CustomFont.bold.returnFont(20)]
        
        controller.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        controller.navigationController?.navigationBar.shadowImage = UIImage()

        if leftImage != "" {
            if leftImage == NavItemsLeft.back.value {
                let btnLeft = UIButton(frame: CGRect(x: leftimageLeftAllign, y: 0, width: 44, height: 44))
                btnLeft.setImage(UIImage.init(named: "nav_back"), for: .normal)
                btnLeft.layer.setValue(controller, forKey: "controller")
                btnLeft.addTarget(self, action: #selector(self.btnBackAction), for: .touchUpInside)
                btnLeft.contentHorizontalAlignment = .left
                let LeftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
                LeftView.addSubview(btnLeft)
            
                let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: LeftView)
                btnLeftBar.style = .plain
                controller.navigationItem.leftBarButtonItem = btnLeftBar
            } else if leftImage == NavItemsLeft.menu.value {
                let btnLeft = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                btnLeft.setImage(UIImage.init(named: "ic_menu"), for: .normal)
                btnLeft.layer.setValue(controller, forKey: "controller")
                btnLeft.addTarget(self, action: #selector(btMenuAction(_:)), for: .touchUpInside)
                
                btnLeft.shadow = true
//                btnLeft.layer.shadowColor = colors.black.value.cgColor
//                btnLeft.layer.shadowOffset = CGSize(width: 0, height: 0)
//                btnLeft.layer.shadowRadius = 3
//                btnLeft.layer.shadowOpacity = 0.4
                
                
                let LeftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                LeftView.addSubview(btnLeft)
            
                let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: LeftView)
                btnLeftBar.style = .plain
                controller.navigationItem.leftBarButtonItem = btnLeftBar
                
                
            } else if leftImage == NavItemsLeft.cancel.value {
                let btnLeft = UIButton(frame: CGRect(x: -14, y: 0, width: 44, height: 44))
                btnLeft.setImage(UIImage.init(named: "ic_Cancel"), for: .normal)
                btnLeft.layer.setValue(controller, forKey: "controller")
                
                btnLeft.addTarget(self, action: #selector(self.btnBackAction), for: .touchUpInside)
                let LeftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
                LeftView.addSubview(btnLeft)
            
                let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: LeftView)
                btnLeftBar.style = .plain
                controller.navigationItem.leftBarButtonItem = btnLeftBar
            } else if leftImage == NavItemsLeft.cancelWhite.value {
                let btnLeft = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
                btnLeft.setImage(UIImage.init(named: "ic_cancelWhite"), for: .normal)
                btnLeft.layer.setValue(controller, forKey: "controller")
                
                btnLeft.addTarget(self, action: #selector(self.btnBackAction), for: .touchUpInside)
                let LeftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
                LeftView.addSubview(btnLeft)
            
                let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: LeftView)
                btnLeftBar.style = .plain
                controller.navigationItem.leftBarButtonItem = btnLeftBar
            } else if leftImage == NavItemsLeft.QuestionFalse.value {
                let btnLeft = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
                btnLeft.setImage(UIImage.init(named: "imgQuestionFalse"), for: .normal)
                btnLeft.layer.setValue(controller, forKey: "controller")
                btnLeft.addTarget(self, action: #selector(self.btnBackAction), for: .touchUpInside)
                btnLeft.contentHorizontalAlignment = .left
                let LeftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
                LeftView.addSubview(btnLeft)
            
                let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: LeftView)
                btnLeftBar.style = .plain
                controller.navigationItem.leftBarButtonItem = btnLeftBar
            }
        }
        else {
            let emptyView = UIView()
            let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: emptyView)
            btnLeftBar.style = .plain
            controller.navigationItem.leftBarButtonItem = btnLeftBar
        }
        if rightImages.count != 0 {
            var arrButtons = [UIBarButtonItem]()
            rightImages.forEach { (title) in
                if title == NavItemsRight.login.value {
                    let viewLogin = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))

                    let btnLogin = UIButton.init()
                    btnLogin.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
                    btnLogin.setTitle("NavigationButton_btnLogin".Localized(), for: .normal)
                    btnLogin.titleLabel?.font = CustomFont.bold.returnFont(18)
                    btnLogin.setTitleColor(colors.submitButtonColor.value, for: .normal)
                    btnLogin.addTarget(self, action: #selector(openLoginVC(_:)), for: .touchUpInside)
                    btnLogin.layer.setValue(controller, forKey: "controller")
                    viewLogin.addSubview(btnLogin)

                

                    let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: viewLogin)
                    btnRightBar.style = .plain
                    arrButtons.append(btnRightBar)
                } else if title == NavItemsRight.EditProfile.value {
                    let viewProfile = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))

                    navBtnProfile = UIButton.init()
                    navBtnProfile.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
                    navBtnProfile.setImage(UIImage.init(named: "ic_ProfileEdit"), for: .normal)
                   
                   // btnProfile.addTarget(self, action: #selector(openLoginVC(_:)), for: .touchUpInside)
                    navBtnProfile.layer.setValue(controller, forKey: "controller")
                    viewProfile.addSubview(navBtnProfile)
                    navBtnProfile.addTarget(self, action: #selector(EditProfileBtn(_:)), for: .touchUpInside)
                    navBtnProfile.layer.shadowColor = colors.black.value.cgColor
                    navBtnProfile.layer.shadowOffset = CGSize(width: 0, height: 0)
                    navBtnProfile.layer.shadowRadius = 3
                    navBtnProfile.layer.shadowOpacity = 0.4

                    let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: viewProfile)
                    btnRightBar.style = .plain
                    arrButtons.append(btnRightBar)
                } else if title == NavItemsRight.userProfile.value {
                    
                    let viewProfileEdit = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))

                    let btnProfileEdit = UIButton.init()
                    btnProfileEdit.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
                    btnProfileEdit.setImage(UIImage.init(named: "nav_dummy_userImage"), for: .normal)
                    btnProfileEdit.addTarget(self, action: #selector(EditUserProfile(_:)), for: .touchUpInside)
                   // btnProfile.addTarget(self, action: #selector(openLoginVC(_:)), for: .touchUpInside)
                    btnProfileEdit.layer.setValue(controller, forKey: "controller")
                    viewProfileEdit.addSubview(btnProfileEdit)


                    let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: viewProfileEdit)
                    btnRightBar.style = .plain
                    arrButtons.append(btnRightBar)
                } else  if title == NavItemsRight.Done.value {
                    let viewDone = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 44))

                    navBtnDone = UIButton.init()
                    navBtnDone.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
                    navBtnDone.setTitle("NavigationButton_btnDone".Localized(), for: .normal)
                    navBtnDone.titleLabel?.font = CustomFont.bold.returnFont(18)
                    navBtnDone.setTitleColor(colors.submitButtonColor.value, for: .normal)
                   
                   // btnLogin.addTarget(self, action: #selector(openLoginVC(_:)), for: .touchUpInside)
                    navBtnDone.layer.setValue(controller, forKey: "controller")
                    viewDone.addSubview(navBtnDone)

                    let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: viewDone)
                    btnRightBar.style = .plain
                    arrButtons.append(btnRightBar)
                }else if title == NavItemsRight.sos.value {
                    
                    let viewProfileEdit = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))

                    let btnProfileEdit = UIButton.init()
                    btnProfileEdit.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
                    btnProfileEdit.setImage(UIImage.init(named: "ic_SOSBtn"), for: .normal)
                    btnProfileEdit.addTarget(self, action: #selector(EditUserProfile(_:)), for: .touchUpInside)
                   // btnProfile.addTarget(self, action: #selector(openLoginVC(_:)), for: .touchUpInside)
                    btnProfileEdit.layer.setValue(controller, forKey: "controller")
                    viewProfileEdit.addSubview(btnProfileEdit)


                    let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: viewProfileEdit)
                    btnRightBar.style = .plain
                    arrButtons.append(btnRightBar)
                }else if title == NavItemsRight.help.value {
                    
                    let viewProfileEdit = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))

                    let btnProfileEdit = UIButton.init()
                    btnProfileEdit.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
                    btnProfileEdit.setImage(UIImage.init(named: "imgHelp"), for: .normal)
                    btnProfileEdit.addTarget(self, action: #selector(HelpController(_:)), for: .touchUpInside)
                   // btnProfile.addTarget(self, action: #selector(openLoginVC(_:)), for: .touchUpInside)
                    btnProfileEdit.layer.setValue(controller, forKey: "controller")
                    viewProfileEdit.addSubview(btnProfileEdit)


                    let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: viewProfileEdit)
                    btnRightBar.style = .plain
                    arrButtons.append(btnRightBar)
                }else{
                    let viewProfile = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))

                    navBtnProfile = UIButton.init()
                    navBtnProfile.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
                    
                    navBtnProfile.layer.cornerRadius = 0.5 * navBtnProfile.bounds.size.width
                    navBtnProfile.clipsToBounds = true
                    navBtnProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    navBtnProfile.sd_setBackgroundImage(with: URL(string:rightImages[0]), for: .normal)
                    //navBtnProfile.sd_setBackgroundImage(with: URL(string:rightImages[0]), for: .normal, placeholderImage: UIImage(named: "nav_dummy_userImage"), options: [.continueInBackground, .refreshCached])

                    
                    navBtnProfile.addTarget(self, action: #selector(OpenChatUserInfo(_:)), for: .touchUpInside)
                    navBtnProfile.layer.setValue(controller, forKey: "controller")
                    viewProfile.addSubview(navBtnProfile)
                    navBtnProfile.addTarget(self, action: #selector(EditProfileBtn(_:)), for: .touchUpInside)
                    navBtnProfile.layer.shadowColor = colors.black.value.cgColor
                    navBtnProfile.layer.shadowOffset = CGSize(width: 0, height: 0)
                    navBtnProfile.layer.shadowRadius = 3
                    navBtnProfile.layer.shadowOpacity = 0.4

                    let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: viewProfile)
                    btnRightBar.style = .plain
                    arrButtons.append(btnRightBar)
                }
            }
            controller.navigationItem.rightBarButtonItems = arrButtons
        }
        
        /*
        if rightImage != "" {
            
            let btnRight = UIButton.init()
            btnRight.setImage(UIImage.init(named: rightImage), for: .normal)
            btnRight.layer.setValue(controller, forKey: "controller")
            
//            if rightImage == iconWhiteCall {
                btnRight.addTarget(self, action: #selector(self.btnCallAction), for: .touchUpInside)
//            }
            
            let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: btnRight)
            btnRightBar.style = .plain
            controller.navigationItem.rightBarButtonItem = btnRightBar
            
        }
        */
        
    }
    
    func UpdateView() {
        
        if let lang = user_defaults.value(forKey: "language") as? String {
//            if lang == LanguageKey.EnglishLanguage {
//                UIView.appearance().semanticContentAttribute = .forceLeftToRight
//                UITableView.appearance().semanticContentAttribute = .forceLeftToRight
//                self.view.semanticContentAttribute = .forceLeftToRight
//                UITextView.appearance().semanticContentAttribute = .forceLeftToRight
//                UITextField.appearance().semanticContentAttribute = .forceLeftToRight
//                UILabel.appearance().semanticContentAttribute = .forceLeftToRight
//            }
//            else {
//                UIView.appearance().semanticContentAttribute = .forceRightToLeft
//                UITableView.appearance().semanticContentAttribute = .forceRightToLeft
//                self.view.semanticContentAttribute = .forceRightToLeft
//                UITextView.appearance().semanticContentAttribute = .forceRightToLeft
//                UITextField.appearance().semanticContentAttribute = .forceRightToLeft
//                UILabel.appearance().semanticContentAttribute = .forceRightToLeft
//            }
        }
    }
    
    func LanguageUpdate() {
        
        if let lang = user_defaults.value(forKey: "language") as? String {
//            if lang == LanguageKey.EnglishLanguage {
//                self.navigationController?.navigationBar.semanticContentAttribute = .forceLeftToRight
//                if let NavController = self.navigationController?.children {
//                    NavController.last?.view.semanticContentAttribute = .forceLeftToRight
//                }
//            }
//            else {
                self.navigationController?.navigationBar.semanticContentAttribute = .forceRightToLeft
                if let NavController = self.navigationController?.children {
                    NavController.last?.view.semanticContentAttribute = .forceRightToLeft
                }
//            }
        }
    }
    
//    @objc func  EditProfileViewController(_ sender: UIButton?) {
//        guard let ProfilePage = sender?.layer.value(forKey: "controller") as? ProfileViewController else {
//            return
//        }
//        ProfilePage.EditTapped()
//    }
    
//    @objc func  ShowTickets(_ sender: UIButton?) {
//        guard let controller = sender?.layer.value(forKey: "controller") as? GenerateTicketVC else {
//            return
//        }
//        let TickelistPage:MyTicketVC = UIViewController.viewControllerInstance(storyBoard: AppStoryboards.Help)
//        controller.navigationController?.pushViewController(TickelistPage, animated: true)
//    }
    
//    @objc func  SelectPremium(_ sender: UIButton?) {
////        guard sender == UIButton else {
////            return
////        }
//        self.btnPremium.isSelected = !self.btnPremium.isSelected
//        self.isPremiumBooking = self.btnPremium.isSelected
//        if self.btnPremium.isSelected {
//
//            let  infoPopup:HeaderWithDescription = UIViewController.viewControllerInstance(storyBoard: AppStoryboards.CustomPopup)
//            infoPopup.Title = "Premium Search"
//            infoPopup.Desc = UtilityClass.GetPremiumDesc()
//        appDel.window?.rootViewController?.present(infoPopup, animated: true, completion: nil)
//        }
//
//    }
    
    @objc func OpenSideMenu(_ sender: UIButton?) {
      
//        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
//        let vc = AppStoryboard.Popup.instance.instantiateViewController(withIdentifier: sideMenuController.storyboardID)
//        let navController = UINavigationController.init(rootViewController: vc)
//        navController.modalPresentationStyle = .overFullScreen
//        navController.navigationController?.modalTransitionStyle = .crossDissolve
//        controller?.present(navController, animated: false, completion: nil)
    }
    @objc func openLoginVC(_ sender: UIButton?) {
        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
//        let notifVc = AppStoryboard.Login.instance.instantiateViewController(withIdentifier: NotificationsListVC.storyboardID)
        controller?.navigationController?.popViewController(animated: true)
    }
    
    @objc func EditProfileBtn(_ sender: UIButton?){
        
    }
    
    @objc func OpenMailVC(_ sender: UIButton?) {
   
//        controller?.navigationController?.pushViewController(docInfoVc, animated: true)
    }
    
    @objc func OpenNotificationsVC(_ sender: UIButton?) {
//        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
//        let notifVc = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: NotificationsListVC.storyboardID)
//        controller?.navigationController?.pushViewController(notifVc, animated: true)
    }
    
    @objc func OpenOtherProfileVC(_ sender: UIButton?) {
//        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
//        let notifVc = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: ProfileVC.storyboardID)
//        controller?.navigationController?.pushViewController(notifVc, animated: true)
    }
    
    @objc func OpenChatVC(_ sender: UIButton?) {
//            let controller = sender?.layer.value(forKey: "controller") as? UIViewController
//            let chatVc = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: MedicalFollowUpChatVC.storyboardID)
           // controller?.navigationController?.pushViewController(chatVc, animated: true)
        }
    @objc func OpenEditProfileVC(_ sender: UIButton?) {
//        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
//        let notifVc = AppStoryboard.Home.instance.instantiateViewController(withIdentifier: ProfileVC.storyboardID)
//        controller?.navigationController?.pushViewController(notifVc, animated: true)
    }
    @objc func EditUserProfile(_ sender: UIButton?) {
        
//        let rtViewVC = (appDel.window?.rootViewController as! UINavigationController).children
//        for i in rtViewVC {
//            if i.isKind(of: EditProfileVC.self) {
//                let vc:EditProfileVC = i as! EditProfileVC
////                vc.makeEditProfile(isEditProfile: true)
//            }
//        }
        
    }
    
    @objc func HelpController (_ sender: UIButton?)
    {
        var Help = ""
        if let HelpLink = SingletonClass.sharedInstance.AppInitModel?.appLinks?.filter({ $0.name == "help"}) {
            if HelpLink.count > 0 {
                Help = HelpLink[0].url ?? ""
                self.previewDocument(strURL: Help)
            }
        }
    }
    
    func previewDocument(strURL : String){
        guard let url = URL(string: strURL) else {return}
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    @objc func DismissViewController (_ sender: UIButton?)
    {
        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
        controller?.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func poptoViewController (_ sender: UIButton?)
    {
        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
        controller?.navigationController?.popViewController(animated: true)
    }
    @objc func OpenMenuViewController (_ sender: UIButton?)
    {
       
//        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
//        controller?.frostedViewController.view.endEditing(true)
//        controller?.frostedViewController.presentMenuViewController()
//                controller?.sideMenuViewController?._presentLeftMenuViewController()
    }
    
    @objc func OpenChatUserInfo (_ sender: UIButton?)
    {
        print("called..")
    }
    
    
    func setNavBarWithMenu(Title:String, IsNeedRightButton:Bool){
        
        if Title == "Home"
        {
            //            let titleImage = UIImageView(frame: CGRect(x: 10, y: 0, width: 100, height: 30))
            //            titleImage.contentMode = .scaleAspectFit
            //            titleImage.image = UIImage(named: "Title_logo")
            ////            titleImage.backgroundColor  = themeYellowColor
            //             self.navigationItem.titleView = titleImage
            self.title = title?.uppercased()
        }
        else
        {
            self.navigationItem.title = Title.uppercased()
        }
        
        self.navigationController?.navigationBar.barTintColor = colors.black.value
        self.navigationController?.navigationBar.tintColor = colors.black.value
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        

       
    }
    
    
    // MARK:- Navigation Bar Button Action Methods

    
    @objc func btnBackAction() {
        if self.navigationController?.children.count == 1 {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func btMenuAction (_ sender: UIButton?) {
        let controller = sender?.layer.value(forKey: "controller") as? UIViewController
        controller?.sideMenuController?.revealMenu()
        
    }
        func btMenuAction() {
       
    }
    
        func btnSkipAction() {
        //appDel.navigateToHome()
    }
    
    
  func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
}

  


class PlayerViewController: AVPlayerViewController, UIGestureRecognizerDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        print(navigationController?.navigationBar.backItem?.title == )
//        addMenuButton()
    }
    //MARK:- NavbarTitle
    func SetNavigationBar(controller : UIViewController,Left:Bool,Right:Bool,Title:String,IsSettingVC:Bool = false,IsGreen: Bool = false, IsShadow : Bool = false)
    {
        
        controller.navigationController?.navigationBar.isHidden = false
        // controller.navigationController?.navigationBar.isTranslucent = true
        
        // controller.navigationController?.navigationBar.tintColor = colors.white.value;
        controller.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        controller.navigationController?.navigationBar.shadowImage = UIImage()
        controller.navigationController?.navigationBar.isTranslucent = true
        controller.navigationController?.view.backgroundColor = .clear
        controller.navigationItem.title = Title
        controller.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: CustomFont.bold.returnFont(18.0),NSAttributedString.Key.foregroundColor : UIColor.white]
        //    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        if Left{
            let btnLeft = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            btnLeft.addTarget(self, action: #selector(self.btnBackAction), for: .touchUpInside)
            if IsGreen{
                btnLeft.setImage(UIImage.init(named: "imgBackGreen"), for: .normal)
            }else{
                if IsShadow{
//                    btnLeft.addNormalShaddow()
                }
                
                btnLeft.setImage(UIImage.init(named: "ic_sideMenu"), for: .normal)
            }
            
            btnLeft.layer.setValue(controller, forKey: "controller")
            let LeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            LeftView.addSubview(btnLeft)
            
            let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: LeftView)
            btnLeftBar.style = .plain
            controller.navigationItem.leftBarButtonItem = btnLeftBar
            
        }
        if Right{
            let btnRight = UIButton.init()
            btnRight.setImage(UIImage.init(named: "ic_SOSBtn"), for: .normal)
            btnRight.layer.setValue(controller, forKey: "controller")
            btnRight.addTarget(self, action: #selector(self.EditProfile), for: .touchUpInside)
            
            let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: btnRight)
            btnRightBar.style = .plain
            controller.navigationItem.rightBarButtonItem = btnRightBar
            
        }
    }
    func textfieldRightbtn(image : UIImage, textfield : UITextField){
        let btn = UIButton(frame: CGRect(x: textfield.frame.width - 30, y: textfield.frame.height / 2 - 15, width: 30, height: 30))
        btn.setImage(image, for: .normal)
        btn.tag = textfield.tag
                btn.addTarget(self, action: #selector(iconAction(sender:)), for: .touchUpInside)
        textfield.rightView = btn
        textfield.rightViewMode = .always
    }
    
    @objc func iconAction(sender: UIButton){
//        self.onTxtBtnPressed!(sender.tag)
    }
    
    
    @objc func EditProfile()
    {
    print("Edit Profile")

    }
    
    @objc func btnBackAction() {
    if self.navigationController?.children.count == 1 {
    // if SingletonClass.sharedInstance.isPresented {
    // SingletonClass.sharedInstance.isPresented = false
    self.navigationController?.dismiss(animated: true, completion: nil)
    // } else {
    // appDel.navigateToLogin()
    // }
    }
    else {
    self.navigationController?.popViewController(animated: true)
    }
    }

    //------

    func BackNavbarButton(){
        let button1 = UIBarButtonItem(image: #imageLiteral(resourceName: "imgBackNavBarButton"), style: .plain, target: self, action: #selector(backAction)) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.leftBarButtonItem  = button1
    }
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
}
