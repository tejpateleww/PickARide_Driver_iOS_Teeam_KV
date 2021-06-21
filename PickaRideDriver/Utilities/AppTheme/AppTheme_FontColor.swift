//
//  AppTheme_FontColor.swift
//  Danfo_Rider
//
//  Created by Hiral on 15/03/21.
//


import Foundation
import UIKit

enum ThemeColor: String {
    
    case themeGold = "FECD00"
    case themeSolidGray = "303030"
    case themeRed = "E24444"
    case themeGreen = "43D87F"
    
    ///FirstGradient is themeGold
    case themeGoldGradientSecond = "9F892A"
    case themeBorderGray = "F6F6F6"
    case themeGrayText = "D6D6D6"
    case themeGrayTextType2 = "7F7F7F"
    case themeGrayGradientFrst = "444444"
    case themeGrayGradientSecond = "2A2A2A"
}


enum FontSize : CGFloat {
    
    case size8 = 8.0
    case size10 = 10.0
    case size12 = 12.0
    case size13 = 13.0
    case size14 = 14.0
    case size15 = 15.0
    case size16 = 16.0
    case size17 = 17.0
    case size18 = 18.0
    case size19 = 19.0
    case size20 = 20.0
    case size22 = 22.0
    case size24 = 24.0
}

enum FontBook: String {
    
    case light =  "Gibson-Light"
    case bold = "Gibson-Bold"
    case semibold = "Gibson-SemiBold"
    case regular = "Gibson-Regular"
  
    
    func of(size: CGFloat) -> UIFont {
//        return UIFont(name:self.rawValue, size: manageFont(font: size))!
        return UIFont(name:self.rawValue, size: size) ?? UIFont.systemFont(ofSize: 15)
    }
    
//    func manageFont(font : CGFloat) -> CGFloat {
//        let cal  = SCREEN_HEIGHT * font
//        return CGFloat(cal / CGFloat(screenHeightDeveloper))
//    }
    func staticFont(size : CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
    
   func setlabelFont(labels:[UILabel] , Size:CGFloat , TextColour:UIColor) {
        for label in labels{
            label.font = staticFont(size: Size)
            label.textColor = TextColour
        }
    }
}



extension UIColor {
    
    static func appColor(_ name: ThemeColor) -> UIColor {
        switch name {
        case .themeGold:
            return  hexStringToUIColor(hex: ThemeColor.themeGold.rawValue)
        case .themeSolidGray:
            return  hexStringToUIColor(hex: ThemeColor.themeSolidGray.rawValue)
        case .themeRed:
            return  hexStringToUIColor(hex: ThemeColor.themeRed.rawValue)
        case .themeGreen:
            return  hexStringToUIColor(hex: ThemeColor.themeGreen.rawValue)
        case .themeGoldGradientSecond:
            return  hexStringToUIColor(hex: ThemeColor.themeGoldGradientSecond.rawValue)
        case .themeGrayText:
            return  hexStringToUIColor(hex: ThemeColor.themeGrayText.rawValue)
        case .themeBorderGray:
            return  hexStringToUIColor(hex: ThemeColor.themeBorderGray.rawValue)
        case .themeGrayGradientFrst:
            return  hexStringToUIColor(hex: ThemeColor.themeGrayGradientFrst.rawValue)
        case .themeGrayGradientSecond:
            return  hexStringToUIColor(hex: ThemeColor.themeGrayGradientSecond.rawValue)
        case .themeGrayTextType2:
            return hexStringToUIColor(hex: ThemeColor.themeGrayTextType2.rawValue)
        }
    }
}


