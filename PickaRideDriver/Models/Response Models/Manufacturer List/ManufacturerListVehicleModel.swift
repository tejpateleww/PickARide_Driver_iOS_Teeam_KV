//
//  ManufacturerListVehicleModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 6, 2021

import Foundation

class ManufacturerListVehicleModel : Codable {
    
    let id : String?
    let status : String?
    let vehicleTypeId : String?
    let vehicleTypeManufacturerId : String?
    let vehicleTypeModelName : String?
    let vehicleTypeName : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case status = "status"
        case vehicleTypeId = "vehicle_type_id"
        case vehicleTypeManufacturerId = "vehicle_type_manufacturer_id"
        case vehicleTypeModelName = "vehicle_type_model_name"
        case vehicleTypeName = "vehicle_type_name"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        vehicleTypeId = try values.decodeIfPresent(String.self, forKey: .vehicleTypeId)
        vehicleTypeManufacturerId = try values.decodeIfPresent(String.self, forKey: .vehicleTypeManufacturerId)
        vehicleTypeModelName = try values.decodeIfPresent(String.self, forKey: .vehicleTypeModelName)
        vehicleTypeName = try values.decodeIfPresent(String.self, forKey: .vehicleTypeName)
    }
    
}
