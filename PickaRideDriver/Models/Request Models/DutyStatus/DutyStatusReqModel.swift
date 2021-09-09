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
    
    enum CodingKeys: String, CodingKey {
        case driverId = "driver_id"
        case lat = "lat"
        case lng = "lng"
    }
}
