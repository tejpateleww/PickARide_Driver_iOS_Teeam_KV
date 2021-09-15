//
//  CustomButton.swift
//  PickARide User
//
//  Created by Apple on 14/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import Foundation
import AVKit
class themeButton : UIButton{
    @IBInspectable var isShadow : Bool = false
    @IBInspectable var Font_Size : CGFloat = 14.0
    @IBInspectable public var isbold: Bool = false
    @IBInspectable public var isMedium: Bool = false
    @IBInspectable public var islight: Bool = false
    @IBInspectable var Font_Color = UIColor.white
    @IBInspectable public var isRound: Bool = false
    @IBInspectable var isthemeBg : Bool = false
    
    var activityIndicator: UIActivityIndicatorView!
    var originalButtonText: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if isRound{
            self.layer.cornerRadius = self.frame.height/2
        }else{
            self.layer.cornerRadius = 4
         
        }
     
        if isthemeBg{
            self.tintColor = Font_Color
            self.backgroundColor = themeColor
            if isShadow == true {
                
                addShadow()
            }
        }else{
            self.backgroundColor = .clear
        }
        
        if isbold{
            self.titleLabel?.font = CustomFont.bold.returnFont(Font_Size)
        }else if isMedium{
            self.titleLabel?.font = CustomFont.medium.returnFont(Font_Size)
        }else if islight {
            self.titleLabel?.font = CustomFont.light.returnFont(Font_Size)
        }else{
            self.titleLabel?.font = CustomFont.regular.returnFont(Font_Size)
        }
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }
    
    func addShadow(){
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(hexString: "#222B45").cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 10)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 8
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func showLoading() {
            isEnabled = false
            originalButtonText = self.titleLabel?.text

            self.setTitle("", for: .normal)
            if (activityIndicator == nil) {
                activityIndicator = createActivityIndicator()
            }

            showSpinning()
        }

        func hideLoading() {
            isEnabled = true
            self.setTitle(originalButtonText, for: .normal)
            activityIndicator.stopAnimating()
        }

        private func createActivityIndicator() -> UIActivityIndicatorView {
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.hidesWhenStopped = true
            activityIndicator.color = .white
            return activityIndicator
        }

        private func showSpinning() {
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(activityIndicator)
            centerActivityIndicatorInButton()
            activityIndicator.startAnimating()
        }

        private func centerActivityIndicatorInButton() {
            let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
            self.addConstraint(xCenterConstraint)

            let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
            self.addConstraint(yCenterConstraint)
        }

        override var isEnabled: Bool {
            didSet {
                UIView.animate(withDuration: 0.3) {
                    self.backgroundColor = self.isEnabled ? themeColor : themeColor
                }
            }
        }
    
}

class submitButton : UIButton
{
    var activityIndicator: UIActivityIndicatorView!
    var originalButtonText: String?
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        self.backgroundColor = colors.submitButtonColor.value
        self.clipsToBounds = true
        self.setTitleColor(colors.white.value, for: .normal)
        self.titleLabel?.font = CustomFont.medium.returnFont(18)
    }
    
    func showLoading() {
            isEnabled = false
            originalButtonText = self.titleLabel?.text

            self.setTitle("", for: .normal)
            if (activityIndicator == nil) {
                activityIndicator = createActivityIndicator()
            }

            showSpinning()
        }

        func hideLoading() {
            isEnabled = true
            self.setTitle(originalButtonText, for: .normal)
            activityIndicator.stopAnimating()
        }

        private func createActivityIndicator() -> UIActivityIndicatorView {
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.hidesWhenStopped = true
            activityIndicator.color = .white
            return activityIndicator
        }

        private func showSpinning() {
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(activityIndicator)
            centerActivityIndicatorInButton()
            activityIndicator.startAnimating()
        }

        private func centerActivityIndicatorInButton() {
            let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
            self.addConstraint(xCenterConstraint)

            let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
            self.addConstraint(yCenterConstraint)
        }

        override var isEnabled: Bool {
            didSet {
                UIView.animate(withDuration: 0.3) {
                    self.backgroundColor = self.isEnabled ? themeColor : themeColor
                }
            }
        }
}

