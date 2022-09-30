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

struct WithdrawMoneyResponse: Codable {
    let status: Bool
    let message: String?
    let totalEarning: String?

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case totalEarning = "total_earning"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decode(Bool.self, forKey: .status)
        if let messageArray = try? values.decode([String].self, forKey: .message) {
            self.message = messageArray.joined(separator: ",\n")
        } else {
            self.message = try? values.decode(String.self, forKey: .message)
        }
        totalEarning = try? values.decode(String.self, forKey: .totalEarning)
    }
}
