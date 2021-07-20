//
//  WalletRequestResponseModel.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 14/06/21.
//

import Foundation

// MARK: - AddMoneyRequestModel
class AddMoneyRequestModel: Codable {
    var customerID, cardID: String?
    var amount: String?
    
    enum CodingKeys: String, CodingKey {
        case customerID = "customer_id"
        case cardID = "card_id"
        case amount
    }
    
    init(customerID: String?, cardID: String?, amount: String?) {
        self.customerID = customerID
        self.cardID = cardID
        self.amount = amount
    }
}


// MARK: - AddMoneyResponseModel
class AddMoneyResponseModel: Codable {
    var status: Bool?
    var walletBalance: Float?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case walletBalance = "wallet_balance"
        case message
    }
    
    init(status: Bool?, walletBalance: Float?, message: String?) {
        self.status = status
        self.walletBalance = walletBalance
        self.message = message
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        message = try? values?.decodeIfPresent(String.self, forKey: .message)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
        walletBalance = try? values?.decodeIfPresent(Float.self, forKey: .walletBalance)
    }
}

// MARK: - WalletHistoryRequestModel
class WalletHistoryRequestModel: Codable {
    var customerID : String?
    var page: Int?
    
    enum CodingKeys: String, CodingKey {
        case customerID = "customer_id"
        case page
    }
    
    init(customerID: String?, page: Int?) {
        self.customerID = customerID
        self.page = page
    }
}

// MARK: - WalletHistoryListModel
class WalletHistoryListModel: Codable {
    var status: Bool?
    var walletBalance: String?
    var data: [WalletHistoryDetail]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case walletBalance = "wallet_balance"
        case data = "data"
    }
    
    init(status: Bool?, walletBalance: String?, data: [WalletHistoryDetail]?) {
        self.status = status
        self.walletBalance = walletBalance
        self.data = data
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        data = try? values?.decodeIfPresent([WalletHistoryDetail].self, forKey: .data)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
        walletBalance = try? values?.decodeIfPresent(String.self, forKey: .walletBalance)
    }
}

// MARK: - Datum
class WalletHistoryDetail: Codable {
    var id, userID, userType, amount: String?
    var type, datumDescription, referenceID, createdDate: String?
    var transactionType, transactionSubtype, bankReferenceID, response: String?
    var status, cardID: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case userType = "user_type"
        case amount, type
        case datumDescription = "description"
        case referenceID = "reference_id"
        case createdDate = "created_date"
        case transactionType = "transaction_type"
        case transactionSubtype = "transaction_subtype"
        case bankReferenceID = "bank_reference_id"
        case response, status
        case cardID = "card_id"
    }
    
    init(id: String?, userID: String?, userType: String?, amount: String?, type: String?, datumDescription: String?, referenceID: String?, createdDate: String?, transactionType: String?, transactionSubtype: String?, bankReferenceID: String?, response: String?, status: String?, cardID: String?) {
        self.id = id
        self.userID = userID
        self.userType = userType
        self.amount = amount
        self.type = type
        self.datumDescription = datumDescription
        self.referenceID = referenceID
        self.createdDate = createdDate
        self.transactionType = transactionType
        self.transactionSubtype = transactionSubtype
        self.bankReferenceID = bankReferenceID
        self.response = response
        self.status = status
        self.cardID = cardID
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        amount = try? values?.decodeIfPresent(String.self, forKey: .amount)
        bankReferenceID = try? values?.decodeIfPresent(String.self, forKey: .bankReferenceID)
        cardID = try? values?.decodeIfPresent(String.self, forKey: .cardID)
        createdDate = try? values?.decodeIfPresent(String.self, forKey: .createdDate)
        datumDescription = try? values?.decodeIfPresent(String.self, forKey: .datumDescription)
        id = try? values?.decodeIfPresent(String.self, forKey: .id)
        referenceID = try? values?.decodeIfPresent(String.self, forKey: .referenceID)
        response = try? values?.decodeIfPresent(String.self, forKey: .response)
        status = try? values?.decodeIfPresent(String.self, forKey: .status)
        transactionSubtype = try? values?.decodeIfPresent(String.self, forKey: .transactionSubtype)
        transactionType = try? values?.decodeIfPresent(String.self, forKey: .transactionType)
        type = try? values?.decodeIfPresent(String.self, forKey: .type)
        userID = try? values?.decodeIfPresent(String.self, forKey: .userID)
        userType = try? values?.decodeIfPresent(String.self, forKey: .userType)
    }
}


//MARK: Send moeny to mobile number

class walletToMobileNumReqModel: Codable {
    var customerID, mobileNum: String?
    var amount: String?
    var userType : String = "customer"
    
    enum CodingKeys: String, CodingKey {
        case customerID = "sender_id"
        case mobileNum = "mobile_no"
        case amount
        case userType = "user_type"
    }
    
    init(customerID: String?, mobileNum: String?, amount: String?) {
        self.customerID = customerID
        self.mobileNum = mobileNum
        self.amount = amount
    }
}


