//
//  Colors.swift
//  CoreSound
//
//  Created by EWW083 on 04/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//

import Foundation
import  UIKit

enum colors{
    case white,black,appColor,red,btnColor,tableBg,gradient1,gradient2,lightGrey,coresoundThemeColor,loginText,loginViewColor,submitButtonColor,loginPlaceHolderColor,phoneNumberColor,AddCardTitleColor,seperatorColor,confirmPasswordPlaceHolder
    
    var value:UIColor{
        switch self {
        case .white:
            return UIColor.white
        case .black:
            return UIColor.black
        case .appColor:
            return UIColor(hexString:"#7357ee")
        //return UIColor(red: 134/255, green: 65/255, blue: 224/255, alpha: 1.0)
        case .btnColor:
            return UIColor(red: 95/255, green: 91/255, blue: 238/255, alpha: 1.0)
        case .red:
            return UIColor.red
        case .tableBg:
            return UIColor(hexString: "#252525")
        case .gradient1:
            return UIColor(hexString: "#736DFF")
        case .gradient2:
            return UIColor(hexString: "#7C3FE1")
        case .coresoundThemeColor:
            return UIColor(hexString: "#111044")
        case .lightGrey:
            return UIColor(hexString: "#666666")
        case .loginText:
            return UIColor(hexString: "#1C1B1B")
        case .loginViewColor:
            return UIColor(hexString: "#E4E9F2")
        case .submitButtonColor:
           return UIColor(hexString: "#00AA7E")
        case .loginPlaceHolderColor:
            return UIColor(hexString: "#222B45")
        case .phoneNumberColor:
            return UIColor(hexString: "#8F9BB3")
        case .AddCardTitleColor:
            return UIColor(hexString: "#8992A3")
        case .seperatorColor:
            return UIColor(hexString: "#000000").withAlphaComponent(0.03)
        case .confirmPasswordPlaceHolder:
            return UIColor(hexString: "#8F9BB3")
        }
    }
}
