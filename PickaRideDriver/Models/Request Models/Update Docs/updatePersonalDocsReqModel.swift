//
//  updatePersonalDocsReqModel.swift
//  PickaRideDriver
//
//  Created by Tej on 08/09/21.
//

import Foundation

//MARK:- Change Password Request Model
class UpdatePersonalDocsReqModel: Encodable{
    var driverId : String? = SingletonClass.sharedInstance.UserId
    var governmentIdCerti : String?
    var governmentIdCertiExpDate : String?
    var driverLicenceImage : String?
    var driverLicenceExpDate : String?
    var vehicleRegistrationCerti : String?
    var vehicleRegistrationExpDate : String?
    var driverInsuranceCerti : String?
    var driverInsurancePolicyExpDate : String?
    
    enum CodingKeys: String, CodingKey {
        case driverId = "driver_id"
        case governmentIdCerti = "government_id_certi"
        case governmentIdCertiExpDate = "government_id_certi_exp_date"
        case driverLicenceImage = "driver_licence_image"
        case driverLicenceExpDate = "driver_licence_exp_date"
        case vehicleRegistrationCerti = "vehicle_registration_certi"
        case vehicleRegistrationExpDate = "vehicle_registration_exp_date"
        case driverInsuranceCerti = "driver_insurance_certi"
        case driverInsurancePolicyExpDate = "driver_insurance_policy_exp_date"
    }
}

class UpdateVehicleDocsReqModel: Encodable{
    var driverId : String? = SingletonClass.sharedInstance.UserId
    var rcBookCerti : String?
    var rcBookExpDate : String?
    var vehicleInsuranceCerti : String?
    var vehicleInsuranceExpDate : String?
    var ownerCerti : String?
    
    enum CodingKeys: String, CodingKey {
        case driverId = "driver_id"
        case rcBookCerti = "rc_book_certi"
        case rcBookExpDate = "rc_book_exp_date"
        case vehicleInsuranceCerti = "vehicle_insurance_certi"
        case vehicleInsuranceExpDate = "vehicle_insurance_exp_date"
        case ownerCerti = "owner_certi"
    }
}
