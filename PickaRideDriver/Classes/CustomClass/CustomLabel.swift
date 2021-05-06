//
//  CustomLabel.swift
//  PickARide User
//
//  Created by Apple on 14/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import Foundation
import UIKit

class TitleLabel : UILabel {
    override func awakeFromNib() {
        
            self.font = CustomFont.medium.returnFont(37)
            self.textColor = colors.loginPlaceHolderColor.value
       
    }
}


class loginScreenLabel : UILabel {
    @IBInspectable var isWelcome : Bool = false
    @IBInspectable var istitle : Bool = false
    @IBInspectable var isORlbl : Bool = false
    @IBInspectable var isDontHaveAccount : Bool = false
    override func awakeFromNib() {
        if isWelcome {
            self.font = CustomFont.regular.returnFont(26)
            self.textColor = colors.loginText.value
        } else if istitle {
            self.font = CustomFont.bold.returnFont(33)
            self.textColor = colors.loginText.value
        } else if isORlbl {
            self.font = CustomFont.regular.returnFont(14)
                self.textColor = colors.black.value
        } else if isDontHaveAccount {
            self.font = CustomFont.regular.returnFont(14)
                self.textColor = colors.black.value
        }
    }
}

class registerScreenLabel : UILabel {
    @IBInspectable var isSignUp : Bool = false
    @IBInspectable var isCountryCode : Bool = false
    override func awakeFromNib() {
        self.font = CustomFont.bold.returnFont(38)
        self.textColor = colors.loginPlaceHolderColor.value
        if isCountryCode {
            self.font = CustomFont.bold.returnFont(12)
            self.textColor = UIColor(hexString: "#8992A3")
        }
    }
}

class verifyVcLabel : UILabel {
    @IBInspectable var IsVerifyPhoneNumber : Bool = false
    @IBInspectable var IsCheckYourPhoneNumber : Bool = false
    @IBInspectable var IsnotRecive : Bool = false
    override func awakeFromNib() {
        if IsVerifyPhoneNumber {
            self.textColor = colors.loginPlaceHolderColor.value
            self.font = CustomFont.bold.returnFont(29)
          
        } else if IsCheckYourPhoneNumber {
            self.textColor = colors.phoneNumberColor.value

         
         
        } else if IsnotRecive {
            self.font = CustomFont.medium.returnFont(15)
                self.textColor = colors.loginPlaceHolderColor.value
        }
      
    }
}

class changePasswordLabel : UILabel {
    override func awakeFromNib() {
        self.textColor = colors.loginPlaceHolderColor.value
        self.font = CustomFont.medium.returnFont(28)
    }
}
class NotificationLabel: UILabel {
    @IBInspectable var isTitle:Bool = false
    
    @IBInspectable var isNotificatioTitle:Bool = false
    @IBInspectable var isNotificatioDescription:Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        if isTitle {
            self.textColor = colors.loginPlaceHolderColor.value
            self.font = CustomFont.medium.returnFont(40)
        } else if isNotificatioTitle {
            self.font = CustomFont.medium.returnFont(17)
            self.textColor = UIColor(hexString: "#242E42")
        } else if isNotificatioDescription {
            self.font = CustomFont.regular.returnFont(17)
            self.textColor = UIColor(hexString: "#242E42")
        }
        
        
    }
}
class SelectDestinationLabel : UILabel {
    @IBInspectable var isTitle:Bool = false
    @IBInspectable var isSubTitle:Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        if isTitle {
            self.textColor = colors.loginPlaceHolderColor.value
            self.font = CustomFont.regular.returnFont(18)
        } else if isSubTitle {
            self.font = CustomFont.regular.returnFont(18)
            self.textColor = colors.phoneNumberColor.value
        }
        
        
    }
}
class ForgotPasswordLabel : UILabel {
    @IBInspectable var isForgot : Bool = false
    @IBInspectable var isquestion : Bool = false
    @IBInspectable var iscountryCode : Bool = false
    @IBInspectable var isDescription : Bool = false
    