class loginScreenButton : UIButton
{
    @IBInspectable var isForgotPassword : Bool = false
    @IBInspectable var issignUp : Bool = false
    override func awakeFromNib() {
        if isForgotPassword {
            self.setTitleColor(colors.black.value, for: .normal)
            self.titleLabel?.font = CustomFont.regular.returnFont(13)
        } else if issignUp {
            
            self.setunderline(title: self.titleLabel?.text ?? "", color: colors.submitButtonColor.value, font: CustomFont.medium.returnFont(14))
        }
    }
}
class ResendCodeButton : UIButton
{
  
   
    override func awakeFromNib() {
      
            self.setTitleColor(colors.submitButtonColor.value, for: .normal)
            self.titleLabel?.font = CustomFont.medium.returnFont(15)
        
    }
}
class MyofferScreenButton : UIButton
{
    @IBInspectable var isApply : Bool = false
    @IBInspectable var isUseNow : Bool = false
    override func awakeFromNib() {
        if isApply {
            self.setTitleColor(colors.submitButtonColor.value, for: .normal)
            self.titleLabel?.font = CustomFont.medium.returnFont(18)
        } else if isUseNow {
            self.setTitleColor(colors.submitButtonColor.value, for: .normal)
            self.titleLabel?.font = CustomFont.medium.returnFont(13)
        }
    }
}

class MyRidesButton : UIButton
{
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        self.backgroundColor = colors.submitButtonColor.value
        self.clipsToBounds = true
        self.setTitleColor(colors.white.value, for: .normal)
        self.titleLabel?.font = CustomFont.medium.returnFont(15)
    }
}

class SegmentButton : UIButton
{
    override func awakeFromNib() {
        self.setTitleColor(colors.white.value, for: .normal)
        self.setTitleColor(themeColor, for: .selected)
        self.setTitleColor(themeColorOffGrey, for: .normal)
        self.titleLabel?.font = CustomFont.medium.returnFont(15)
    }
}

class SavedPlaceButton : UIButton
{
    @IBInspectable var isAddButton : Bool = false
    override func awakeFromNib() {
        if isAddButton {
            self.setTitleColor(colors.submitButtonColor.value, for: .normal)
            self.titleLabel?.font = CustomFont.medium.returnFont(17)
        }
    }
}
class scheduleRideButton : UIButton {
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        self.layer.borderColor = colors.submitButtonColor.value.cgColor
        self.layer.borderWidth = 1
        self.setTitleColor(colors.submitButtonColor.value, for: .normal)
        self.titleLabel?.font = CustomFont.medium.returnFont(18)
    }
}
class CancelButton : UIButton
{
    @IBInspectable var isCancel : Bool = false
    @IBInspectable var isNotCancel : Bool = false
    @IBInspectable var Font_Size : CGFloat = 14.0
    override func awakeFromNib() {
        if isCancel{
            self.layer.cornerRadius = 4
            self.backgroundColor = UIColor(hexString: "#F4586C")
            self.clipsToBounds = true
            self.setTitleColor(colors.white.value, for: .normal)
            self.titleLabel?.font = CustomFont.medium.returnFont(Font_Size)
        }else if isNotCancel{
            self.layer.cornerRadius = 4
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.init(hexString: "#7F7F7F").cgColor
            self.clipsToBounds = true
            self.setTitleColor(UIColor.init(hexString: "#7F7F7F"), for: .normal)
            self.titleLabel?.font = CustomFont.medium.returnFont(Font_Size)
        }
    }
}
class paymentSucessFullyButton : UIButton {
    override func awakeFromNib() {
        self.layer.cornerRadius = 7
        self.layer.borderWidth = 1
        self.layer.borderColor = colors.loginPlaceHolderColor.value.withAlphaComponent(0.14).cgColor
        self.setTitleColorFont(title: self.titleLabel?.text ?? "", color: colors.submitButtonColor, font: CustomFont.regular.returnFont(17))
    }
}

class SubmitButton : UIButton {
    
    override func awakeFromNib() {
        self.titleLabel?.font = UIFont.bold(ofSize: FontsSize.Tiny)
        self.backgroundColor = themeColor
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.white, for: .selected)
        self.cornerRadius = 5
    }
}
class CommonButton : UIButton {
    override func awakeFromNib() {}
}
