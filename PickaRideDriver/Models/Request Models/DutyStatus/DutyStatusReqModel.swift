//
//  DutyStatusReqModel.swift
//  PickaRideDriver
//
//  Created by Tej on 09/09/21.
//

import Foundation

class ChangeDutyStatusReqModel: Encodable{
    var driverId : String? = SingletonClass.sharedInstance.UserId
    var lat : String?
    var lng : String?
    var cityId: String?
    
    enum CodingKeys: String, CodingKey {
        case driverId = "driver_id"
        case lat = "lat"
        case lng = "lng"
        case cityId = "city_id"
    }
}

class CompleteTripReqModel: Encodable{
    var bookingId : String?
    var lat : String?
    var lng : String?
    
    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_id"
        case lat = "dropoff_lat"
        case lng = "dropoff_lng"
    }
}
