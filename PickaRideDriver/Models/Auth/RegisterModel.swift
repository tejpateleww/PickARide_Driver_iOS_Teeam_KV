//
//  RegisterRequestResponseModel.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 07/06/21.
//

import Foundation
import UIKit

//MARK: - Login Screen
class LoginReqModel : Encodable{
    var username: String?
    var password: String?
    var lat: String? = SingletonClass.sharedInstance.locationString().latitude
    var lng: String? = SingletonClass.sharedInstance.locationString().longitude
    var deviceType: String = "ios"
    var deviceToken: String = SingletonClass.sharedInstance.DeviceToken
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case lat = "lat"
        case lng = "lng"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case password = "password"
    }
}

//MARK: - Register screen
class RegisterOTPRequestModel : Encodable{
    var email: String?
    var mobileNo: String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case mobileNo = "mobile_no"
    }
}

class RegisterOTPResponseModel: Codable {
    var status: Bool?
    var otp: Int?
    var message: String?
    
    init(status: Bool?, otp: Int?, message: String?) {
        self.status = status
        self.otp = otp
        self.message = message
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
        otp = try? values?.decodeIfPresent(Int.self, forKey: .otp)
        message = try? values?.decodeIfPresent(String.self, forKey: .message)
    }
}
//MARK: - OTP screen

class RegisterFinalRequestModel : Encodable{
    
    var firstName: String?
    var lastName: String?
    var email: String?
    var password: String?
    var cityId: String?
    var mobileNo: String?
    var countryId: String?
    var countryCode: String?
    
    var accountHolderName: String?
    var bankName: String?
    var ifscCode: String?
    var accountNumber : String?
    
    var lat: String? = SingletonClass.sharedInstance.locationString().latitude
    var lng: String? = SingletonClass.sharedInstance.locationString().longitude
    var deviceType: String = "ios"
    var deviceToken: String = SingletonClass.sharedInstance.DeviceToken
    
    var address: String?
    
    var govermentIdImage: String?
    var govermentIdExpDate: String?
    var driverLicenceImage: String?
    var driverLicenceExpDate: String?
    var vehicleRegistrationImage: String?
    var vehicleRegistrationExpDate: String?
    var driverInsuranceImage: String?
    var driverInsuranceExpDate: String?
    var rcBookImage: String?
    var rcBookExpDate: String?
    var vehicleInsuranceImage: String?
    var vehicleInsuranceExpDate: String?
    var ownerCertificateImage: String?
    
    var plateNumber: String?
    var yearOfManufacture: String?
    var vehicleTypeManufacturerId: String?
    var vehicleTypeModelId: String?
    var vehicleType: String?
    var color: String?
    
    var profileImage: String?
    
    
    enum CodingKeys: String, CodingKey {
        
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case password = "password"
        case mobileNo = "mobile_no"
        case countryId = "country_id"
        case countryCode = "country_code"
        case cityId = "city_id"
        case accountHolderName = "account_holder_name"
        case bankName = "bank_name"
        case ifscCode = "ifsc_code"
        case accountNumber = "account_number"
        
        case lat = "lat"
        case lng = "lng"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        
        case address = "address"
        
        case govermentIdImage = "government_id_certi"
        case govermentIdExpDate = "government_id_certi_exp_date"
        case driverLicenceImage = "driver_licence_image"
        case driverLicenceExpDate = "driver_licence_exp_date"
        case vehicleRegistrationImage = "vehicle_registration_certi"
        case vehicleRegistrationExpDate = "vehicle_registration_exp_date"
        case driverInsuranceImage = "driver_insurance_certi"
        case driverInsuranceExpDate = "driver_insurance_policy_exp_date"
        case rcBookImage = "rc_book_certi"
        case rcBookExpDate = "rc_book_exp_date"
        case vehicleInsuranceImage = "vehicle_insurance_certi"
        case vehicleInsuranceExpDate = "vehicle_insurance_exp_date"
        case ownerCertificateImage = "owner_certi"
        
        case plateNumber = "plate_number"
        case yearOfManufacture = "year_of_manufacture"
        case vehicleTypeManufacturerId = "vehicle_type_manufacturer_id"
        case vehicleTypeModelId = "vehicle_type_model_id"
        case vehicleType = "vehicle_type"
        case color = "color"
        
