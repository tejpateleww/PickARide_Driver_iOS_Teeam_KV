//
//  CustomView.swift
//  PickARide User
//
//  Created by Apple on 14/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import Foundation
import AVKit

class viewWithClearBg : UIView {
    override func awakeFromNib() {
        self.backgroundColor = .clear
    }
}

class loginView : UIView {
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        self.layer.borderColor = colors.loginViewColor.value.cgColor
        self.layer.borderWidth = 1
    }
}
class RegisterView : UIView {
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        self.layer.borderColor = colors.loginViewColor.value.cgColor
        self.layer.borderWidth = 1
    }
}
class verifyPinView : UIView {
    override func awakeFromNib() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 4
        self.layer.borderColor = colors.loginViewColor.value.cgColor
        self.layer.borderWidth = 1
    }
}
class changePasswordView : UIView {
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        self.layer.borderColor = colors.loginViewColor.value.cgColor
        self.layer.borderWidth = 1
    }
}
class whereAreYouGoingView : UIView {
    override func awakeFromNib() {
        self.layer.cornerRadius = 9
        self.layer.borderColor = colors.loginViewColor.value.cgColor
        self.layer.borderWidth = 1
    }
}
class seperatorView : UIView {
   
    override func awakeFromNib() {
        self.backgroundColor = colors.seperatorColor.value
    }
}
class selectDestinationView : UIView {
    override func awakeFromNib() {
        self.clipsToBounds = true
        
        self.layer.cornerRadius = 16
        self.layer.shadowColor = colors.black.value.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.4
        self.layer.masksToBounds = false
    }
}
class viewBorder : UIView {
    @IBInspectable var isViewRadius : Bool = false
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        self.layer.borderColor = colors.loginViewColor.value.cgColor
        self.layer.borderWidth = 1
    }
}
class myOfferView : UIView {
    @IBInspectable var isViewRadius : Bool = false
    //@IBInspectable var isRadius : Bool = false
    @IBInspectable var isShadow : Bool = false
    override func awakeFromNib() {
        if isViewRadius{
            self.layer.cornerRadius = 8
        }else if isShadow{
            self.layer.cornerRadius = 5
            self.clipsToBounds = false
            self.layer.masksToBounds = true;
            self.backgroundColor = UIColor.white
            self.layer.shadowColor = colors.loginViewColor.value.cgColor
            self.layer.shadowOpacity = 1
            self.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
            self.layer.shadowRadius = 4.0
            self.layer.masksToBounds = false
        }
    }
}
class MyRidesView : UIView {
    @IBInspectable var isShadow : Bool = false
    override func awakeFromNib() {
        if isShadow{
            self.clipsToBounds = false
            self.backgroundColor = UIColor.white
            self.layer.shadowColor = colors.loginViewColor.value.cgColor
            self.layer.shadowOpacity = 1
            self.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
            self.layer.shadowRadius = 4.0
        }
    }
}
class PaymentView : UIView {
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
         self.clipsToBounds = true
        
        self.layer.masksToBounds = false
        
        self.layer.shadowColor = colors.black.value.cgColor
        self.layer.shadowOffset = CGSize(width: -1, height: 1.0)
        self.layer.shadowOpacity = 0.16
        self.layer.shadowRadius = 3.0
    }
}
class walletHistoryView : UIView {
  
    @IBInspectable var isBGView : Bool = false
    @IBInspectable var isShadowView : Bool = false
    override func awakeFromNib() {
        if isBGView {
            self.layer.cornerRadius = 4
            self.clipsToBounds = true
           
           self.layer.masksToBounds = false
            self.layer.shadowColor = colors.black.value.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
            self.layer.shadowOpacity = 0.22
            self.layer.shadowRadius = 11.0
            
    
        } else if isShadowView {
            self.layer.cornerRadius = 4
            self.clipsToBounds = true
           
           self.layer.masksToBounds = false
            self.layer.shadowColor = colors.black.value.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
            self.layer.shadowOpacity = 0.2
            self.layer.shadowRadius = 3.0
            
            
           // self.layer.borderWidth = 1
           // self.layer.borderColor = UIColor(hexString: "#E4E9F2").withAlphaComponent(0.6).cgColor
        }
       
        
       
    }
}
class addCardDetailsView : UIView {
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(hexString: "#707070").withAlphaComponent(0.2).cgColor
       
    }
}
class savedPlacesView : UIView {
    @IBInspectable var isShadow : Bool = false
    override func awakeFromNib() {
         if isShadow{
            self.layer.cornerRadius = self.layer.bounds.height / 2
            self.clipsToBounds = false
            self.layer.masksToBounds = true;
            self.backgroundColor = UIColor.white
            self.layer.shadowColor = colors.loginViewColor.value.cgColor
            self.layer.shadowOpacity = 1
            self.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
            self.layer.shadowRadius = 4.0
            self.layer.masksToBounds = false
        }
    }
}

