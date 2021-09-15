//
//  cancelReasonDatum.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 15, 2021

import Foundation

class cancelReasonDatum : Codable {

        let createdAt : String?
        let id : String?
        let reason : String?
        let status : String?
        let trash : String?
        let updatedAt : String?
        let userType : String?

        enum CodingKeys: String, CodingKey {
                case createdAt = "created_at"
                case id = "id"
                case reason = "reason"
                case status = "status"
                case trash = "trash"
                case updatedAt = "updated_at"
                case userType = "user_type"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                reason = try values.decodeIfPresent(String.self, forKey: .reason)
                status = try values.decodeIfPresent(String.self, forKey: .status)
                trash = try values.decodeIfPresent(String.self, forKey: .trash)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                userType = try values.decodeIfPresent(String.self, forKey: .userType)
        }

}