        case profileImage = "profile_image"
    }
}

struct RegisterFinal : Codable {
    
    let data : RegisterData?
    let message : String?
    let status : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try? values.decode(RegisterData.self, forKey: .data)
        message = try? values.decode(String.self, forKey: .message)
        status = try? values.decode(Bool.self, forKey: .status)
    }
    
}

class RegisterData : Codable {
    
    var accountHolderName : String?
    var accountNumber : String?
    var address : String?
    var bankName : String?
    var busy : String?
    var companyId : String?
    var countryCode : String?
    var countryId : String?
    var cityId: String?
    var cityName: String?
    var createdAt : String?
    var deviceToken : String?
    var deviceType : String?
    var dob : String?
    var driverDocs : RegisterDriverDoc?
    var duty : String?
    var email : String?
    var firstName : String?
    var gender : String?
    var id : String?
    var ifscCode : String?
    var inviteCode : String?
    var lastName : String?
    var lat : String?
    var lng : String?
    var mobileNo : String?
    var profileImage : String?
    var qrCode : String?
    var rating : String?
    var referralCode : String?
    var rememberToken : String?
    var status : String?
    var trash : String?
    var vehicleInfo : [RegisterVehicleInfo]?
    var vehicleType : String?
    var verify : String?
    var walletBalance : String?
    var xApiKey : String?
    var dispatcherId: String?
    var currencySymbol: String?
    
    enum CodingKeys: String, CodingKey {
        case accountHolderName = "account_holder_name"
        case accountNumber = "account_number"
        case address = "address"
        case bankName = "bank_name"
        case busy = "busy"
        case companyId = "company_id"
        case countryCode = "country_code"
        case cityId = "city_id"
        case cityName = "city_name"
        case countryId = "country_id"
        case createdAt = "created_at"
        case deviceToken = "device_token"
        case deviceType = "device_type"
        case dob = "dob"
        case driverDocs = "driver_docs"
        case duty = "duty"
        case email = "email"
        case firstName = "first_name"
        case gender = "gender"
        case id = "id"
        case ifscCode = "ifsc_code"
        case inviteCode = "invite_code"
        case lastName = "last_name"
        case lat = "lat"
        case lng = "lng"
        case mobileNo = "mobile_no"
        case profileImage = "profile_image"
        case qrCode = "qr_code"
        case rating = "rating"
        case referralCode = "referral_code"
        case rememberToken = "remember_token"
        case status = "status"
        case trash = "trash"
        case vehicleInfo = "vehicle_info"
        case vehicleType = "vehicle_type"
        case verify = "verify"
        case walletBalance = "wallet_balance"
        case xApiKey = "x-api-key"
        case dispatcherId = "dispatcher_id"
        case currencySymbol = "currency_symbol"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accountHolderName = try? values.decode(String.self, forKey: .accountHolderName)
        accountNumber = try? values.decode(String.self, forKey: .accountNumber)
        address = try? values.decode(String.self, forKey: .address)
        bankName = try? values.decode(String.self, forKey: .bankName)
        busy = try? values.decode(String.self, forKey: .busy)
        companyId = try? values.decode(String.self, forKey: .companyId)
        cityId = try? values.decode(String.self, forKey: .cityId)
        cityName = try? values.decode(String.self, forKey: .cityName)
        countryCode = try? values.decode(String.self, forKey: .countryCode)
        countryId = try? values.decode(String.self, forKey: .countryId)
        createdAt = try? values.decode(String.self, forKey: .createdAt)
        deviceToken = try? values.decode(String.self, forKey: .deviceToken)
        deviceType = try? values.decode(String.self, forKey: .deviceType)
        dob = try? values.decode(String.self, forKey: .dob)
        driverDocs = try? values.decode(RegisterDriverDoc.self, forKey: .driverDocs) //RegisterDriverDoc(from: decoder)
        duty = try? values.decode(String.self, forKey: .duty)
        email = try? values.decode(String.self, forKey: .email)
        firstName = try? values.decode(String.self, forKey: .firstName)
        gender = try? values.decode(String.self, forKey: .gender)
        id = try? values.decode(String.self, forKey: .id)
        ifscCode = try? values.decode(String.self, forKey: .ifscCode)
        inviteCode = try? values.decode(String.self, forKey: .inviteCode)
        lastName = try? values.decode(String.self, forKey: .lastName)
        lat = try? values.decode(String.self, forKey: .lat)
        lng = try? values.decode(String.self, forKey: .lng)
        mobileNo = try? values.decode(String.self, forKey: .mobileNo)
        profileImage = try? values.decode(String.self, forKey: .profileImage)
        qrCode = try? values.decode(String.self, forKey: .qrCode)
        rating = try? values.decode(String.self, forKey: .rating)
        referralCode = try? values.decode(String.self, forKey: .referralCode)
        rememberToken = try? values.decode(String.self, forKey: .rememberToken)
        status = try? values.decode(String.self, forKey: .status)
        trash = try? values.decode(String.self, forKey: .trash)
        vehicleInfo = try? values.decode([RegisterVehicleInfo].self, forKey: .vehicleInfo)
        vehicleType = try? values.decode(String.self, forKey: .vehicleType)
        verify = try? values.decode(String.self, forKey: .verify)
        walletBalance = try? values.decode(String.self, forKey: .walletBalance)
        xApiKey = try? values.decode(String.self, forKey: .xApiKey)
        dispatcherId = try? values.decode(String.self, forKey: .dispatcherId)
        currencySymbol = try? values.decode(String.self, forKey: .currencySymbol)
    }
    
}

