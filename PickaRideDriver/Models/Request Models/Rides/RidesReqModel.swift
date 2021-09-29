//
//  RidesReqModel.swift
//  PickaRideDriver
//
//  Created by Tej on 29/09/21.
//

import Foundation

//MARK: - Rides screen
class RidesRequestModel : Encodable{
    var driverId : String? = SingletonClass.sharedInstance.UserId
    var bookingId: String?
    
    enum CodingKeys: String, CodingKey {
        case driverId = "driver_id"
        case bookingId = "booking_id"
    }
}
