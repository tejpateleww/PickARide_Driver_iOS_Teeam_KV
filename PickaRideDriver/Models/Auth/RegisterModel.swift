//
//  RegisterRequestResponseModel.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 07/06/21.
//

import Foundation
import UIKit

//MARK:- Login Screen
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
    
    var profileImage: String?
    
    
    enum CodingKeys: String, CodingKey {
        
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case password = "password"
        case mobileNo = "mobile_no"
        case countryId = "country_id"
        case countryCode = "country_code"
        
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
        
        case profileImage = "profile_image"
    }
}


//class RegisterFinal: Codable {
//    let status: Bool?
//    let message: String?
//    var data: RegisterData?
//
//    init(status: Bool, message: String, data: RegisterData) {
//        self.status = status
//        self.message = message
//        self.data = data
//    }
//
//    required init(from decoder: Decoder) throws {
//        let values = try? decoder.container(keyedBy: CodingKeys.self)
//        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
//        message = try? values?.decodeIfPresent(String.self, forKey: .message)
//        data = try? values?.decodeIfPresent(RegisterData.self, forKey: .data)
//    }
//}

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
        data = try values.decodeIfPresent(RegisterData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}

// MARK: - DataClass
//class RegisterData: Codable {
//    var id, vehicleType, companyID, firstName: String?
//    var lastName, email, countryID, countryCode: String?
//    var mobileNo, dob, gender, walletBalance: String?
//    var profileImage, qrCode, accountHolderName, bankName: String?
//    var bankBranch, accountNumber,ifscCode, lat, lng: String?
//    var deviceType, deviceToken, address, status: String?
//    var verify, busy, duty, createdAt: String?
//    var trash, referralCode, inviteCode, rememberToken: String?
//    var rating: String?
//    var vehicleInfo: [VehicleInfo]?
//    var driverDocs: DriverDocs?
//    var xAPIKey: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case vehicleType = "vehicle_type"
//        case companyID = "company_id"
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case email
//        case countryID = "country_id"
//        case countryCode = "country_code"
//        case mobileNo = "mobile_no"
//        case dob, gender
//        case walletBalance = "wallet_balance"
//        case profileImage = "profile_image"
//        case qrCode = "qr_code"
//        case accountHolderName = "account_holder_name"
//        case bankName = "bank_name"
//        case bankBranch = "bank_branch"
//        case accountNumber = "account_number"
//        case ifscCode = "ifsc_code"
//        case lat, lng
//        case deviceType = "device_type"
//        case deviceToken = "device_token"
//        case address, status, verify, busy, duty
//        case createdAt = "created_at"
//        case trash
//        case referralCode = "referral_code"
//        case inviteCode = "invite_code"
//        case rememberToken = "remember_token"
//        case rating
//        case vehicleInfo = "vehicle_info"
//        case driverDocs = "driver_docs"
//        case xAPIKey = "x-api-key"
//    }
//
//    init(id: String, vehicleType: String, companyID: String, firstName: String, lastName: String, email: String, countryID: String, countryCode: String, mobileNo: String, dob: String, gender: String, walletBalance: String, profileImage: String, qrCode: String, accountHolderName: String, bankName: String, bankBranch: String, accountNumber: String, ifscCode: String, lat: String, lng: String, deviceType: String, deviceToken: String, address: String, status: String, verify: String, busy: String, duty: String, createdAt: String, trash: String, referralCode: String, inviteCode: String, rememberToken: String, rating: String, vehicleInfo: [VehicleInfo], driverDocs: DriverDocs, xAPIKey: String) {
//        self.id = id
//        self.vehicleType = vehicleType
//        self.companyID = companyID
//        self.firstName = firstName
//        self.lastName = lastName
//        self.email = email
//        self.countryID = countryID
//        self.countryCode = countryCode
//        self.mobileNo = mobileNo
//        self.dob = dob
//        self.gender = gender
//        self.walletBalance = walletBalance
//        self.profileImage = profileImage
//        self.qrCode = qrCode
//        self.accountHolderName = accountHolderName
//        self.bankName = bankName
//        self.bankBranch = bankBranch
//        self.accountNumber = accountNumber
//        self.ifscCode = ifscCode
//        self.lat = lat
//        self.lng = lng
//        self.deviceType = deviceType
//        self.deviceToken = deviceToken
//        self.address = address
//        self.status = status
//        self.verify = verify
//        self.busy = busy
//        self.duty = duty
//        self.createdAt = createdAt
//        self.trash = trash
//        self.referralCode = referralCode
//        self.inviteCode = inviteCode
//        self.rememberToken = rememberToken
//        self.rating = rating
//        self.vehicleInfo = vehicleInfo
//        self.driverDocs = driverDocs
//        self.xAPIKey = xAPIKey
//    }
//
//    required init(from decoder: Decoder) throws {
//        let values = try? decoder.container(keyedBy: CodingKeys.self)
//        accountHolderName = try? values?.decodeIfPresent(String.self, forKey: .accountHolderName)
//        accountNumber = try? values?.decodeIfPresent(String.self, forKey: .accountNumber)
//        ifscCode = try? values?.decodeIfPresent(String.self, forKey: .ifscCode)
//        address = try? values?.decodeIfPresent(String.self, forKey: .address)
//        bankBranch = try? values?.decodeIfPresent(String.self, forKey: .bankBranch)
//        bankName = try? values?.decodeIfPresent(String.self, forKey: .bankName)
//        busy = try? values?.decodeIfPresent(String.self, forKey: .busy)
//        companyID = try? values?.decodeIfPresent(String.self, forKey: .companyID)
//        countryCode = try? values?.decodeIfPresent(String.self, forKey: .countryCode)
//        countryID = try? values?.decodeIfPresent(String.self, forKey: .countryID)
//        createdAt = try? values?.decodeIfPresent(String.self, forKey: .createdAt)
//        deviceToken = try? values?.decodeIfPresent(String.self, forKey: .deviceToken)
//        deviceType = try? values?.decodeIfPresent(String.self, forKey: .deviceType)
//        dob = try? values?.decodeIfPresent(String.self, forKey: .dob)
//        driverDocs = try? values?.decodeIfPresent(DriverDocs.self, forKey: .driverDocs)
//        duty = try? values?.decodeIfPresent(String.self, forKey: .duty)
//        email = try? values?.decodeIfPresent(String.self, forKey: .email)
//        firstName = try? values?.decodeIfPresent(String.self, forKey: .firstName)
//        gender = try? values?.decodeIfPresent(String.self, forKey: .gender)
//        id = try? values?.decodeIfPresent(String.self, forKey: .id)
//        inviteCode = try? values?.decodeIfPresent(String.self, forKey: .inviteCode)
//        lastName = try? values?.decodeIfPresent(String.self, forKey: .lastName)
//        lat = try? values?.decodeIfPresent(String.self, forKey: .lat)
//        lng = try? values?.decodeIfPresent(String.self, forKey: .lng)
//        mobileNo = try? values?.decodeIfPresent(String.self, forKey: .mobileNo)
//        profileImage = try? values?.decodeIfPresent(String.self, forKey: .profileImage)
//        qrCode = try? values?.decodeIfPresent(String.self, forKey: .qrCode)
//        rating = try? values?.decodeIfPresent(String.self, forKey: .rating)
//        referralCode = try? values?.decodeIfPresent(String.self, forKey: .referralCode)
//        rememberToken = try? values?.decodeIfPresent(String.self, forKey: .rememberToken)
//        status = try? values?.decodeIfPresent(String.self, forKey: .status)
//        trash = try? values?.decodeIfPresent(String.self, forKey: .trash)
//        vehicleInfo = try? values?.decodeIfPresent([VehicleInfo].self, forKey: .vehicleInfo)
//        vehicleType = try? values?.decodeIfPresent(String.self, forKey: .vehicleType)
//        verify = try? values?.decodeIfPresent(String.self, forKey: .verify)
//        walletBalance = try? values?.decodeIfPresent(String.self, forKey: .walletBalance)
//        xAPIKey = try? values?.decodeIfPresent(String.self, forKey: .xAPIKey)
//    }
//
//}

