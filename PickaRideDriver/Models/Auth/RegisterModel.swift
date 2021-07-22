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
    var latitude: String?
    var longitude: String?
    var deviceType: String? = "ios"
    var deviceToken: String? = SingletonClass.sharedInstance.UserId
    var countryCode: String?
    var countryId: String?
    var vehicleType: String?
    var dob: String?
    var gender: String?
    var accountHolderName: String?
    var bankName: String?
    var bankBranch: String?
    var accountNumber : String?
    var address: String?
    var vehicleInsuranceCerti: String?
    var vehicleInsuranceExpDate: String?
    var driverLicenceImage: String?
    var driverLicenceExpDate: String?
    var vehicleImage: String?
    var plateNumber: String?
    var yearOfManufacture: String?
    var vehicleTypeManufacturerName: String?
    var vehicleTypeModelName: String?
    var noOfPassenger: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case mobileNo = "mobile_no"
        case latitude = "lat"
        case longitude = "lng"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case countryCode = "country_code"
        case countryId = "country_id"
        case vehicleType = "vehicle_type"
        case dob = "dob"
        case gender = "gender"
        case accountHolderName = "account_holder_name"
        case bankName = "bank_name"
        case bankBranch = "bank_branch"
        case accountNumber = "account_number"
        case address = "address"
        case vehicleInsuranceCerti = "vehicle_insurance_certi"
        case vehicleInsuranceExpDate = "vehicle_insurance_exp_date"
        case driverLicenceImage = "driver_licence_image"
        case driverLicenceExpDate = "driver_licence_exp_date"
        case vehicleImage = "vehicle_image"
        case plateNumber = "plate_number"
        case yearOfManufacture = "year_of_manufacture"
        case vehicleTypeManufacturerName = "vehicle_type_manufacturer_name"
        case vehicleTypeModelName = "vehicle_type_model_name"
        case noOfPassenger = "no_of_passenger"
    }
}


class RegisterFinal: Codable {
    let status: Bool?
    let message: String?
    let data: RegisterData?
    
    init(status: Bool, message: String, data: RegisterData) {
        self.status = status
        self.message = message
        self.data = data
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
        message = try? values?.decodeIfPresent(String.self, forKey: .message)
        data = try? values?.decodeIfPresent(RegisterData.self, forKey: .data)
    }
}

