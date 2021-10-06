//
//  sendMessageReqModel.swift
//  PickaRideDriver
//
//  Created by Tej on 06/10/21.
//

import Foundation

class sendMessageReqModel1 : Encodable{
    var senderId : String? = SingletonClass.sharedInstance.UserId
    var receiverId: String?
    var message: String?
    var senderType: String?
    var receiverType: String?
    var bookingId: String?
    
    enum CodingKeys: String, CodingKey {
        case senderId = "sender_id"
        case receiverId = "receiver_id"
        case message = "message"
        case senderType = "sender_type"
        case receiverType = "receiver_type"
        case bookingId = "booking_id"
    }
}

class sendMessageReqModel : RequestModel {
    var sender_id : String = ""
    var receiver_id : String = ""
    var message : String = ""
    var sender_type : String = ""
    var receiver_type : String = ""
    var booking_id : String = ""
}
