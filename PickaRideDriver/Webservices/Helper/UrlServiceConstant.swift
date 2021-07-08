//
//  UrlServiceConstant.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 04/06/21.
//

import Foundation

class UrlConstant{
    static let ResponseMessage = "message"
    
    //MARK:- Message Title
    static let Success = "Success"
    static let Failed = "Failed"
    static let Status = "status"
    static let SomethingWentWrong = "There is some server side error, Please try again after some time!"
    static let NoInternetConnection = "The Internet connection appears to be offline, Please connect to the internet."
    static let RequestTimeOut = "Poor internet connection, Check your internet connection or try again."
    var LanguageList = ["English","German"]
    static let Ok = "Ok"
    static let Yes = "Yes"
    static let Cancel = "Cancel"
    static let No = "No"
    static let Retry = "Retry"
    static let SelectCard = "Select Card"
    static let Continue = "Continue"
}

let ErrorResponseDic = [UrlConstant.ResponseMessage: UrlConstant.SomethingWentWrong]
let NoInternetResponseDic = [UrlConstant.ResponseMessage: UrlConstant.NoInternetConnection]