// MARK: - DataClass
class RegisterData: Codable {
    let id, vehicleType, companyID, firstName: String?
    let lastName, email, countryID, countryCode: String?
    let mobileNo, dob, gender, walletBalance: String?
    let profileImage, qrCode, accountHolderName, bankName: String?
    let bankBranch, accountNumber, lat, lng: String?
    let deviceType, deviceToken, address, status: String?
    let verify, busy, duty, createdAt: String?
    let trash, referralCode, inviteCode, rememberToken: String?
    let rating: String?
    let vehicleInfo: [VehicleInfo]?
    let driverDocs: DriverDocs?
    let xAPIKey: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case vehicleType = "vehicle_type"
        case companyID = "company_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case countryID = "country_id"
        case countryCode = "country_code"
        case mobileNo = "mobile_no"
        case dob, gender
        case walletBalance = "wallet_balance"
        case profileImage = "profile_image"
        case qrCode = "qr_code"
        case accountHolderName = "account_holder_name"
        case bankName = "bank_name"
        case bankBranch = "bank_branch"
        case accountNumber = "account_number"
        case lat, lng
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case address, status, verify, busy, duty
        case createdAt = "created_at"
        case trash
        case referralCode = "referral_code"
        case inviteCode = "invite_code"
        case rememberToken = "remember_token"
        case rating
        case vehicleInfo = "vehicle_info"
        case driverDocs = "driver_docs"
        case xAPIKey = "x-api-key"
    }
    
    init(id: String, vehicleType: String, companyID: String, firstName: String, lastName: String, email: String, countryID: String, countryCode: String, mobileNo: String, dob: String, gender: String, walletBalance: String, profileImage: String, qrCode: String, accountHolderName: String, bankName: String, bankBranch: String, accountNumber: String, lat: String, lng: String, deviceType: String, deviceToken: String, address: String, status: String, verify: String, busy: String, duty: String, createdAt: String, trash: String, referralCode: String, inviteCode: String, rememberToken: String, rating: String, vehicleInfo: [VehicleInfo], driverDocs: DriverDocs, xAPIKey: String) {
        self.id = id
        self.vehicleType = vehicleType
        self.companyID = companyID
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.countryID = countryID
        self.countryCode = countryCode
        self.mobileNo = mobileNo
        self.dob = dob
        self.gender = gender
        self.walletBalance = walletBalance
        self.profileImage = profileImage
        self.qrCode = qrCode
        self.accountHolderName = accountHolderName
        self.bankName = bankName
        self.bankBranch = bankBranch
        self.accountNumber = accountNumber
        self.lat = lat
        self.lng = lng
        self.deviceType = deviceType
        self.deviceToken = deviceToken
        self.address = address
        self.status = status
        self.verify = verify
        self.busy = busy
        self.duty = duty
        self.createdAt = createdAt
        self.trash = trash
        self.referralCode = referralCode
        self.inviteCode = inviteCode
        self.rememberToken = rememberToken
        self.rating = rating
        self.vehicleInfo = vehicleInfo
        self.driverDocs = driverDocs
        self.xAPIKey = xAPIKey
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        accountHolderName = try? values?.decodeIfPresent(String.self, forKey: .accountHolderName)
        accountNumber = try? values?.decodeIfPresent(String.self, forKey: .accountNumber)
        address = try? values?.decodeIfPresent(String.self, forKey: .address)
        bankBranch = try? values?.decodeIfPresent(String.self, forKey: .bankBranch)
        bankName = try? values?.decodeIfPresent(String.self, forKey: .bankName)
        busy = try? values?.decodeIfPresent(String.self, forKey: .busy)
        companyID = try? values?.decodeIfPresent(String.self, forKey: .companyID)
        countryCode = try? values?.decodeIfPresent(String.self, forKey: .countryCode)
        countryID = try? values?.decodeIfPresent(String.self, forKey: .countryID)
        createdAt = try? values?.decodeIfPresent(String.self, forKey: .createdAt)
        deviceToken = try? values?.decodeIfPresent(String.self, forKey: .deviceToken)
        deviceType = try? values?.decodeIfPresent(String.self, forKey: .deviceType)
        dob = try? values?.decodeIfPresent(String.self, forKey: .dob)
        driverDocs = try? values?.decodeIfPresent(DriverDocs.self, forKey: .driverDocs)
        duty = try? values?.decodeIfPresent(String.self, forKey: .duty)
        email = try? values?.decodeIfPresent(String.self, forKey: .email)
        firstName = try? values?.decodeIfPresent(String.self, forKey: .firstName)
        gender = try? values?.decodeIfPresent(String.self, forKey: .gender)
        id = try? values?.decodeIfPresent(String.self, forKey: .id)
        inviteCode = try? values?.decodeIfPresent(String.self, forKey: .inviteCode)
        lastName = try? values?.decodeIfPresent(String.self, forKey: .lastName)
        lat = try? values?.decodeIfPresent(String.self, forKey: .lat)
        lng = try? values?.decodeIfPresent(String.self, forKey: .lng)
        mobileNo = try? values?.decodeIfPresent(String.self, forKey: .mobileNo)
        profileImage = try? values?.decodeIfPresent(String.self, forKey: .profileImage)
        qrCode = try? values?.decodeIfPresent(String.self, forKey: .qrCode)
        rating = try? values?.decodeIfPresent(String.self, forKey: .rating)
        referralCode = try? values?.decodeIfPresent(String.self, forKey: .referralCode)
        rememberToken = try? values?.decodeIfPresent(String.self, forKey: .rememberToken)
        status = try? values?.decodeIfPresent(String.self, forKey: .status)
        trash = try? values?.decodeIfPresent(String.self, forKey: .trash)
        vehicleInfo = try? values?.decodeIfPresent([VehicleInfo].self, forKey: .vehicleInfo)
        vehicleType = try? values?.decodeIfPresent(String.self, forKey: .vehicleType)
        verify = try? values?.decodeIfPresent(String.self, forKey: .verify)
        walletBalance = try? values?.decodeIfPresent(String.self, forKey: .walletBalance)
        xAPIKey = try? values?.decodeIfPresent(String.self, forKey: .xAPIKey)
    }
    
}