class settingsView : UIView {
    @IBInspectable var isUserProfile : Bool = false
    @IBInspectable var isShadowView : Bool = false
    override func awakeFromNib() {
         if isUserProfile{
            self.layer.cornerRadius = self.frame.size.height / 2
            self.clipsToBounds = true
         } else if isShadowView {
            self.clipsToBounds = false
            self.layer.masksToBounds = true
            self.layer.cornerRadius = self.frame.size.height / 2
            self.backgroundColor = UIColor.white
            self.layer.shadowColor = colors.loginViewColor.value.cgColor
            self.layer.shadowOpacity = 1
            self.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
            self.layer.shadowRadius = 4.0
           
         }
    }
}

class suggestedTaxiView : UIView {
    @IBInspectable var isMainView : Bool = false
    @IBInspectable var isBGView : Bool = false
    @IBInspectable var isTopView : Bool = false
    
    override func awakeFromNib() {
        if isBGView {
            self.layer.cornerRadius = 4
            self.layer.borderColor = colors.submitButtonColor.value.cgColor
        } else if isMainView {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 16
            self.clipsToBounds = false
            self.backgroundColor =  colors.white.value
            self.layer.shadowColor = colors.black.value.cgColor
            self.layer.shadowOpacity = 0.3
            self.layer.shadowOffset = CGSize(width: -4.0, height: 0.0)
            self.layer.shadowRadius = 8.0
          
        } else if isTopView {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 6
            self.backgroundColor = UIColor.white
            self.layer.shadowColor = colors.loginViewColor.value.cgColor
            self.layer.shadowOpacity = 1
            self.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
            self.layer.shadowRadius = 4.0
        }
    }
}

class currentRideView : UIView {
    @IBInspectable var isMainView : Bool = false
    @IBInspectable var isTopView : Bool = false
    @IBInspectable var isRoundView : Bool = false
    @IBInspectable var isRIDEGOBgVIew : Bool = false
    override func awakeFromNib() {
        if isRoundView {
            self.layer.cornerRadius = self.frame.size.height / 2
            self.clipsToBounds = true
        } else if isMainView {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 16
            self.clipsToBounds = false
            self.backgroundColor =  colors.white.value
            self.layer.shadowColor = colors.black.value.cgColor
            self.layer.shadowOpacity = 0.3
            self.layer.shadowOffset = CGSize(width: -4.0, height: 0.0)
            self.layer.shadowRadius = 8.0
          
        } else if isTopView {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 6
            self.backgroundColor = UIColor.white
            self.layer.shadowColor = colors.loginViewColor.value.cgColor
            self.layer.shadowOpacity = 1
            self.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
            self.layer.shadowRadius = 4.0
        } else if isRIDEGOBgVIew {
            self.layer.cornerRadius = self.frame.size.height / 2
            self.clipsToBounds = true
            self.backgroundColor = colors.submitButtonColor.value
        }
    }
}

class customviewRadius : UIView{
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
    }
}

class customImagewithShadow: UIView {
    @IBInspectable var istopRadius : Bool = false
    @IBInspectable var isBottomRadius : Bool = false
    @IBInspectable var isShadow : Bool = false
    override func awakeFromNib() {
        if istopRadius{
            self.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 4)
        }else if isBottomRadius{
            self.roundCorners(corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 4)
        }else if isShadow{
            self.layer.cornerRadius = 5
            self.clipsToBounds = false
            self.layer.masksToBounds = true;
            self.backgroundColor = UIColor.clear
            self.layer.shadowColor = UIColor.init(hexString: "#E4E9F2").cgColor
            self.layer.shadowOpacity = 0.50
            self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.layer.shadowRadius = 10.0
            self.layer.masksToBounds = false
        }
    }
}
extension UIView{
    func createDottedLine(width: CGFloat, color: CGColor) {
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = UIColor.init(hexString: "#303A55").cgColor
        caShapeLayer.lineWidth = width
        caShapeLayer.lineDashPattern = [6,6]
        let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: 0, y: 7), CGPoint(x: self.bounds.width, y: 7)]
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        layer.addSublayer(caShapeLayer)
    }
    func roundCorners(corners:CACornerMask, radius: CGFloat) {
          self.layer.cornerRadius = radius
          self.layer.maskedCorners = corners
       }
}
class blurView : UIView {
    override func awakeFromNib() {
        self.backgroundColor = .clear
        setUpBlurView()
    }
    