class RegisterData : Codable {
    
    var accountHolderName : String?
    var accountNumber : String?
    var address : String?
    var bankName : String?
    var busy : String?
    var companyId : String?
    var countryCode : String?
    var countryId : String?
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
    
    enum CodingKeys: String, CodingKey {
        case accountHolderName = "account_holder_name"
        case accountNumber = "account_number"
        case address = "address"
        case bankName = "bank_name"
        case busy = "busy"
        case companyId = "company_id"
        case countryCode = "country_code"
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
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accountHolderName = try values.decodeIfPresent(String.self, forKey: .accountHolderName)
        accountNumber = try values.decodeIfPresent(String.self, forKey: .accountNumber)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        bankName = try values.decodeIfPresent(String.self, forKey: .bankName)
        busy = try values.decodeIfPresent(String.self, forKey: .busy)
        companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        countryId = try values.decodeIfPresent(String.self, forKey: .countryId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        deviceToken = try values.decodeIfPresent(String.self, forKey: .deviceToken)
        deviceType = try values.decodeIfPresent(String.self, forKey: .deviceType)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        driverDocs = try values.decodeIfPresent(RegisterDriverDoc.self, forKey: .driverDocs) //RegisterDriverDoc(from: decoder)
        duty = try values.decodeIfPresent(String.self, forKey: .duty)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        ifscCode = try values.decodeIfPresent(String.self, forKey: .ifscCode)
        inviteCode = try values.decodeIfPresent(String.self, forKey: .inviteCode)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lng = try values.decodeIfPresent(String.self, forKey: .lng)
        mobileNo = try values.decodeIfPresent(String.self, forKey: .mobileNo)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
        qrCode = try values.decodeIfPresent(String.self, forKey: .qrCode)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        referralCode = try values.decodeIfPresent(String.self, forKey: .referralCode)
        rememberToken = try values.decodeIfPresent(String.self, forKey: .rememberToken)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        trash = try values.decodeIfPresent(String.self, forKey: .trash)
        vehicleInfo = try values.decodeIfPresent([RegisterVehicleInfo].self, forKey: .vehicleInfo)
        vehicleType = try values.decodeIfPresent(String.self, forKey: .vehicleType)
        verify = try values.decodeIfPresent(String.self, forKey: .verify)
        walletBalance = try values.decodeIfPresent(String.self, forKey: .walletBalance)
        xApiKey = try values.decodeIfPresent(String.self, forKey: .xApiKey)
    }
    
}

// MARK: - DriverDocs
//class DriverDocs: Codable {
//    let id, driverID, vehicleInsuranceCerti, vehicleInsuranceExpDate: String?
//    let isVerifyVehicleInsurance, driverLicenceImage, driverLicenceExpDate, isVerifyDriverLicence: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case driverID = "driver_id"
//        case vehicleInsuranceCerti = "vehicle_insurance_certi"
//        case vehicleInsuranceExpDate = "vehicle_insurance_exp_date"
//        case isVerifyVehicleInsurance = "is_verify_vehicle_insurance"
//        case driverLicenceImage = "driver_licence_image"
//        case driverLicenceExpDate = "driver_licence_exp_date"
//        case isVerifyDriverLicence = "is_verify_driver_licence"
//    }
//
//    init(id: String, driverID: String, vehicleInsuranceCerti: String, vehicleInsuranceExpDate: String, isVerifyVehicleInsurance: String, driverLicenceImage: String, driverLicenceExpDate: String, isVerifyDriverLicence: String) {
//        self.id = id
//        self.driverID = driverID
//        self.vehicleInsuranceCerti = vehicleInsuranceCerti
//        self.vehicleInsuranceExpDate = vehicleInsuranceExpDate
//        self.isVerifyVehicleInsurance = isVerifyVehicleInsurance
//        self.driverLicenceImage = driverLicenceImage
//        self.driverLicenceExpDate = driverLicenceExpDate
//        self.isVerifyDriverLicence = isVerifyDriverLicence
//    }
//
//    required init(from decoder: Decoder) throws {
//        let values = try? decoder.container(keyedBy: CodingKeys.self)
//        driverID = try? values?.decodeIfPresent(String.self, forKey: .driverID)
//        driverLicenceExpDate = try values?.decodeIfPresent(String.self, forKey: .driverLicenceExpDate)
//        driverLicenceImage = try values?.decodeIfPresent(String.self, forKey: .driverLicenceImage)
//        id = try values?.decodeIfPresent(String.self, forKey: .id)
//        isVerifyDriverLicence = try values?.decodeIfPresent(String.self, forKey: .isVerifyDriverLicence)
//        isVerifyVehicleInsurance = try values?.decodeIfPresent(String.self, forKey: .isVerifyVehicleInsurance)
//        vehicleInsuranceCerti = try values?.decodeIfPresent(String.self, forKey: .vehicleInsuranceCerti)
//        vehicleInsuranceExpDate = try values?.decodeIfPresent(String.self, forKey: .vehicleInsuranceExpDate)
//    }
//}


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
        vehicleTypeName = try values.decodeIfPresent(String.self, forKey: .vehicleTypeName)
        yearOfManufacture = try values.decodeIfPresent(String.self, forKey: .yearOfManufacture)
    }
    
}


