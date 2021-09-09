//
//  UpdateBasicInfoReqModel.swift
//  PickaRideDriver
//
//  Created by Tej on 09/09/21.
//

import Foundation

class UpdateBasicInfoReqModel: Encodable{
    var driverId : String? = SingletonClass.sharedInstance.UserId
    var firstName : String?
    var lastName : String?
    var address : String?
    var profileImage : String?
    
    enum CodingKeys: String, CodingKey {
        case driverId = "driver_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case address = "address"
        case profileImage = "profile_image"
    }
}