    func setUpBlurView() {
        //        self.customTabBarController = (self.tabBarController as! CustomTabBarVC)
        
        //If iOS 13 is available, add blur effect:
        if #available(iOS 13.0, *) {
            //check if transparency is reduced in system accessibility settings..
            if UIAccessibility.isReduceTransparencyEnabled == true {
                let backView = UIView(frame: self.bounds)
                backView.backgroundColor =  colors.white.value.withAlphaComponent(0.67)//UIColor(red: 8/255, green: 93/255, blue: 127/255, alpha: 0.67)
            } else {
                
                
                let blurEffect = UIBlurEffect(style: .dark)
                let bluredEffectView = UIVisualEffectView(effect: blurEffect)
                bluredEffectView.frame = self.bounds
                
                let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
                let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
                vibrancyEffectView.frame = bluredEffectView.bounds
                
                bluredEffectView.layer.masksToBounds = true
                bluredEffectView.contentView.addSubview(vibrancyEffectView)
                self.addSubview(bluredEffectView)
                //                self.bringSubviewToFront(viewMain)
            }
        } else {
            if UIAccessibility.isReduceTransparencyEnabled == false {
                let backView = UIView(frame: self.bounds)
                backView.backgroundColor = colors.white.value.withAlphaComponent(0.67) //UIColor(red: 8/255, green: 93/255, blue: 127/255, alpha: 0.67)
                
            } else {
                
                
                let blurEffect = UIBlurEffect(style: .dark)
                let bluredEffectView = UIVisualEffectView(effect: blurEffect)
                bluredEffectView.frame = self.bounds
                
                let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
                let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
                vibrancyEffectView.frame = bluredEffectView.bounds
                
                bluredEffectView.layer.masksToBounds = true
                bluredEffectView.contentView.addSubview(vibrancyEffectView)
                self.addSubview(bluredEffectView)
                
                //                self.bringSubviewToFront(viewMain)
            }
        }
    }
}

//class themeViewChatSender: UIView {
//    override func awakeFromNib() {
//           super.awakeFromNib()
//        
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let bounds: CGRect = self.bounds
//        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: ([ .topRight, .bottomLeft, .bottomRight]), cornerRadii: CGSize(width: 12.0, height: 12.0))
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = bounds
//        maskLayer.path = maskPath.cgPath
//        self.layer.mask = maskLayer
//    }
//}
//
//class themeViewChatReceiver: UIView {
//    override func awakeFromNib() {
//           super.awakeFromNib()
//        
//    }
//    
//    override func layoutSubviews() {
//    super.layoutSubviews()
//        let bounds: CGRect = self.bounds
//        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: ([.topLeft, .bottomLeft, .bottomRight]), cornerRadii: CGSize(width: 12.0, height: 12.0))
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = bounds
//        maskLayer.path = maskPath.cgPath
//        self.layer.mask = maskLayer
//    }
//}

class chatScreenView : UIView {
    
    @IBInspectable var isSenderView : Bool = false
    @IBInspectable var isReciverView : Bool = false
    
    override func awakeFromNib() {
     //   self.roundCorners(corners: [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMaxYCorner], radius: 12)
//        if isSenderView {
//            self.backgroundColor = UIColor(hexString: "#00AA7E")
//        } else if isReciverView {
//            self.backgroundColor = UIColor(hexString: "#DEE2EA")
//        }
    }
    
    override func layoutSubviews() {
    super.layoutSubviews()
        if isSenderView {
            self.backgroundColor = UIColor(hexString: "#00AA7E")
            let bounds: CGRect = self.bounds
            let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: ([ .topLeft, .topRight, .bottomLeft]), cornerRadii: CGSize(width: 12.0, height: 12.0))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = maskPath.cgPath
            self.layer.mask = maskLayer
        } else if isReciverView {
            self.backgroundColor = UIColor(hexString: "#DEE2EA")
            let bounds: CGRect = self.bounds
            let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: ([.topLeft, .bottomRight, .topRight]), cornerRadii: CGSize(width: 12.0, height: 12.0))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = maskPath.cgPath
            self.layer.mask = maskLayer
        }
        
    }
}
