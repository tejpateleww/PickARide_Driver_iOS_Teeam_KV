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
    case completeTrip                         = "complete_trip"
    case reviewRating                         = "review_rating"
    case verifyCustomer                       = "verify_customer"
    case cancelReasonList                     = "cancel_reason_list"
    case cancelTrip                           = "cancel_trip"
    case pastBookingHistory                   = "past_booking_history/"
    case upcomingBookingHistory               = "upcoming_booking_history/"
    case inProcessBookingHistory              = "in_process_booking_history/"
    case acceptBookLaterRequest               = "accept_book_later_request"
    case chatHistory                          = "chat_history/"
    case sendMessage                          = "send_message/"
    
    
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
    
    case GoogleMapAPI    = "https://maps.googleapis.com/maps/api/directions/json?"
    
}

 

enum SocketKeys: String {
    
    case KHostUrl                                 = "http://65.1.154.172:8080/"
    case ConnectUser                              = "connect_user"
    case channelCommunation                       = "communication"
    case SendMessage                              = "send_message"
    case ReceiverMessage                          = "receiver_message"
    
    case updateDriverLocation                     = "update_driver_location"
    case forwardBookingRequest                    = "forward_booking_request"
    case forwardBookingRequestToAnotherDriver     = "forward_booking_request_to_another_driver"
    case acceptBookingRequest                     = "accept_booking_request"
    case verifyCustomer                           = "verify_customer"
    case arrivedAtPickupLocation                  = "arrived_at_pickup_location"
    case startTrip                                = "start_trip"
    case liveTracking                             = "live_tracking"
    
}
