//
//  CardValidatorType.swift
//  Danfo_Rider
//
//  Created by Hetu on 06/04/21.
//

import Foundation

public func ==(lhs: CreditCardValidationType, rhs: CreditCardValidationType) -> Bool {
    return lhs.name == rhs.name
}

public struct CreditCardValidationType: Equatable {
    
    public var name: String
    
    public var regex: String

    public init(dict: [String: Any]) {
        if let name = dict["name"] as? String {
            self.name = name
        } else {
            self.name = ""
        }
        
        if let regex = dict["regex"] as? String {
            self.regex = regex
        } else {
            self.regex = ""
        }
    }
    
}

