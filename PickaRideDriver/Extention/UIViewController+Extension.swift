//
//  UIViewController+Extension.swift
//  Qwnched-Delivery
//
//  Created by EWW074 - Sj's iMAC on 26/08/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation
import UIKit
import MKProgress

extension UIViewController {
    
    
    //---Activity Indicator

    //------
    
    class var storyboardID : String {
            return "\(self)"
        }
        
        static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
            return appStoryboard.viewController(viewControllerClass: self)
        }
    
    func setNavBarWithMenuORBack(Title:String,LetfBtn : String, IsNeedRightButton:Bool , RightButton : String,isTranslucent : Bool , TintColour : UIColor = UIColor.white , TitleColour : UIColor)
    {
        self.navigationItem.title = Title//.uppercased()
        self.navigationController?.isNavigationBarHidden = false
        //    self.navigationController?.navigationBar.isOpaque = false
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.tintColor = TintColour
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : TitleColour , NSAttributedString.Key.font : CustomFont.medium.returnFont(22.0)]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        if LetfBtn == "Hide" {
            navigationItem.hidesBackButton = true
        }
        
        if IsNeedRightButton == true
        {
            let button1 = UIButton(type: UIButton.ButtonType.custom)
            button1.setImage(UIImage(), for:.normal)
            button1.imageView?.contentMode = .scaleAspectFit
            button1.addTarget(self, action: #selector(BtnAction), for:.touchUpInside)
            button1.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
            let barButton1 = UIBarButtonItem(customView: button1)
            
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.rightBarButtonItem =  barButton1
        }
    }
    
    @objc func BtnAction(){
        
    }
    
    func addNavBarImage(isLeft:Bool, isRight:Bool) {
        if isLeft {
            var w = 133
            var h = 91
            
            if DeviceType.hasTopNotch {
                w = 173
                h = 106
            }
            let img = UIImageView(frame: CGRect(x: 0, y: 0, width: w, height: h))
            img.image = UIImage(named: "nav_leftCorner.png")
            self.view.addSubview(img)
//            img.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//            img.heightAnchor.constraint(equalToConstant: 106).isActive = true
//            img.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            
        }
        if isRight {
            var w = 90
            var h = 25
            if DeviceType.hasTopNotch {
                w = 110
                h = 40
            }
            let img = UIImageView(frame: CGRect(x: Int(self.view.frame.size.width) - w, y: 0, width: w, height: h))
            img.image = UIImage(named: "nav_rightCorner.png")
            self.view.addSubview(img)
//            img.translatesAutoresizingMaskIntoConstraints = false
//            img.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//            img.heightAnchor.constraint(equalToConstant: 40).isActive = true
//            img.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            
        }
    }
    
    func showAlert(title: String = "", message: String, alertActions : [UIAlertAction])
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if alertActions.count <= 0
        {
            let okAlert = UIAlertAction(title: "Ok".Localized(), style: .cancel, handler: nil)
            alertController.addAction(okAlert)
            
        }else
        {
            for alert in alertActions {
                alertController.addAction(alert)
            }
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
}

class MarkerPinView: UIView {
    @IBInspectable var markerImage: UIImage?
//    @IBInspectable var imageview: UIImageView!
    override func awakeFromNib() {
           super.awakeFromNib()
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let imageview = UIImageView()
//        if markerImage != nil{
            imageview.image = markerImage
//        }else{
//            imageview.image = UIImage(named: "profile_placeholder_2")
//        }
        
        imageview.frame = self.frame
        imageview.contentMode = .scaleAspectFit
//        imageview.cornerRadius = self.frame.size.height / 2
//        imageview.borderWidth = 3
//        imageview.borderColor = .white
        imageview.clipsToBounds = true
//        self.cornerRadius = self.frame.size.height / 2
//        self.borderWidth = 2
//        self.borderColor = ThemeColor.primary
        self.clipsToBounds = true
        self.backgroundColor = .clear
        self.addSubview(imageview)
    }
}
