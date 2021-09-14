//
//  VerifyCustomerModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 14, 2021

import Foundation

struct VerifyCustomerModel : Codable {

        let message : String?
        let otp : String?
        let status : Bool?

        enum CodingKeys: String, CodingKey {
                case message = "message"
                case otp = "otp"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                otp = try values.decodeIfPresent(String.self, forKey: .otp)
                status = try values.decodeIfPresent(Bool.self, forKey: .status)
        }

}
