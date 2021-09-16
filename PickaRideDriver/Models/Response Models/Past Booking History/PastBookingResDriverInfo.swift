//
//  PastBookingResDriverInfo.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 16, 2021

import Foundation

class PastBookingResDriverInfo : Codable {

        let accountHolderName : String?
        let accountNumber : String?
        let address : String?
        let bankName : String?
        let busy : String?
        let companyId : String?
        let countryCode : String?
        let countryId : String?
        let createdAt : String?
        let deviceToken : String?
        let deviceType : String?
        let dob : String?
        let duty : String?
        let email : String?
        let firstName : String?
        let gender : String?
        let id : String?
        let ifscCode : String?
        let inviteCode : String?
        let lastName : String?
        let lat : String?
        let lng : String?
        let mobileNo : String?
        let password : String?
        let profileImage : String?
        let qrCode : String?
        let rating : String?
        let referralCode : String?
        let rememberToken : String?
        let status : String?
        let trash : String?
        let vehicleType : String?
        let verify : String?
        let walletBalance : String?

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
                case password = "password"
                case profileImage = "profile_image"
                case qrCode = "qr_code"
                case rating = "rating"
                case referralCode = "referral_code"
                case rememberToken = "remember_token"
                case status = "status"
                case trash = "trash"
                case vehicleType = "vehicle_type"
                case verify = "verify"
                case walletBalance = "wallet_balance"
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
                password = try values.decodeIfPresent(String.self, forKey: .password)
                profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
                qrCode = try values.decodeIfPresent(String.self, forKey: .qrCode)
                rating = try values.decodeIfPresent(String.self, forKey: .rating)
                referralCode = try values.decodeIfPresent(String.self, forKey: .referralCode)
                rememberToken = try values.decodeIfPresent(String.self, forKey: .rememberToken)
                status = try values.decodeIfPresent(String.self, forKey: .status)
                trash = try values.decodeIfPresent(String.self, forKey: .trash)
                vehicleType = try values.decodeIfPresent(String.self, forKey: .vehicleType)
                verify = try values.decodeIfPresent(String.self, forKey: .verify)
                walletBalance = try values.decodeIfPresent(String.self, forKey: .walletBalance)
        }

}
