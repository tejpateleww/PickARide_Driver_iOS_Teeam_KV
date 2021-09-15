//
//  VerifyCustomerReqModel.swift
//  PickaRideDriver
//
//  Created by Tej on 14/09/21.
//

import Foundation

class VerifyCustomerReqModel: Encodable{
    var driverId : String? = SingletonClass.sharedInstance.UserId
    var bookingId : String?
    var customerId : String?
    
    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_id"
        case driverId = "driver_id"
        case customerId = "customer_id"
    }
}

class CancelBookingReqModel: Encodable{
    var bookingId : String?
    var cancelReason : String?
    
    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_id"
        case cancelReason = "cancel_reason"
    }
}
