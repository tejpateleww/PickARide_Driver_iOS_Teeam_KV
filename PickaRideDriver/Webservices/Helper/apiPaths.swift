//
//  apiPaths.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 04/06/21.
//

import Foundation

typealias NetworkRouterCompletion = ((Data?,[String:Any]?, Bool) -> ())

enum APIEnvironment : String {
 
///Development URL : Picka ride customer
    case Development = "http://65.1.154.172/api/driver_api/"
    case Profilebu = "http://65.1.154.172/"
    case Live = "not provided"
     
    static var baseURL: String{
        return APIEnvironment.environment.rawValue
    }
    
    static var environment: APIEnvironment{
        return .Development
    }
    
//    static var headers : [String:String]
//    {
//        if user_defaults.object(forKey: UserDefaultsKey.isUserLogin.rawValue) != nil {
//
//            if user_defaults.object(forKey: UserDefaultsKey.isUserLogin.rawValue) as? Bool == true {
//
//                if user_defaults.object(forKey:  UserDefaultsKey.userProfile.rawValue) != nil {
//                    do {
//                        if UserDefaults.standard.value(forKey: UserDefaultsKey.X_API_KEY.rawValue) != nil,UserDefaults.standard.value(forKey:  UserDefaultsKey.isUserLogin.rawValue) as! Bool
//                        {
//                            return ["x-api-key":SingletonClass.sharedInstance.Api_Key]
//                        }else{
//                            return ["key":"PickARide951*#*"]
//                        }
//                    }
//                }
//            }
//        }
//        return ["key":"PickARide951*#*"]
//    }
    
    static var headers : [String:String]{
        if user_defaults.object(forKey: UserDefaultsKey.isUserLogin.rawValue) != nil {
            
            if user_defaults.object(forKey: UserDefaultsKey.isUserLogin.rawValue) as? Bool == true {
                
                if user_defaults.object(forKey:  UserDefaultsKey.userProfile.rawValue) != nil {
                    do {
                        if UserDefaults.standard.value(forKey: UserDefaultsKey.X_API_KEY.rawValue) != nil, UserDefaults.standard.value(forKey:  UserDefaultsKey.isUserLogin.rawValue) as? Bool ?? Bool(){
                            return ["key":"PickARide951*#*","x-api-key":SingletonClass.sharedInstance.Api_Key]
                        }else{
                            return ["key":"PickARide951*#*"]
                        }
                    }
                }
            }
        }
        return ["key":"PickARide951*#*"]
    }
}

enum ApiKey: String {
    case Init                                 = "init/ios_driver/"
    case getCountryList                       = "country_list"
    case registerOTP                          = "register_otp"
    case uploadDocs                           = "upload_docs"
    case updatePersonalDocs                   = "update_personal_docs"
    case updateVehicleDocs                    = "update_vehicle_docs"
    case updateBankInfo                       = "update_bank_info"
    case vehicleInfo                          = "update_vehicle_info"
    case updateBasicInfo                      = "update_basic_info"
    case logout                               = "logout/"
    case changeDuty                           = "change_duty"
    case currentBooking                       = "current_booking/"
    
    
    case register                             = "register"
    case vehicleTypeManufacturerList          = "vehicle_type_manufacturer_list"
    case vehicleTypeList                      = "vehicle_type_list"
    case login                                = "login"
    
    
    
    case updateDocs                           = "update_docs"
    case changePassword                       = "change_password"
    case forgotPassword                       = "forgot_password"
    
    case addCard                              = "add_card"
    case cardlist                             = "card_list"
    case removeCard                           = "remove_card"
    case qrCodeDetail                         = "qr_code_detail"
    case addMoney                             = "add_money"
    case transferMoney                        = "transfer_money"
    case transferMoneyToMobileNum             = "transfer_money_with_mobile_no"
    case transferMoneyToBank                  = "transfer_money_to_bank"
    case walletHistory                        = "wallet_history"
    
    
    
    
    
    case socialCheckExists                    = "social_login"
    case updateProfile                        = "profile_update"
    
    
    
}

 

enum SocketKeys: String {
    
    case KHostUrl                                 = "http://65.1.154.172:8080/"
    case ConnectUser                              = "connect_user"
    case channelCommunation                       = "communication"
    case SendMessage                              = "send_message"
    case ReceiverMessage                          = "receiver_message"
    
}
