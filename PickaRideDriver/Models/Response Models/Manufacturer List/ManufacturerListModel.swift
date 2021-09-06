//
//  ManufacturerListModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 6, 2021

import Foundation

class ManufacturerListModel : Codable {
    
    let data : [ManufacturerListDatum]?
    let message : String?
    let status : Bool?
    let yearList : [Int]?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
        case yearList = "year_list"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([ManufacturerListDatum].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        yearList = try values.decodeIfPresent([Int].self, forKey: .yearList)
    }
    
}
