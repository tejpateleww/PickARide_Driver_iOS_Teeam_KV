//
//  RateAndReviewModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 14, 2021

import Foundation

class RateAndReviewModel : Codable {
    
    let message : String?
    let status : Bool?
    let yourRating : Float?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case status = "status"
        case yourRating = "your_rating"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        yourRating = try values.decodeIfPresent(Float.self, forKey: .yourRating)
    }
    
}
