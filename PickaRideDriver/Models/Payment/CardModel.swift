//
//  CardRequestResponseModel.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 10/06/21.
//

import Foundation
class AddCardRequestModel : Codable{
    var driver_id : String? = SingletonClass.sharedInstance.UserId
    var exp_date_year : String?
    var exp_date_month : String?
    var card_holder_name : String?
    var card_no : String?
    var cvv : String?
    
    enum CodingKeys: String, CodingKey {
        case driver_id = "driver_id"
        case exp_date_year = "exp_date_year"
        case exp_date_month = "exp_date_month"
        case card_holder_name = "card_holder_name"
        case card_no = "card_no"
        case cvv = "cvv"
    }
}
// MARK: - CardListResponseModel
struct AddCard: Codable {
    let status: Bool
    let message: String
    let cards: [Card]
}

// MARK: - Card
struct Card: Codable {
    let id, cardNo, formatedCardNo, cardHolderName: String
    let cardType, expDateMonth, expDateYear: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case cardNo = "card_no"
        case formatedCardNo = "formated_card_no"
        case cardHolderName = "card_holder_name"
        case cardType = "card_type"
        case expDateMonth = "exp_date_month"
        case expDateYear = "exp_date_year"
    }
}