// MARK: - VehicleInfo
//class VehicleInfo: Codable {
//    let id, companyID, vehicleType, driverID: String?
//    let plateNumber, yearOfManufacture, vehicleTypeModelName, vehicleTypeManufacturerName: String?
//    let noOfPassenger, vehicleImage, carLeft, carRight: String?
//    let carFront, carBack, vehicleTypeName: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case companyID = "company_id"
//        case vehicleType = "vehicle_type"
//        case driverID = "driver_id"
//        case plateNumber = "plate_number"
//        case yearOfManufacture = "year_of_manufacture"
//        case vehicleTypeModelName = "vehicle_type_model_name"
//        case vehicleTypeManufacturerName = "vehicle_type_manufacturer_name"
//        case noOfPassenger = "no_of_passenger"
//        case vehicleImage = "vehicle_image"
//        case carLeft = "car_left"
//        case carRight = "car_right"
//        case carFront = "car_front"
//        case carBack = "car_back"
//        case vehicleTypeName = "vehicle_type_name"
//    }
//
//    init(id: String, companyID: String, vehicleType: String, driverID: String, plateNumber: String, yearOfManufacture: String, vehicleTypeModelName: String, vehicleTypeManufacturerName: String, noOfPassenger: String, vehicleImage: String, carLeft: String, carRight: String, carFront: String, carBack: String, vehicleTypeName: String) {
//        self.id = id
//        self.companyID = companyID
//        self.vehicleType = vehicleType
//        self.driverID = driverID
//        self.plateNumber = plateNumber
//        self.yearOfManufacture = yearOfManufacture
//        self.vehicleTypeModelName = vehicleTypeModelName
//        self.vehicleTypeManufacturerName = vehicleTypeManufacturerName
//        self.noOfPassenger = noOfPassenger
//        self.vehicleImage = vehicleImage
//        self.carLeft = carLeft
//        self.carRight = carRight
//        self.carFront = carFront
//        self.carBack = carBack
//        self.vehicleTypeName = vehicleTypeName
//    }
//
//    required init(from decoder: Decoder) throws {
//        let values = try? decoder.container(keyedBy: CodingKeys.self)
//        carBack = try values?.decodeIfPresent(String.self, forKey: .carBack)
//        carFront = try values?.decodeIfPresent(String.self, forKey: .carFront)
//        carLeft = try values?.decodeIfPresent(String.self, forKey: .carLeft)
//        carRight = try values?.decodeIfPresent(String.self, forKey: .carRight)
//        companyID = try values?.decodeIfPresent(String.self, forKey: .companyID)
//        driverID = try values?.decodeIfPresent(String.self, forKey: .driverID)
//        id = try values?.decodeIfPresent(String.self, forKey: .id)
//        noOfPassenger = try values?.decodeIfPresent(String.self, forKey: .noOfPassenger)
//        plateNumber = try values?.decodeIfPresent(String.self, forKey: .plateNumber)
//        vehicleImage = try values?.decodeIfPresent(String.self, forKey: .vehicleImage)
//        vehicleType = try values?.decodeIfPresent(String.self, forKey: .vehicleType)
//        vehicleTypeManufacturerName = try values?.decodeIfPresent(String.self, forKey: .vehicleTypeManufacturerName)
//        vehicleTypeModelName = try values?.decodeIfPresent(String.self, forKey: .vehicleTypeModelName)
//        vehicleTypeName = try values?.decodeIfPresent(String.self, forKey: .vehicleTypeName)
//        yearOfManufacture = try values?.decodeIfPresent(String.self, forKey: .yearOfManufacture)
//    }
//}

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
        driverId = try values.decodeIfPresent(String.self, forKey: .driverId)
        driverInsurancePolicy = try values.decodeIfPresent(String.self, forKey: .driverInsurancePolicy)
        driverInsurancePolicyExpiryDate = try values.decodeIfPresent(String.self, forKey: .driverInsurancePolicyExpiryDate)
        drivingLicence = try values.decodeIfPresent(String.self, forKey: .drivingLicence)
        drivingLicenceExpiryDate = try values.decodeIfPresent(String.self, forKey: .drivingLicenceExpiryDate)
        governmentId = try values.decodeIfPresent(String.self, forKey: .governmentId)
        governmentIdExpiryDate = try values.decodeIfPresent(String.self, forKey: .governmentIdExpiryDate)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        isVerifyDriverInsurancePolicy = try values.decodeIfPresent(String.self, forKey: .isVerifyDriverInsurancePolicy)
        isVerifyDrivingLicence = try values.decodeIfPresent(String.self, forKey: .isVerifyDrivingLicence)
        isVerifyGovernmentId = try values.decodeIfPresent(String.self, forKey: .isVerifyGovernmentId)
        isVerifyOwnerCertificate = try values.decodeIfPresent(String.self, forKey: .isVerifyOwnerCertificate)
        isVerifyRcBook = try values.decodeIfPresent(String.self, forKey: .isVerifyRcBook)
        isVerifyVehicleInsurancePolicy = try values.decodeIfPresent(String.self, forKey: .isVerifyVehicleInsurancePolicy)
        isVerifyVehicleRegistration = try values.decodeIfPresent(String.self, forKey: .isVerifyVehicleRegistration)
        ownerCertificate = try values.decodeIfPresent(String.self, forKey: .ownerCertificate)
        rcBook = try values.decodeIfPresent(String.self, forKey: .rcBook)
        rcBookExpiryDate = try values.decodeIfPresent(String.self, forKey: .rcBookExpiryDate)
        vehicleInsurancePolicy = try values.decodeIfPresent(String.self, forKey: .vehicleInsurancePolicy)
        vehicleInsurancePolicyExpiryDate = try values.decodeIfPresent(String.self, forKey: .vehicleInsurancePolicyExpiryDate)
        vehicleRegistration = try values.decodeIfPresent(String.self, forKey: .vehicleRegistration)
        vehicleRegistrationExpiryDate = try values.decodeIfPresent(String.self, forKey: .vehicleRegistrationExpiryDate)
    }
    
}


