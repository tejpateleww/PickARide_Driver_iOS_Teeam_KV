//
//  PastBookingResDatum.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 16, 2021

import Foundation

class PastBookingResDatum : Codable {

        let bookingInfo : PastBookingResBookingInfo?
        let customerInfo : PastBookingResCustomerInfo?
        let driverInfo : PastBookingResDriverInfo?
        let driverVehicleInfo : PastBookingResDriverVehicleInfo?
        let vehicleType : PastBookingResVehicleType?

        enum CodingKeys: String, CodingKey {
                case bookingInfo = "booking_info"
                case customerInfo = "customer_info"
                case driverInfo = "driver_info"
                case driverVehicleInfo = "driver_vehicle_info"
                case vehicleType = "vehicle_type"
        }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        bookingInfo =  try values.decodeIfPresent(PastBookingResBookingInfo.self, forKey: .bookingInfo)
        customerInfo = try values.decodeIfPresent(PastBookingResCustomerInfo.self, forKey: .customerInfo)
        driverInfo = try values.decodeIfPresent(PastBookingResDriverInfo.self, forKey: .driverInfo)
        driverVehicleInfo = try values.decodeIfPresent(PastBookingResDriverVehicleInfo.self, forKey: .driverVehicleInfo)
        vehicleType = try values.decodeIfPresent(PastBookingResVehicleType.self, forKey: .vehicleType)
        
    }

}
