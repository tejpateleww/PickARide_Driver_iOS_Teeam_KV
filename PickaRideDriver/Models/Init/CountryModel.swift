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
}
