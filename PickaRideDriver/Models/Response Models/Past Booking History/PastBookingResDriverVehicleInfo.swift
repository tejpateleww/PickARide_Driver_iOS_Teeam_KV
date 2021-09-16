//
//  PastBookingResDriverVehicleInfo.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 16, 2021

import Foundation

class PastBookingResDriverVehicleInfo : Codable {

        let carBack : String?
        let carFront : String?
        let carLeft : String?
        let carRight : String?
        let color : String?
        let companyId : String?
        let driverId : String?
        let id : String?
        let noOfPassenger : String?
        let plateNumber : String?
        let vehicleImage : String?
        let vehicleType : String?
        let vehicleTypeManufacturerId : String?
        let vehicleTypeManufacturerName : String?
        let vehicleTypeModelId : String?
        let vehicleTypeModelName : String?
        let yearOfManufacture : String?

        enum CodingKeys: String, CodingKey {
                case carBack = "car_back"
                case carFront = "car_front"
                case carLeft = "car_left"
                case carRight = "car_right"
                case color = "color"
                case companyId = "company_id"
                case driverId = "driver_id"
                case id = "id"
                case noOfPassenger = "no_of_passenger"
                case plateNumber = "plate_number"
                case vehicleImage = "vehicle_image"
                case vehicleType = "vehicle_type"
                case vehicleTypeManufacturerId = "vehicle_type_manufacturer_id"
                case vehicleTypeManufacturerName = "vehicle_type_manufacturer_name"
                case vehicleTypeModelId = "vehicle_type_model_id"
                case vehicleTypeModelName = "vehicle_type_model_name"
                case yearOfManufacture = "year_of_manufacture"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                carBack = try values.decodeIfPresent(String.self, forKey: .carBack)
                carFront = try values.decodeIfPresent(String.self, forKey: .carFront)
                carLeft = try values.decodeIfPresent(String.self, forKey: .carLeft)
                carRight = try values.decodeIfPresent(String.self, forKey: .carRight)
                color = try values.decodeIfPresent(String.self, forKey: .color)
                companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
                driverId = try values.decodeIfPresent(String.self, forKey: .driverId)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                noOfPassenger = try values.decodeIfPresent(String.self, forKey: .noOfPassenger)
                plateNumber = try values.decodeIfPresent(String.self, forKey: .plateNumber)
                vehicleImage = try values.decodeIfPresent(String.self, forKey: .vehicleImage)
                vehicleType = try values.decodeIfPresent(String.self, forKey: .vehicleType)
                vehicleTypeManufacturerId = try values.decodeIfPresent(String.self, forKey: .vehicleTypeManufacturerId)
                vehicleTypeManufacturerName = try values.decodeIfPresent(String.self, forKey: .vehicleTypeManufacturerName)
                vehicleTypeModelId = try values.decodeIfPresent(String.self, forKey: .vehicleTypeModelId)
                vehicleTypeModelName = try values.decodeIfPresent(String.self, forKey: .vehicleTypeModelName)
                yearOfManufacture = try values.decodeIfPresent(String.self, forKey: .yearOfManufacture)
        }

}
