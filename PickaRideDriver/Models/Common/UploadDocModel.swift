//
//  UploadDocModel.swift
//  PickaRideDriver
//
//  Created by apple on 7/19/21.
//

import Foundation

class UploadSingleDocResponseModel : Codable {
    
    let status : Bool?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case url = "url"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status) ?? Bool()
        url = try? values?.decodeIfPresent(String.self, forKey: .url) ?? ""
    }
    
}