// MARK: - DriverDocs
class DriverDocs: Codable {
    let id, driverID, vehicleInsuranceCerti, vehicleInsuranceExpDate: String?
    let isVerifyVehicleInsurance, driverLicenceImage, driverLicenceExpDate, isVerifyDriverLicence: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case driverID = "driver_id"
        case vehicleInsuranceCerti = "vehicle_insurance_certi"
        case vehicleInsuranceExpDate = "vehicle_insurance_exp_date"
        case isVerifyVehicleInsurance = "is_verify_vehicle_insurance"
        case driverLicenceImage = "driver_licence_image"
        case driverLicenceExpDate = "driver_licence_exp_date"
        case isVerifyDriverLicence = "is_verify_driver_licence"
    }
    
    init(id: String, driverID: String, vehicleInsuranceCerti: String, vehicleInsuranceExpDate: String, isVerifyVehicleInsurance: String, driverLicenceImage: String, driverLicenceExpDate: String, isVerifyDriverLicence: String) {
        self.id = id
        self.driverID = driverID
        self.vehicleInsuranceCerti = vehicleInsuranceCerti
        self.vehicleInsuranceExpDate = vehicleInsuranceExpDate
        self.isVerifyVehicleInsurance = isVerifyVehicleInsurance
        self.driverLicenceImage = driverLicenceImage
        self.driverLicenceExpDate = driverLicenceExpDate
        self.isVerifyDriverLicence = isVerifyDriverLicence
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        driverID = try? values?.decodeIfPresent(String.self, forKey: .driverID)
        driverLicenceExpDate = try values?.decodeIfPresent(String.self, forKey: .driverLicenceExpDate)
        driverLicenceImage = try values?.decodeIfPresent(String.self, forKey: .driverLicenceImage)
        id = try values?.decodeIfPresent(String.self, forKey: .id)
        isVerifyDriverLicence = try values?.decodeIfPresent(String.self, forKey: .isVerifyDriverLicence)
        isVerifyVehicleInsurance = try values?.decodeIfPresent(String.self, forKey: .isVerifyVehicleInsurance)
        vehicleInsuranceCerti = try values?.decodeIfPresent(String.self, forKey: .vehicleInsuranceCerti)
        vehicleInsuranceExpDate = try values?.decodeIfPresent(String.self, forKey: .vehicleInsuranceExpDate)
    }
}

// MARK: - VehicleInfo
class VehicleInfo: Codable {
    let id, companyID, vehicleType, driverID: String?
    let plateNumber, yearOfManufacture, vehicleTypeModelName, vehicleTypeManufacturerName: String?
    let noOfPassenger, vehicleImage, carLeft, carRight: String?
    let carFront, carBack, vehicleTypeName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case companyID = "company_id"
        case vehicleType = "vehicle_type"
        case driverID = "driver_id"
        case plateNumber = "plate_number"
        case yearOfManufacture = "year_of_manufacture"
        case vehicleTypeModelName = "vehicle_type_model_name"
        case vehicleTypeManufacturerName = "vehicle_type_manufacturer_name"
        case noOfPassenger = "no_of_passenger"
        case vehicleImage = "vehicle_image"
        case carLeft = "car_left"
        case carRight = "car_right"
        case carFront = "car_front"
        case carBack = "car_back"
        case vehicleTypeName = "vehicle_type_name"
    }
    
    init(id: String, companyID: String, vehicleType: String, driverID: String, plateNumber: String, yearOfManufacture: String, vehicleTypeModelName: String, vehicleTypeManufacturerName: String, noOfPassenger: String, vehicleImage: String, carLeft: String, carRight: String, carFront: String, carBack: String, vehicleTypeName: String) {
        self.id = id
        self.companyID = companyID
        self.vehicleType = vehicleType
        self.driverID = driverID
        self.plateNumber = plateNumber
        self.yearOfManufacture = yearOfManufacture
        self.vehicleTypeModelName = vehicleTypeModelName
        self.vehicleTypeManufacturerName = vehicleTypeManufacturerName
        self.noOfPassenger = noOfPassenger
        self.vehicleImage = vehicleImage
        self.carLeft = carLeft
        self.carRight = carRight
        self.carFront = carFront
        self.carBack = carBack
        self.vehicleTypeName = vehicleTypeName
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        carBack = try values?.decodeIfPresent(String.self, forKey: .carBack)
        carFront = try values?.decodeIfPresent(String.self, forKey: .carFront)
        carLeft = try values?.decodeIfPresent(String.self, forKey: .carLeft)
        carRight = try values?.decodeIfPresent(String.self, forKey: .carRight)
        companyID = try values?.decodeIfPresent(String.self, forKey: .companyID)
        driverID = try values?.decodeIfPresent(String.self, forKey: .driverID)
        id = try values?.decodeIfPresent(String.self, forKey: .id)
        noOfPassenger = try values?.decodeIfPresent(String.self, forKey: .noOfPassenger)
        plateNumber = try values?.decodeIfPresent(String.self, forKey: .plateNumber)
        vehicleImage = try values?.decodeIfPresent(String.self, forKey: .vehicleImage)
        vehicleType = try values?.decodeIfPresent(String.self, forKey: .vehicleType)
        vehicleTypeManufacturerName = try values?.decodeIfPresent(String.self, forKey: .vehicleTypeManufacturerName)
        vehicleTypeModelName = try values?.decodeIfPresent(String.self, forKey: .vehicleTypeModelName)
        vehicleTypeName = try values?.decodeIfPresent(String.self, forKey: .vehicleTypeName)
        yearOfManufacture = try values?.decodeIfPresent(String.self, forKey: .yearOfManufacture)
    }
}



