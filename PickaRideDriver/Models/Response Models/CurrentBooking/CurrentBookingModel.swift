//
//  CurrentBookingModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 9, 2021

import Foundation

class CurrentBookingModel : Codable {

        let data : CurrentBookingDatum?
        let message : String?
        let status : Bool?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                data = try values.decodeIfPresent(CurrentBookingDatum.self, forKey: .data)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                status = try values.decodeIfPresent(Bool.self, forKey: .status)
        }

}
