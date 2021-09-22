//
//  Enums.swift
//  Danfo_Rider
//
//  Created by Hiral on 30/03/21.
//

import Foundation

//DO NOT CHNAGE THIS ENUM ELSE URLSESSION WONT WORK
enum RequestString : String{
    case boundry = "Boundary-"
    case multiplePartFormData = "multipart/form-data; boundary="
    case contentType = "Content-Type"
}

enum Direction { case left, right }

enum GetRequestType: String{
    case GET
    case POST
    case DELETE
}

enum UserDefaultsKey : String {
    case userProfile = "userProfile"
    case isUserLogin = "isUserLogin"
    case X_API_KEY   = "X_API_KEY"
    case DeviceToken = "DeviceToken"
    case countryList = "countryList"
    case selLanguage = "language"
    case dutyStatus  = "dutyStatus"
    
}

enum NoRecordsStrings : String{
    case Underdevelopment = "Hold on..! Great things takes time...UNDER DEVELOPMENT!!"
    case notification = "You have no notifications."
    case WalletHistory = "No trasaction history."
    case Cards = "You have not added any cards yet."
}

//enum DateFormatterString : String{
//    case timeWithDate = "yyyy-MM-dd HH:mm:ss"
//    case onlyDate = "yyyy-MM-dd"
//}
enum RideStatus {
    case Initial , WaitForDriver , TripHasBeenStart
}

enum MakePaymentFrom {
    case WalletVC , ArrivedAtDestinationVC
}

enum TripHistoryType{
    case Upcoming, Past
}
enum Tagtype : String{
    case Home = "1"
    case Work = "2"
    case Hotel = "3"
    case Other = "4"
}

extension Tagtype {
    static var allValues: [Tagtype] {
        var allValues: [Tagtype] = []
        switch (Tagtype.Home) {
        case .Home: allValues.append(.Home); fallthrough
        case .Work: allValues.append(.Work); fallthrough
        case .Hotel: allValues.append(.Hotel); fallthrough
        case .Other: allValues.append(.Other)
        }
        return allValues
    }
}

enum HapticTypes {
    case error , sucess, warning
}

enum ReachedOTPScreenBy {
    case login , register
}

enum viewComponentsTags : Int{
    case ActivityIndicator = 1001
    case ToastView = 2002
    
}

enum webserviceResponse {
    case gotData , initial
}

enum RideState {
    static let None = 0
    static let NewRequest = 1
    static let RequestAccepted = 2
    static let StartRide = 6
    static let RequestCancel = 3
    static let CancelAcceptedRide = 4
    static let ArrivedAtLocation = 5
    static let EndRide = 7
}
