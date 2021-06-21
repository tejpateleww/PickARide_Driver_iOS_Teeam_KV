//
//  CardRequestResponseModel.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 10/06/21.
//

import Foundation
class AddCardRequestModel : Codable{
    var customer_id : String?
    var exp_date_year : String?
    var exp_date_month : String?
    var card_holder_name : String?
    var card_no : String?
    var cvv : String?
    
    enum CodingKeys: String, CodingKey {
        case customer_id = "customer_id"
        case exp_date_year = "exp_date_year"
        case exp_date_month = "exp_date_month"
        case card_holder_name = "card_holder_name"
        case card_no = "card_no"
        case cvv = "cvv"
    }
    
    init(customer_id: String?,exp_date_year: String?,exp_date_month: String?,card_holder_name: String?,card_no: String?,cvv: String? ) {
        self.customer_id = customer_id
        self.exp_date_year = exp_date_year
        self.exp_date_month = exp_date_month
        self.card_holder_name = card_holder_name
        self.card_no = card_no
        self.cvv = cvv
    }
}




// MARK: - CardListResponseModel
class CardListResponseModel: Codable {
    var status: Bool?
    var message: String?
    var cards: [Card]?

    init(status: Bool?, message: String?, cards: [Card]?) {
        self.status = status
        self.message = message
        self.cards = cards
    }
}

// MARK: - Card
class Card: Codable {
    var id, cardNo, formatedCardNo, cardHolderName: String?
    var cardType, expDateMonth, expDateYear: String?

    enum CodingKeys: String, CodingKey {
        case id
        case cardNo = "card_no"
        case formatedCardNo = "formated_card_no"
        case cardHolderName = "card_holder_name"
        case cardType = "card_type"
        case expDateMonth = "exp_date_month"
        case expDateYear = "exp_date_year"
    }

    init(id: String?, cardNo: String?, formatedCardNo: String?, cardHolderName: String?, cardType: String?, expDateMonth: String?, expDateYear: String?) {
        self.id = id
        self.cardNo = cardNo
        self.formatedCardNo = formatedCardNo
        self.cardHolderName = cardHolderName
        self.cardType = cardType
        self.expDateMonth = expDateMonth
        self.expDateYear = expDateYear
    }
}

