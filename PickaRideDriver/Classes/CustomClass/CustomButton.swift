//
//  CustomButton.swift
//  PickARide User
//
//  Created by Apple on 14/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import Foundation
import AVKit

class submitButton : UIButton
{
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        self.backgroundColor = colors.submitButtonColor.value
        self.clipsToBounds = true
        self.setTitleColor(colors.white.value, for: .normal)
        self.titleLabel?.font = CustomFont.medium.returnFont(18)
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
class cancelButton : UIButton
{
    @IBInspectable var isCancel : Bool = false
    @IBInspectable var isNotCancel : Bool = false
    override func awakeFromNib() {
        if isCancel{
            self.layer.cornerRadius = 4
            self.backgroundColor = UIColor(hexString: "#F4586C")
            self.clipsToBounds = true
            self.setTitleColor(colors.white.value, for: .normal)
            self.titleLabel?.font = CustomFont.medium.returnFont(14)
        }else if isNotCancel{
            self.layer.cornerRadius = 4
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.init(hexString: "#7F7F7F").cgColor
            self.clipsToBounds = true
            self.setTitleColor(UIColor.init(hexString: "#7F7F7F"), for: .normal)
            self.titleLabel?.font = CustomFont.medium.returnFont(14)
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
