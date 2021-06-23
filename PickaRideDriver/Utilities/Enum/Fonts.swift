//
//  Fonts.swift
//  CoreSound
//
//  Created by EWW083 on 04/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//
import Foundation
import UIKit
enum CustomFont
{
    case italic,lightitalic,medium,light,mediumitalic,bold,bolditalic,regular
    func returnFont(_ font:CGFloat)->UIFont
    {
        switch self
        {
        case .italic:
            return UIFont(name: "Ubuntu-Italic", size: font)!
        case .lightitalic:
            return UIFont(name: "Ubuntu-LightItalic", size: font)!
        case .medium:
            return UIFont(name: "Ubuntu-Medium", size: font)!
        case .light:
            return UIFont(name: "Ubuntu-Light", size: font)!
        case .mediumitalic:
            return UIFont(name: "Ubuntu-MediumItalic", size: font)!
        case .bold:
            return UIFont(name: "Ubuntu-Bold", size: font)!
        case .bolditalic:
            return UIFont(name: "Ubuntu-BoldItalic", size: font)!
        case .regular:
            return UIFont(name: "Ubuntu-Regular", size: font)!
        }
    }
}

enum FontsSize
{
    static let ExtraLarge : CGFloat = 40
    static let Large : CGFloat = 33
    static let MediumLarge : CGFloat = 26
    static let Medium : CGFloat = 25
    static let Regular : CGFloat = 18
    static let Small : CGFloat = 16
    static let ExtraSmall : CGFloat = 15
    static let Tiny :CGFloat = 14
}

extension UIFont
{
    class func regular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Ubuntu-Regular", size: size)!
    }
    
    class func medium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Ubuntu-Medium", size: size)!
    }
    
    class func bold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Ubuntu-Bold", size: size)!
    }
}