class RegisterVehicleInfo : Codable {
    
    var carBack : String?
    var carFront : String?
    var carLeft : String?
    var carRight : String?
    var color : String?
    var companyId : String?
    var driverId : String?
    var id : String?
    var noOfPassenger : String?
    var plateNumber : String?
    var vehicleImage : String?
    var vehicleType : String?
    var vehicleTypeManufacturerId : String?
    var vehicleTypeManufacturerName : String?
    var vehicleTypeModelId : String?
    var vehicleTypeModelName : String?
    var vehicleTypeName : String?
    var yearOfManufacture : String?
    
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
        case vehicleTypeName = "vehicle_type_name"
        case yearOfManufacture = "year_of_manufacture"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        carBack = try? values.decode(String.self, forKey: .carBack)
        carFront = try? values.decode(String.self, forKey: .carFront)
        carLeft = try? values.decode(String.self, forKey: .carLeft)
        carRight = try? values.decode(String.self, forKey: .carRight)
        color = try? values.decode(String.self, forKey: .color)
        companyId = try? values.decode(String.self, forKey: .companyId)
        driverId = try? values.decode(String.self, forKey: .driverId)
        id = try? values.decode(String.self, forKey: .id)
        noOfPassenger = try? values.decode(String.self, forKey: .noOfPassenger)
        plateNumber = try? values.decode(String.self, forKey: .plateNumber)
        vehicleImage = try? values.decode(String.self, forKey: .vehicleImage)
        vehicleType = try? values.decode(String.self, forKey: .vehicleType)
        vehicleTypeManufacturerId = try? values.decode(String.self, forKey: .vehicleTypeManufacturerId)
        vehicleTypeManufacturerName = try? values.decode(String.self, forKey: .vehicleTypeManufacturerName)
        vehicleTypeModelId = try? values.decode(String.self, forKey: .vehicleTypeModelId)
        vehicleTypeModelName = try? values.decode(String.self, forKey: .vehicleTypeModelName)
        vehicleTypeName = try? values.decode(String.self, forKey: .vehicleTypeName)
        yearOfManufacture = try? values.decode(String.self, forKey: .yearOfManufacture)
    }
    
}

class RegisterDriverDoc : Codable {
    
    var driverId : String?
    var driverInsurancePolicy : String?
    var driverInsurancePolicyExpiryDate : String?
    var drivingLicence : String?
    var drivingLicenceExpiryDate : String?
    var governmentId : String?
    var governmentIdExpiryDate : String?
    var id : String?
    var isVerifyDriverInsurancePolicy : String?
    var isVerifyDrivingLicence : String?
    var isVerifyGovernmentId : String?
    var isVerifyOwnerCertificate : String?
    var isVerifyRcBook : String?
    var isVerifyVehicleInsurancePolicy : String?
    var isVerifyVehicleRegistration : String?
    var ownerCertificate : String?
    var rcBook : String?
    var rcBookExpiryDate : String?
    var vehicleInsurancePolicy : String?
    var vehicleInsurancePolicyExpiryDate : String?
    var vehicleRegistration : String?
    var vehicleRegistrationExpiryDate : String?
    
