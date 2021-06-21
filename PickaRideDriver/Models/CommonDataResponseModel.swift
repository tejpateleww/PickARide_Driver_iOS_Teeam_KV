//
//  CommonDataResponseModel.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 08/06/21.
//

import Foundation

//MARK: COMMON REQUEST MODEL

// MARK: - CardListReqModel
class CommonUserIdRequestModel: Codable {
    var customerID: String?

    enum CodingKeys: String, CodingKey {
        case customerID = "customer_id"
    }

    init(customerID: String?) {
        self.customerID = customerID
    }
    init() { }
}



//MARK: - COMMON RESPONSE MODEL
class CountryDataResponseModel: Codable {
    var status: Bool?
    var message: String?
    var data: [CountryDetailModel]?

    init(status: Bool?, message: String?, data: [CountryDetailModel]?) {
        self.status = status
        self.message = message
        self.data = data
    }
}

class CountryDetailModel : Codable {
    var id, name, shortName, countryCode: String?
    var currency, status: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case shortName = "short_name"
        case countryCode = "country_code"
        case currency, status
    }

    init(id: String?, name: String?, shortName: String?, countryCode: String?, currency: String?, status: String?) {
        self.id = id
        self.name = name
        self.shortName = shortName
        self.countryCode = countryCode
        self.currency = currency
        self.status = status
    }
}

class LogoutReponseModel: Codable {
    var status: Bool?
    var message: String?
    
    init(status: Bool?, message: String?) {
        self.status = status
        self.message = message
    
    }
}
