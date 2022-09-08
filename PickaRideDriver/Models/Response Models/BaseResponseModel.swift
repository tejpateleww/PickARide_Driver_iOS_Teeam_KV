//
//  BaseResponseModel.swift
//  PickaRideDriver
//
//  Created by Gaurang on 05/09/22.
//

import Foundation

struct BaseResponseModel<T: Codable>: Codable {
    let status: Bool
    let message: String?
    let data: T?

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decode(Bool.self, forKey: .status)
        if let messageArray = try? values.decode([String].self, forKey: .message) {
            self.message = messageArray.joined(separator: ",\n")
        } else {
            self.message = try? values.decode(String.self, forKey: .message)
        }
        data = try? values.decode(T.self, forKey: .data)
    }
}
