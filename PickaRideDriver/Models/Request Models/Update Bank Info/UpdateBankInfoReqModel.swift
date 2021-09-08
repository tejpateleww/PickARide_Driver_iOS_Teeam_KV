//
//  UpdateBankInfoReqModel.swift
//  PickaRideDriver
//
//  Created by Tej on 08/09/21.
//

import Foundation

class UpdateBankInfoReqModel: Encodable{
    var driverId : String? = SingletonClass.sharedInstance.UserId
    var accountHolderName : String?
    var bankName : String?
    var ifscCode : String?
    var accountNumber : String?
    
    enum CodingKeys: String, CodingKey {
        case driverId = "driver_id"
        case accountHolderName = "account_holder_name"
        case bankName = "bank_name"
        case ifscCode = "ifsc_code"
        case accountNumber = "account_number"
    }
}

class UpdateVehicleInfoReqModel: Encodable{
    var driverId : String? = SingletonClass.sharedInstance.UserId
    var vehicleType : String?
    var plateNumber : String?
    var yearOfManufacture : String?
    var vehicleTypeModelId : String?
    var vehicleTypeManufacturerId : String?
    var color : String?
    
    enum CodingKeys: String, CodingKey {
        case driverId = "driver_id"
        case vehicleType = "vehicle_type"
        case plateNumber = "plate_number"
        case yearOfManufacture = "year_of_manufacture"
        case vehicleTypeModelId = "vehicle_type_model_id"
        case vehicleTypeManufacturerId = "vehicle_type_manufacturer_id"
        case color = "color"
    }
}