    enum CodingKeys: String, CodingKey {
        case driverId = "driver_id"
        case driverInsurancePolicy = "driver_insurance_policy"
        case driverInsurancePolicyExpiryDate = "driver_insurance_policy_expiry_date"
        case drivingLicence = "driving_licence"
        case drivingLicenceExpiryDate = "driving_licence_expiry_date"
        case governmentId = "government_id"
        case governmentIdExpiryDate = "government_id_expiry_date"
        case id = "id"
        case isVerifyDriverInsurancePolicy = "is_verify_driver_insurance_policy"
        case isVerifyDrivingLicence = "is_verify_driving_licence"
        case isVerifyGovernmentId = "is_verify_government_id"
        case isVerifyOwnerCertificate = "is_verify_owner_certificate"
        case isVerifyRcBook = "is_verify_rc_book"
        case isVerifyVehicleInsurancePolicy = "is_verify_vehicle_insurance_policy"
        case isVerifyVehicleRegistration = "is_verify_vehicle_registration"
        case ownerCertificate = "owner_certificate"
        case rcBook = "rc_book"
        case rcBookExpiryDate = "rc_book_expiry_date"
        case vehicleInsurancePolicy = "vehicle_insurance_policy"
        case vehicleInsurancePolicyExpiryDate = "vehicle_insurance_policy_expiry_date"
        case vehicleRegistration = "vehicle_registration"
        case vehicleRegistrationExpiryDate = "vehicle_registration_expiry_date"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        driverId = try? values.decode(String.self, forKey: .driverId)
        driverInsurancePolicy = try? values.decode(String.self, forKey: .driverInsurancePolicy)
        driverInsurancePolicyExpiryDate = try? values.decode(String.self, forKey: .driverInsurancePolicyExpiryDate)
        drivingLicence = try? values.decode(String.self, forKey: .drivingLicence)
        drivingLicenceExpiryDate = try? values.decode(String.self, forKey: .drivingLicenceExpiryDate)
        governmentId = try? values.decode(String.self, forKey: .governmentId)
        governmentIdExpiryDate = try? values.decode(String.self, forKey: .governmentIdExpiryDate)
        id = try? values.decode(String.self, forKey: .id)
        isVerifyDriverInsurancePolicy = try? values.decode(String.self, forKey: .isVerifyDriverInsurancePolicy)
        isVerifyDrivingLicence = try? values.decode(String.self, forKey: .isVerifyDrivingLicence)
        isVerifyGovernmentId = try? values.decode(String.self, forKey: .isVerifyGovernmentId)
        isVerifyOwnerCertificate = try? values.decode(String.self, forKey: .isVerifyOwnerCertificate)
        isVerifyRcBook = try? values.decode(String.self, forKey: .isVerifyRcBook)
        isVerifyVehicleInsurancePolicy = try? values.decode(String.self, forKey: .isVerifyVehicleInsurancePolicy)
        isVerifyVehicleRegistration = try? values.decode(String.self, forKey: .isVerifyVehicleRegistration)
        ownerCertificate = try? values.decode(String.self, forKey: .ownerCertificate)
        rcBook = try? values.decode(String.self, forKey: .rcBook)
        rcBookExpiryDate = try? values.decode(String.self, forKey: .rcBookExpiryDate)
        vehicleInsurancePolicy = try? values.decode(String.self, forKey: .vehicleInsurancePolicy)
        vehicleInsurancePolicyExpiryDate = try? values.decode(String.self, forKey: .vehicleInsurancePolicyExpiryDate)
        vehicleRegistration = try? values.decode(String.self, forKey: .vehicleRegistration)
        vehicleRegistrationExpiryDate = try? values.decode(String.self, forKey: .vehicleRegistrationExpiryDate)
    }
    
}


