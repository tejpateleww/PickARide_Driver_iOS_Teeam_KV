//
//  BaseVC.swift
//  Cluttrfly-HAULER Driver
//
//  Created by Raju Gupta on 15/02/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit
//import LGSideMenuController
import AVKit

class BaseVC: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK:- Variables And Properties
    var onTxtBtnPressed: ( (Int) -> () )?
    
    //MARK:- View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        print(navigationController?.navigationBar.backItem?.title == )
//        addMenuButton()
    }
    
    //MARK:- Custom Methods
    
//    func NavBarTitle(isOnlyTitle : Bool = true, img : UIImage, title : String, controller:UIViewController){
//
////        UIApplication.shared.statusBarStyle = .lightContent
////        controller.navigationController?.isNavigationBarHidden = false
////        controller.navigationController?.navigationBar.isOpaque = false;
////        controller.navigationController?.view.backgroundColor = .clear
////        controller.navigationController?.navigationBar.isTranslucent = true
////
////        controller.navigationController?.navigationBar.barTintColor = colors.white.value;
////        controller.navigationController?.navigationBar.tintColor = colors.white.value;
////        controller.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
////        controller.navigationController?.navigationBar.shadowImage = UIImage()
//        let height: CGFloat = 100 //whatever height you want to add to the existing height
//            let bounds = self.navigationController!.navigationBar.bounds
//            self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
//        controller.navigationController?.navigationBar.tintColor = colors.white.value;
//        if isOnlyTitle{
////            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: CustomFont.QuicksandBold.returnFont(22.0)]
//            let customView = UIView(frame: CGRect(x: 0.0, y: 20, width: 100.0, height: 80))
//            customView.backgroundColor = UIColor.clear
//            let label = UILabel(frame: CGRect(x: 0.0, y: 25, width: 355.0, height: 44.0))
//            label.text = title
//            label.textColor = .white
//            label.textAlignment = NSTextAlignment.center
//            label.backgroundColor = UIColor.clear
//            label.font = CustomFont.semibold.returnFont(20.0)
//            customView.addSubview(label)
//
//            let leftButton = UIBarButtonItem(customView: customView)
//            self.navigationItem.leftBarButtonItem = leftButton
//        }else{
//            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: CustomFont.semibold.returnFont(20.0)]
//            let customView = UIView(frame: CGRect(x: 0.0, y: 20, width: self.view.frame.width - 40 - 40, height: 80))
//            customView.backgroundColor = UIColor.red
//
//            let button = UIButton.init(type: .custom)
//            button.setImage(img, for: .normal)
//            button.imageView?.contentMode = .scaleAspectFill
//            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
//            button.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
//            button.addTarget(self, action: #selector(BackButtonWithTitle(button:)), for: .touchUpInside)
//
//
//            let marginX = CGFloat(button.frame.origin.x + button.frame.size.width + 10)
//            let label = UILabel(frame: CGRect(x: marginX - 16, y: 0, width: 300.0, height: 40.0))
////            label.backgroundColor = .red
//            label.text = title
//            label.textColor = .white
//            label.textAlignment = NSTextAlignment.center
//            label.backgroundColor = UIColor.blue
//            label.font = CustomFont.semibold.returnFont(20.0)
//            customView.addSubview(label)
//            customView.addSubview(button)
//
//            let leftButton = UIBarButtonItem(customView: customView)
//            self.navigationItem.leftBarButtonItem = leftButton
//        }
//    }
//
//    @objc func BackButtonWithTitle(button: UIButton) {
//        self.navigationController?.popViewController(animated: true)
//    }
    
    
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
        controller.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: CustomFont.bold.returnFont(18.0),NSAttributedString.Key.foregroundColor : UIColor.black]
        //    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        if Left{
            let btnLeft = UIButton(frame: CGRect(x: -12, y: 0, width: 40, height: 40))
            btnLeft.addTarget(self, action: #selector(self.btnBackAction), for: .touchUpInside)
            if IsGreen{
                btnLeft.setImage(UIImage.init(named: "imgBackGreen"), for: .normal)
            }else{
                if IsShadow{
//                    btnLeft.addNormalShaddow()
                }
                
                btnLeft.setImage(UIImage.init(named: "nav_back"), for: .normal)
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
            btnRight.setImage(UIImage.init(named: "Nav_Edit_icon"), for: .normal)
            btnRight.layer.setValue(controller, forKey: "controller")
            btnRight.addTarget(self, action: #selector(self.EditProfile), for: .touchUpInside)
            
            let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: btnRight)
            btnRightBar.style = .plain
            controller.navigationItem.rightBarButtonItem = btnRightBar
            
        }
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
    
    func textfieldRightbtn(image : UIImage, textfield : UITextField){
//        textfield.rightViewMode = .always
//        textfield.rightViewMode = UITextField.ViewMode.always
//        let vwRight = UIView(frame: CGRect(x: textfield.frame.width - 66, y: 0, width: 50, height: textfield.frame.height))
//
//        let frame =  CGRect(x: 0, y: 0, width: 50, height: vwRight.frame.height)
//
//        let button = UIButton(frame: frame)
////         let image1 = UIImage(named: "imgVisiblePw")
//        button.setImage(image, for: .normal)
//        button.tag = textfield.tag
//        button.addTarget(self, action: #selector(iconAction(sender:)), for: .touchUpInside)
//        button.imageView?.contentMode = .scaleAspectFit
////        button.isUserInteractionEnabled = true
//        vwRight.addSubview(button)
//        textfield.rightView = vwRight
//         imageView1.contentMode = .scaleAspectFit
        
        let btn = UIButton(frame: CGRect(x: textfield.frame.width - 30, y: textfield.frame.height / 2 - 15, width: 30, height: 30))
        btn.setImage(image, for: .normal)
        btn.tag = textfield.tag
                btn.addTarget(self, action: #selector(iconAction(sender:)), for: .touchUpInside)
        textfield.rightView = btn
        textfield.rightViewMode = .always
    }
    
    @objc func iconAction(sender: UIButton){
        self.onTxtBtnPressed!(sender.tag)
    }
    
    //menu button
    func addMenuButton(){
        let btn = UIButton(frame: CGRect(x: 20, y: 20, width: 30, height: 30))
        btn.setImage(UIImage(named: "imgMenu"), for: .normal)
        btn.addTarget(self, action:  #selector(MenuTap), for: .touchUpInside)
        
        let leftItem = UIBarButtonItem(customView: btn)
        
//        let leftitem = UIBarButtonItem(image: #imageLiteral(resourceName: "imgMenu"), style: .done, target: self, action: #selector(MenuTap))
//        leftitem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        UINavigationItem.accessibilityNavigationStyle()
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    @objc func MenuTap(){
//        sideMenuController?.showLeftView()
        print("Menu Tapped")
    }
    
    func blankNavBtn(){
        self.navigationItem.hidesBackButton = true
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
                
                btnLeft.setImage(UIImage.init(named: "imgBack"), for: .normal)
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
            btnRight.setImage(UIImage.init(named: "Nav_Edit_icon"), for: .normal)
            btnRight.layer.setValue(controller, forKey: "controller")
            btnRight.addTarget(self, action: #selector(self.EditProfile), for: .touchUpInside)
            
            let btnRightBar : UIBarButtonItem = UIBarButtonItem.init(customView: btnRight)
            btnRightBar.style = .plain
            controller.navigationItem.rightBarButtonItem = btnRightBar
            
        }
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