    override func awakeFromNib() {
        if isForgot{
            self.font = CustomFont.bold.returnFont(29)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isquestion{
            self.font = CustomFont.bold.returnFont(21)
            self.textColor = UIColor(hexString: "#9095A2")
        }else if iscountryCode{
            self.font = CustomFont.bold.returnFont(12)
            self.textColor = UIColor(hexString: "#8F9BB3")
        }else if isDescription{
            self.font = CustomFont.regular.returnFont(17)
            self.textColor = UIColor(hexString: "#222B45")
        }
    }
}
class myofferLabel : UILabel{
    @IBInspectable var isMyOffer : Bool = false
    @IBInspectable var isOfferDetails : Bool = false
    @IBInspectable var isvalidto: Bool = false
    
    override func awakeFromNib() {
        if isMyOffer{
            self.font = CustomFont.medium.returnFont(40)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isOfferDetails{
            self.font = CustomFont.medium.returnFont(18)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isvalidto{
            self.font = CustomFont.regular.returnFont(13)
            self.textColor = UIColor(hexString: "#ACB1C0")
        }
    }
}
class myRidesLabel : UILabel{
    @IBInspectable var isMyRides : Bool = false
    @IBInspectable var isDate : Bool = false
    @IBInspectable var isname : Bool = false
    @IBInspectable var isAddress: Bool = false
    @IBInspectable var isPrice : Bool = false
    @IBInspectable var isTotal: Bool = false
    @IBInspectable var isSelectType: Bool = false
    override func awakeFromNib() {
        if isMyRides{
            self.font = CustomFont.medium.returnFont(40)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isDate{
            self.font = CustomFont.regular.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isname{
            self.font = CustomFont.bold.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isAddress{
            self.font = CustomFont.regular.returnFont(13)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isPrice{
            self.font = CustomFont.regular.returnFont(13)
            self.textColor = UIColor(hexString: "#ACB1C0")
        }else if isTotal{
            self.font = CustomFont.bold.returnFont(18)
            self.textColor = colors.loginPlaceHolderColor.value
        } else if isSelectType {
            self.font = CustomFont.medium.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
        }
    }
}
class addPaymentlable : UILabel {
    @IBInspectable var isWallet : Bool = false
    @IBInspectable var isWalletBalance : Bool = false
    @IBInspectable var isCardNumber : Bool = false
    @IBInspectable var isExpires : Bool = false
    override func awakeFromNib() {
        if isWallet {
            self.font = CustomFont.bold.returnFont(18)
            self.textColor = colors.loginPlaceHolderColor.value
            self.textAlignment = .left
        } else if isWalletBalance {
            self.font = CustomFont.medium.returnFont(20)
            self.textColor = colors.loginPlaceHolderColor.value
            self.textAlignment = .left
        }  else if isCardNumber {
            self.font = CustomFont.bold.returnFont(18)
            self.textColor = colors.loginPlaceHolderColor.value
            self.textAlignment = .left
        } else if isExpires {
            self.font = CustomFont.medium.returnFont(13)
            self.textColor = colors.phoneNumberColor.value
            self.textAlignment = .left
        }
        
    }
}
class walletHistoryLabel : UILabel {
    @IBInspectable var isAvailableMethod : Bool = false
    @IBInspectable var isBalance : Bool = false
    @IBInspectable var ismoneyFrom : Bool = false
    @IBInspectable var istime : Bool = false
    @IBInspectable var ismoney : Bool = false
    override func awakeFromNib() {
        if isAvailableMethod {
            self.font = CustomFont.bold.returnFont(18)
            self.textColor = colors.white.value
            self.textAlignment = .center
            self.backgroundColor = colors.submitButtonColor.value
        } else if isBalance {
            self.font = CustomFont.medium.returnFont(29)
            self.textColor = colors.loginPlaceHolderColor.value
        } else if ismoneyFrom {
            self.textColor = colors.loginPlaceHolderColor.value
            self.font = CustomFont.bold.returnFont(14)
                   self.textAlignment = .left
        } else if istime {
            self.textColor = colors.phoneNumberColor.value
            self.font = CustomFont.regular.returnFont(13)
                   self.textAlignment = .left
        } else if ismoney {
            self.textColor = colors.submitButtonColor.value
            self.font = CustomFont.bold.returnFont(15)
                   self.textAlignment = .center
        }
    }
}
class addCardLabel : UILabel {
    @IBInspectable var isDetailsTitle : Bool = false
    override func awakeFromNib() {
        self.font = CustomFont.regular.returnFont(11)
        self.textColor = UIColor(hexString: "#ACB1C0")
        self.textAlignment = .left
        if isDetailsTitle {
            self.font = CustomFont.medium.returnFont(12)
            self.textColor = colors.AddCardTitleColor.value
            self.textAlignment = .left
        }
        
    }
}
class SavedPlacesLabel : UILabel{
    @IBInspectable var isSavedPlaces : Bool = false
    @IBInspectable var isHome: Bool = false
    
    override func awakeFromNib() {
        if isSavedPlaces{
            self.font = CustomFont.medium.returnFont(40)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isHome{
            self.font = CustomFont.regular.returnFont(18)
            self.textColor = colors.loginPlaceHolderColor.value
        }
    }
}



class ProfileLabel : UILabel{
    @IBInspectable var isProfille : Bool = false
    @IBInspectable var isProfileLabel : Bool = false
   
    
    override func awakeFromNib() {
        if isProfille{
            self.font = CustomFont.medium.returnFont(40)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isProfileLabel{
            self.font = CustomFont.bold.returnFont(12)
            self.textColor = UIColor(hexString: "#8F9BB3")
        }
    }
}

class ReasonforLabel : UILabel {
    @IBInspectable var isLabel : Bool = false
    
    override func awakeFromNib() {
        if isLabel{
            self.font = CustomFont.regular.returnFont(16)
            self.textColor = UIColor(hexString: "#7F7F7F")
        }
    }
}

class RideDetailLabel : UILabel{
    @IBInspectable var isRideDetails : Bool = false
    @IBInspectable var isDate : Bool = false
    @IBInspectable var isPlaceCode : Bool = false
    @IBInspectable var isPlace : Bool = false
    @IBInspectable var isAddress: Bool = false
    @IBInspectable var isPrice : Bool = false
    @IBInspectable var isTotal: Bool = false
    @IBInspectable var isPickup : Bool = false
    @IBInspectable var ispickupAddress: Bool = false
    @IBInspectable var isDestination : Bool = false
    @IBInspectable var isdestinationAddress: Bool = false
    @IBInspectable var isName : Bool = false
    @IBInspectable var isRating: Bool = false
    override func awakeFromNib() {
        if isRideDetails{
            self.font = CustomFont.medium.returnFont(40)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isDate{
            self.font = CustomFont.regular.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isPlaceCode{
            self.font = CustomFont.bold.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isPlace{
            self.font = CustomFont.regular.returnFont(15)
            self.textColor = UIColor(hexString: "#ACB1C0")
        }else if isAddress{
            self.font = CustomFont.regular.returnFont(13)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isPrice{
            self.font = CustomFont.regular.returnFont(13)
            self.textColor = UIColor(hexString: "#ACB1C0")
        } else if isTotal{
            self.font = CustomFont.bold.returnFont(18)
            self.textColor = colors.loginPlaceHolderColor.value
        } else if isPickup{
            self.font = CustomFont.medium.returnFont(11)
            self.textColor = UIColor(hexString: "#9095A2")
        }else if ispickupAddress{
            self.font = CustomFont.medium.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isDestination{
            self.font = CustomFont.medium.returnFont(11)
            self.textColor = UIColor(hexString: "#9095A2")
        }else if isdestinationAddress{
            self.font = CustomFont.medium.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isName{
            self.font = CustomFont.bold.returnFont(16)
            self.textColor = colors.loginPlaceHolderColor.value
        }else if isRating{
            self.font = CustomFont.regular.returnFont(11)
            self.textColor = UIColor(hexString: "#9095A2")
        }
    }
}

class settingLabel : UILabel {
    @IBInspectable var isUserName : Bool = false
    @IBInspectable var isUserPhoneNumber : Bool = false
    @IBInspectable var isUserEmail : Bool = false
    @IBInspectable var isCategoryName : Bool = false
    override func awakeFromNib() {
        if isUserName {
            self.font = CustomFont.medium.returnFont(18)
            self.textColor = colors.loginPlaceHolderColor.value
        } else if isUserPhoneNumber {
            self.font = CustomFont.regular.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value.withAlphaComponent(0.52)
        } else if isUserEmail {
            self.font = CustomFont.regular.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value.withAlphaComponent(0.52)
        } else if isCategoryName {
            self.font = CustomFont.regular.returnFont(18)
            self.textColor = colors.loginPlaceHolderColor.value
        }
    }
}

class suggestedRidesLabel : UILabel {
    @IBInspectable var isTitle : Bool = false
    @IBInspectable var isTaxiName : Bool = false
    @IBInspectable var isTaxiPrice : Bool = false
    @IBInspectable var isTaxiComingTime : Bool = false
    @IBInspectable var isTaxiTotalCapacity : Bool = false
    @IBInspectable var islblCardPayment : Bool = false
    @IBInspectable var isStartRideAddress : Bool = false
    @IBInspectable var isEndRideAddress : Bool = false
    
    override func awakeFromNib() {
        if isTitle {
            self.font = CustomFont.bold.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
        } else if isTaxiName {
            self.font = CustomFont.regular.returnFont(16)
            self.textColor = colors.loginPlaceHolderColor.value
        } else if isTaxiPrice {
            self.font = CustomFont.medium.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
        } else if isTaxiComingTime {
            self.font = CustomFont.bold.returnFont(11)
            self.textColor = colors.loginPlaceHolderColor.value
        } else if isTaxiTotalCapacity {
            self.font = CustomFont.regular.returnFont(11)
            self.textColor = colors.black.value
        } else if islblCardPayment {
            self.font = CustomFont.medium.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
        } else if isStartRideAddress {
            self.font = CustomFont.regular.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
            self.textAlignment = .right
        } else if isEndRideAddress {
            self.font = CustomFont.regular.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
            self.textAlignment = .left
        }
    }
}

class currentRideLabel : UILabel {
    
    @IBInspectable var isStartRideAddress : Bool = false
    @IBInspectable var isEndRideAddress : Bool = false
    @IBInspectable var isDriveName : Bool = false
    @IBInspectable var isRideGO : Bool = false
    @IBInspectable var isCarNumber : Bool = false
    @IBInspectable var isRemainigTime : Bool = false
    @IBInspectable var isRemaningTimeTitle : Bool = false
    @IBInspectable var isWeFoundTitle : Bool = false
    
    override func awakeFromNib() {
        if isStartRideAddress {
            self.font = CustomFont.regular.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
            self.textAlignment = .right
        } else if isEndRideAddress {
            self.font = CustomFont.regular.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
            self.textAlignment = .left
        } else if isDriveName {
            self.font = CustomFont.bold.returnFont(20)
            self.textColor = colors.loginPlaceHolderColor.value
        } else if isRideGO {
            self.font = CustomFont.medium.returnFont(11)
            self.textColor = colors.white.value
        } else if isCarNumber {
            self.font = CustomFont.medium.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
        } else if isRemainigTime {
            self.font = CustomFont.bold.returnFont(15)
            self.textColor = colors.submitButtonColor.value
            self.textAlignment = .left
        } else if isRemaningTimeTitle {
            self.font = CustomFont.regular.returnFont(15)
            self.textColor = colors.submitButtonColor.value
            self.textAlignment = .right
        } else if isWeFoundTitle {
            self.font = CustomFont.medium.returnFont(15)
            self.textColor = colors.loginPlaceHolderColor.value
            self.textAlignment = .center
            self.text = self.text?.uppercased()
        }
    }
}

class menuLabel : UILabel {
    @IBInspectable var isUserName : Bool = false
    @IBInspectable var isUserEmailAddress : Bool = false
    @IBInspectable var isMenuTitle : Bool = false
    override func awakeFromNib() {
        if isUserName {
            self.font = CustomFont.medium.returnFont(18)
            self.textColor = colors.white.value
        } else if isUserEmailAddress {
            self.font = CustomFont.regular.returnFont(15)
            self.textColor = colors.white.value.withAlphaComponent(0.5)
        } else if isMenuTitle {
            self.font = CustomFont.regular.returnFont(20)
            self.textColor = colors.black.value.withAlphaComponent(0.4)
        }
    }
}
class ScheduleARide : UILabel {
    override func awakeFromNib() {
        self.font = CustomFont.medium.returnFont(28)
            self.textColor = colors.loginPlaceHolderColor.value
    }
}
class RatingTripLabel : UILabel{
    override func awakeFromNib() {
        self.layer.cornerRadius = self.layer.bounds.height / 2
        self.clipsToBounds = true
    }
}
class RatingYourTripLabel : UILabel {
    @IBInspectable var isName : Bool = false
    @IBInspectable var isRidego : Bool = false
    @IBInspectable var isCarno : Bool = false
    @IBInspectable var isCarName : Bool = false
    @IBInspectable var isYourride : Bool = false
    @IBInspectable var isFeedback : Bool = false
    override func awakeFromNib() {
        
        if isName {
            self.font = CustomFont.bold.returnFont(20)
            self.textColor = colors.loginPlaceHolderColor.value
            self.textAlignment = .left
        } else if isRidego {
            self.font = CustomFont.medium.returnFont(11)
            self.textColor = colors.white.value
            self.backgroundColor = UIColor(hexString: "#00AA7E")
            //self.superview?.layer.cornerRadius = (self.superview?.layer.bounds.height)!/2
            self.textAlignment = .center
        } else if isCarno {
            self.font = CustomFont.medium.returnFont(15)
            self.textColor = UIColor.init(hexString: "#222B45")
        } else if isCarName {
            self.font = CustomFont.medium.returnFont(15)
            self.textColor = UIColor.init(hexString: "#ACB1C0")
        } else if isYourride {
            self.font = CustomFont.medium.returnFont(18)
            self.textColor = UIColor.init(hexString: "#222B45")
        }else if isFeedback {
            self.font = CustomFont.regular.returnFont(15)
            self.textColor = UIColor.init(hexString: "#ACB1C0")
        }
        
    }
}
class MessageDetailsLabel : UILabel{
    @IBInspectable var isName : Bool = false
    @IBInspectable var isCarName : Bool = false
    override func awakeFromNib() {
        if isName {
            self.font = CustomFont.bold.returnFont(18)
            self.textColor = colors.loginPlaceHolderColor.value
            self.textAlignment = .left
        }else if isCarName {
            self.font = CustomFont.medium.returnFont(13)
            self.textColor = UIColor.init(hexString: "#ACB1C0")
        }
    }
}
class cencleRideLabel : UILabel {
    override func awakeFromNib() {
        self.font = CustomFont.bold.returnFont(18)
        self.textColor = colors.loginPlaceHolderColor.value
        self.textAlignment = .center
    }
    
}
class paymentSucessFullyLabel : UILabel {
    override func awakeFromNib() {
        self.font = CustomFont.bold.returnFont(25)
        self.textColor = colors.loginPlaceHolderColor.value
        self.textAlignment = .center
    }
}
class chatScreenLabel : UILabel {
    @IBInspectable var lblSender : Bool = false
    @IBInspectable var lblReciver : Bool = false
    @IBInspectable var lblHeader : Bool = false
    
    override func awakeFromNib() {
        self.numberOfLines = 0
        if lblSender {
            self.font = CustomFont.medium.returnFont(17)
            self.textColor = colors.white.value
            self.textAlignment = .right
        } else if lblReciver {
            self.font = CustomFont.medium.returnFont(17)
            self.textColor = colors.loginPlaceHolderColor.value
            self.textAlignment = .left
        } else if lblHeader {
            self.font = CustomFont.regular.returnFont(14)
            self.textColor = UIColor(hexString: "#ACB1C0")
            self.textAlignment = .center
        }
    }
}

class versionLabel : UILabel {
    @IBInspectable var isLegalText : Bool = false
    
    override func awakeFromNib() {
        self.numberOfLines = 0
        self.textColor = colors.black.value.withAlphaComponent(0.4)
        if isLegalText {
            self.font = CustomFont.regular.returnFont(15)
            self.textAlignment = .left
        } else {
            self.font = CustomFont.medium.returnFont(18)
            self.textAlignment = .right
        }
    }
}
