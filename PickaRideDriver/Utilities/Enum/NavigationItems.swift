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
    case none, back , menu , cancel , cancelWhite,QuestionFalse
    
    var value:String {
        switch self {
        case .none:
            return ""
        case .back:
            return "back"
        case .menu:
            return "ic_sideMenu"
        case .cancel:
            return "cancel"
        case .cancelWhite:
            return "cancelWhite"
        case .QuestionFalse:
            return "imgQuestionFalse"
        }
    }
}


enum NavItemsRight {
    case none,login,EditProfile,userProfile,Done,sos,help,chat
    
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
        case .sos:
            return "ic_SOSBtn"
        case .help:
            return "imgHelp"
        case .chat:
            return "chat"
        }
    }
}

enum NavTitles
{
    case none, Home, reasonForCancle, rating, CommonView,
         BankDetails, RideDetails, Addvehicle, CancelRide,
         Earning, Chat, WithdrawMoney, WithdrawHistory
    
    var value:String
    {
        switch self
        {
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
        case .BankDetails:
            return "Bank Details"
        case .RideDetails:
            return "Ride Details"
        case .Addvehicle:
            return "Add Vehicle"
        case .CancelRide:
            return "Cancel Ride"
        case .Earning:
            return "Earning"
        case .Chat:
            return "Chat"
        case .WithdrawMoney:
            return "Withdraw Money"
        case .WithdrawHistory:
            return "Withdraw History"
        }
    }
}
