//
//  LogoutReqModel.swift
//  PickaRideDriver
//
//  Created by Tej on 09/09/21.
//

import Foundation

class LogoutReqModel: Encodable{
    var email : String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
    }
}
