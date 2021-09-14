//
//  RateAndReviewReqModel.swift
//  PickaRideDriver
//
//  Created by Tej on 14/09/21.
//

import Foundation

class RateAndReviewReqModel: Encodable{
    var bookingId : String?
    var rating : String?
    var comment : String?
    
    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_id"
        case rating = "rating"
        case comment = "comment"
    }
}

