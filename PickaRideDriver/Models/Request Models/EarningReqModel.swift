//
//  EarningReqModel.swift
//  PickaRideDriver
//
//  Created by Gaurang on 05/09/22.
//

import Foundation

struct EarningReqModel: Encodable {
    let driverId: String = SingletonClass.sharedInstance.UserId
   // let startDate: String
   // let endDate: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case driverId = "driver_id"
       // case startDate = "start_date"
       // case endDate = "end_date"
        case type = "earning_type"
    }
}

/*
 driver_id:63
 end_date:2022-09-04
 start_date:2022-08-29
 earning_type:weekly
 */
