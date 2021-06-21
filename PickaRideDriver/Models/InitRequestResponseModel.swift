//
//  InitRequestResponseModel.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 04/06/21.
//

import Foundation

class InitResponseModel: Codable {
    var status : Bool? = false, update: Int? = 0
    var message: String?
      let vehicleTypeList: [VehicleTypeListResponseModel]?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case status = "status"
        case update = "update"
        case vehicleTypeList = "vehicle_type_list"
    }
    
    init(status: Bool, update: Int, message: String, vehicleTypeList: [VehicleTypeListResponseModel]) {
           self.status = status
           self.update = update
           self.message = message
           self.vehicleTypeList = vehicleTypeList
       }
}

class VehicleTypeListResponseModel : Codable {
    let vehicleModel : String?
    
    enum CodingKeys: String, CodingKey {
        case vehicleModel
    }
    
    
    init(vehicleModel: String) {
           self.vehicleModel = vehicleModel
       }
    
}
