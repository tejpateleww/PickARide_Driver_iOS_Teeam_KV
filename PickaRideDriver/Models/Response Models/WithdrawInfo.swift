//
//  WithdrawInfo.swift
//  PickaRideDriver
//
//  Created by Gaurang on 06/09/22.
//

import Foundation

struct WithdrawInfo: Codable {
    let id: String
    let requestDate, approveDate, amount, status: String?
    
    enum CodingKeys: String, CodingKey {
        case id, amount, status
        case requestDate = "request_date"
        case approveDate = "approve_date"
    }
}
