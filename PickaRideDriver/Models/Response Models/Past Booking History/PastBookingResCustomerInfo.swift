//
//  PastBookingResCustomerInfo.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 16, 2021

import Foundation

class PastBookingResCustomerInfo : Codable {

        let address : String?
        let companyId : String?
        let countryCode : String?
        let countryId : String?
        let createdAt : String?
        let deviceToken : String?
        let deviceType : String?
        let dob : String?
        let email : String?
        let firstName : String?
        let gender : String?
        let id : String?
        let isSocial : String?
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
        let socialId : String?
        let socialType : String?
        let status : String?
        let trash : String?
        let walletBalance : String?

        enum CodingKeys: String, CodingKey {
                case address = "address"
                case companyId = "company_id"
                case countryCode = "country_code"
                case countryId = "country_id"
                case createdAt = "created_at"
                case deviceToken = "device_token"
                case deviceType = "device_type"
                case dob = "dob"
                case email = "email"
                case firstName = "first_name"
                case gender = "gender"
                case id = "id"
                case isSocial = "is_social"
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
                case socialId = "social_id"
                case socialType = "social_type"
                case status = "status"
                case trash = "trash"
                case walletBalance = "wallet_balance"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                address = try values.decodeIfPresent(String.self, forKey: .address)
                companyId = try values.decodeIfPresent(String.self, forKey: .companyId)
                countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
                countryId = try values.decodeIfPresent(String.self, forKey: .countryId)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                deviceToken = try values.decodeIfPresent(String.self, forKey: .deviceToken)
                deviceType = try values.decodeIfPresent(String.self, forKey: .deviceType)
                dob = try values.decodeIfPresent(String.self, forKey: .dob)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
                gender = try values.decodeIfPresent(String.self, forKey: .gender)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                isSocial = try values.decodeIfPresent(String.self, forKey: .isSocial)
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
                socialId = try values.decodeIfPresent(String.self, forKey: .socialId)
                socialType = try values.decodeIfPresent(String.self, forKey: .socialType)
                status = try values.decodeIfPresent(String.self, forKey: .status)
                trash = try values.decodeIfPresent(String.self, forKey: .trash)
                walletBalance = try values.decodeIfPresent(String.self, forKey: .walletBalance)
        }

}
