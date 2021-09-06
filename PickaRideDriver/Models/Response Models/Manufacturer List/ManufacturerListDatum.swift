//
//  ManufacturerListDatum.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 6, 2021

import Foundation

class ManufacturerListDatum : Codable {
    
    let id : String?
    let manufacturerName : String?
    let status : String?
    let vehicleModel : [ManufacturerListVehicleModel]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case manufacturerName = "manufacturer_name"
        case status = "status"
        case vehicleModel = "vehicle_model"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        manufacturerName = try values.decodeIfPresent(String.self, forKey: .manufacturerName)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        vehicleModel = try values.decodeIfPresent([ManufacturerListVehicleModel].self, forKey: .vehicleModel)
    }
    
}
