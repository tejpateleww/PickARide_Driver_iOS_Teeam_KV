//
//  CountryListModel.swift
//  PickARide User
//
//  Created by apple on 6/29/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

class CountryListModel: Codable {
    let status: Bool?
    let message: String?
    let data: [CountryDetilsModel]?
    
    init(status: Bool, message: String, data: [CountryDetilsModel]) {
        self.status = status
        self.message = message
        self.data = data
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        data = try? values?.decodeIfPresent([CountryDetilsModel].self, forKey: .data)
        message = try? values?.decodeIfPresent(String.self, forKey: .message)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
    }
}

class CountryDetilsModel: Codable {
    let id, name, shortName, countryCode: String?
    let currency, status: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case shortName = "short_name"
        case countryCode = "country_code"
        case currency, status
    }
    
    init(id: String, name: String, shortName: String, countryCode: String, currency: String, status: String) {
        self.id = id
        self.name = name
        self.shortName = shortName
        self.countryCode = countryCode
        self.currency = currency
        self.status = status
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        countryCode = try? values?.decodeIfPresent(String.self, forKey: .countryCode)
        currency = try? values?.decodeIfPresent(String.self, forKey: .currency)
        id = try? values?.decodeIfPresent(String.self, forKey: .id)
        name = try? values?.decodeIfPresent(String.self, forKey: .name)
        shortName = try? values?.decodeIfPresent(String.self, forKey: .shortName)
        status = try? values?.decodeIfPresent(String.self, forKey: .status)
    }
}

// City Model
class CityListModel: Codable {
    let status: Bool?
    let message: String?
    let data: [CityDetailsModel]?
    
    init(status: Bool, message: String, data: [CityDetailsModel]) {
        self.status = status
        self.message = message
        self.data = data
    }
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        data = try? values?.decodeIfPresent([CityDetailsModel].self, forKey: .data)
        message = try? values?.decodeIfPresent(String.self, forKey: .message)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
    }
}

class CityDetailsModel: Codable {

  var id, cityName, lat, lang: String?
  var status, trash, createdAt: String?
  var countryCode, countryId: String?
  
  enum CodingKeys: String, CodingKey {
    case id        = "id"
    case cityName  = "city_name"
    case lat       = "lat"
    case lang      = "lang"
    case status    = "status"
    case trash     = "trash"
    case createdAt = "created_at"
    case countryCode = "country_code"
    case countryId = "country_id"
  }

  required init(from decoder: Decoder) throws {
    let values = try? decoder.container(keyedBy: CodingKeys.self)
    id        = try? values?.decodeIfPresent(String.self , forKey: .id)
    cityName  = try? values?.decodeIfPresent(String.self , forKey: .cityName)
    lat       = try? values?.decodeIfPresent(String.self , forKey: .lat)
    lang      = try? values?.decodeIfPresent(String.self , forKey: .lang)
    status    = try? values?.decodeIfPresent(String.self , forKey: .status)
    trash     = try? values?.decodeIfPresent(String.self , forKey: .trash)
    createdAt = try? values?.decodeIfPresent(String.self , forKey: .createdAt)
    countryCode  = try? values?.decodeIfPresent(String.self , forKey: .countryCode)
    countryId  = try? values?.decodeIfPresent(String.self , forKey: .countryId)
  }

  init() {

  }

}
