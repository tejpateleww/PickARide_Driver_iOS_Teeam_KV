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
    
    var LanguageList = ["English","German"]
    
    //MARK:- Message Title
    static let Required = "UrlConstant_Required".Localized()
    static let Success = "UrlConstant_Success".Localized()
    static let Failed = "UrlConstant_Failed".Localized()
    static let Status = "status"
    static let SessionExpired = "UrlConstant_SessionExpired".Localized()
    static let SomethingWentWrong = "UrlConstant_SomethingWentWrong".Localized()
    static let SomethingWentWrongSocket = "UrlConstant_SomethingWentWrong_Socket".Localized()
    static let NoInternetConnection =  "UrlConstant_NoInternetConnection".Localized()
    static let RequestTimeOut = "UrlConstant_RequestTimeOut".Localized()
    static let LocationRequired = "UrlConstant_LocationRequiredMessage".Localized()
    static let OtpSent = "UrlConstant_OtpSent".Localized()
    static let OtpInvalid = "UrlConstant_OtpInvalid".Localized()
    
    static let Ok = "UrlConstant_Ok".Localized()
    static let Yes = "UrlConstant_Yes".Localized()
    static let Cancel = "UrlConstant_Cancel".Localized()
    static let No = "UrlConstant_No".Localized()
    static let Retry = "UrlConstant_Retry".Localized()
    static let SelectCard = "UrlConstant_SelectCard".Localized()
    static let Continue = "UrlConstant_Continue".Localized()
    static let Settings = "UrlConstant_Settings".Localized()
    static let Logout = "UrlConstant_Logout".Localized()
    static let Help = "UrlConstant_Help".Localized()
    static let Invalid = "UrlConstant_Invalid".Localized()
    static let Expiry = "UrlConstant_Expiry".Localized()
    
    //Validation Message
    static let ValidPhoneNo = "UrlConstant_ValidPhoneNo".Localized()
    static let AgeIsRequired = "UrlConstant_AgeIsRequired".Localized()
    static let AgeMustNumber = "UrlConstant_AgeMustNumber".Localized()
    static let InvalidAgeNumber = "UrlConstant_InvalidAgeNumber".Localized()
    static let Age18YearsOld = "UrlConstant_Age18YearsOld".Localized()
    static let RequiredVerificationCode = "UrlConstant_RequiredVerificationCode".Localized()
    static let InvalidVerificationCode = "UrlConstant_InvalidVerificationCode".Localized()
    static let LogoutMessage = "UrlConstant_LogoutMessage".Localized()
    static let InvalidEmail = "UrlConstant_InvalidEmailMessage".Localized()
    static let EnterEmail = "UrlConstant_EnterEmailMessage".Localized()
    static let InvalidCardNumber = "UrlConstant_InvalidCardNumber".Localized()
}

let SessionExpiredResponseDic = [UrlConstant.ResponseMessage: UrlConstant.SessionExpired]
let SomethingWentWrongResponseDic = [UrlConstant.ResponseMessage: UrlConstant.SomethingWentWrong]
let NoInternetResponseDic = [UrlConstant.ResponseMessage: UrlConstant.NoInternetConnection]



