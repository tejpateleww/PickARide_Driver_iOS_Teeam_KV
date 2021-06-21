//
//  UserInfo.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on December 14, 2020

import Foundation
import SwiftyJSON


class UserInfo : Codable{

    var arabicMessage : String!
    var data : Datum!
    var message : String!
    var status : Bool!
    var xApiKey : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        arabicMessage = json["arabic_message"].stringValue
        let dataJson = json["data"]
        if !dataJson.isEmpty{
            data = Datum(fromJson: dataJson)
        }
        message = json["message"].stringValue
        status = json["status"].boolValue
        xApiKey = json["x-api-key"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if arabicMessage != nil{
        	dictionary["arabic_message"] = arabicMessage
        }
        if data != nil{
        	dictionary["data"] = data.toDictionary()
        }
        if message != nil{
        	dictionary["message"] = message
        }
        if status != nil{
        	dictionary["status"] = status
        }
        if xApiKey != nil{
        	dictionary["x-api-key"] = xApiKey
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		arabicMessage = aDecoder.decodeObject(forKey: "arabic_message") as? String
		data = aDecoder.decodeObject(forKey: "data") as? Datum
		message = aDecoder.decodeObject(forKey: "message") as? String
		status = aDecoder.decodeObject(forKey: "status") as? Bool
		xApiKey = aDecoder.decodeObject(forKey: "x-api-key") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if arabicMessage != nil{
			aCoder.encode(arabicMessage, forKey: "arabic_message")
		}
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if xApiKey != nil{
			aCoder.encode(xApiKey, forKey: "x-api-key")
		}

	}

}
