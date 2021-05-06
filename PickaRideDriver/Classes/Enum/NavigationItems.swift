//
//  NavigationItems.swift
//  HC Pro Patient
//
//  Created by Shraddha Parmar on 30/09/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import Foundation
import Foundation
import UIKit

enum NavItemsLeft {
    case none, back , menu , cancel , cancelWhite
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .back:
            return "back"
        case .menu:
            return "menu"
        case .cancel:
            return "cancel"
        case .cancelWhite:
            return "cancelWhite"
        }
    }
}


enum NavItemsRight {
    case none,login,EditProfile,userProfile,Done
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .login:
            return "login"
        case .EditProfile:
            return "EditProfile"
        case .userProfile:
            return "like"
        case .Done:
            return "Done"
        
        }
    }
}
enum NavTitles {
    case none, Home,reasonForCancle,rating, CommonView
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .Home:
            return ""
        case .reasonForCancle:
            return "NavigationTitle_reasonForCancle".Localized()
        case .rating:
        return "NavigationTitle_Rating".Localized()
        case .CommonView:
            return "CommonView"
        }
    }
}
