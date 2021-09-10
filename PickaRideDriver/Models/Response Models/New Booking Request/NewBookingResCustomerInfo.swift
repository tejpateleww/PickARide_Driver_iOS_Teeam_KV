//
//  NewBookingResCustomerInfo.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 10, 2021

import Foundation
import SwiftyJSON


class NewBookingResCustomerInfo : NSObject, NSCoding{

    var address : String!
    var companyId : String!
    var countryCode : String!
    var countryId : String!
    var createdAt : String!
    var deviceToken : String!
    var deviceType : String!
    var dob : String!
    var email : String!
    var firstName : String!
    var gender : String!
    var id : String!
    var isSocial : String!
    var lastName : String!
    var lat : String!
    var lng : String!
    var mobileNo : String!
    var password : String!
    var profileImage : String!
    var qrCode : String!
    var rating : String!
    var referralCode : String!
    var rememberToken : String!
    var socialId : String!
    var socialType : String!
    var status : String!
    var trash : String!
    var walletBalance : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        address = json["address"].stringValue
        companyId = json["company_id"].stringValue
        countryCode = json["country_code"].stringValue
        countryId = json["country_id"].stringValue
        createdAt = json["created_at"].stringValue
        deviceToken = json["device_token"].stringValue
        deviceType = json["device_type"].stringValue
        dob = json["dob"].stringValue
        email = json["email"].stringValue
        firstName = json["first_name"].stringValue
        gender = json["gender"].stringValue
        id = json["id"].stringValue
        isSocial = json["is_social"].stringValue
        lastName = json["last_name"].stringValue
        lat = json["lat"].stringValue
        lng = json["lng"].stringValue
        mobileNo = json["mobile_no"].stringValue
        password = json["password"].stringValue
        profileImage = json["profile_image"].stringValue
        qrCode = json["qr_code"].stringValue
        rating = json["rating"].stringValue
        referralCode = json["referral_code"].stringValue
        rememberToken = json["remember_token"].stringValue
        socialId = json["social_id"].stringValue
        socialType = json["social_type"].stringValue
        status = json["status"].stringValue
        trash = json["trash"].stringValue
        walletBalance = json["wallet_balance"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if address != nil{
        	dictionary["address"] = address
        }
        if companyId != nil{
        	dictionary["company_id"] = companyId
        }
        if countryCode != nil{
        	dictionary["country_code"] = countryCode
        }
        if countryId != nil{
        	dictionary["country_id"] = countryId
        }
        if createdAt != nil{
        	dictionary["created_at"] = createdAt
        }
        if deviceToken != nil{
        	dictionary["device_token"] = deviceToken
        }
        if deviceType != nil{
        	dictionary["device_type"] = deviceType
        }
        if dob != nil{
        	dictionary["dob"] = dob
        }
        if email != nil{
        	dictionary["email"] = email
        }
        if firstName != nil{
        	dictionary["first_name"] = firstName
        }
        if gender != nil{
        	dictionary["gender"] = gender
        }
        if id != nil{
        	dictionary["id"] = id
        }
        if isSocial != nil{
        	dictionary["is_social"] = isSocial
        }
        if lastName != nil{
        	dictionary["last_name"] = lastName
        }
        if lat != nil{
        	dictionary["lat"] = lat
        }
        if lng != nil{
        	dictionary["lng"] = lng
        }
        if mobileNo != nil{
        	dictionary["mobile_no"] = mobileNo
        }
        if password != nil{
        	dictionary["password"] = password
        }
        if profileImage != nil{
        	dictionary["profile_image"] = profileImage
        }
        if qrCode != nil{
        	dictionary["qr_code"] = qrCode
        }
        if rating != nil{
        	dictionary["rating"] = rating
        }
        if referralCode != nil{
        	dictionary["referral_code"] = referralCode
        }
        if rememberToken != nil{
        	dictionary["remember_token"] = rememberToken
        }
        if socialId != nil{
        	dictionary["social_id"] = socialId
        }
        if socialType != nil{
        	dictionary["social_type"] = socialType
        }
        if status != nil{
        	dictionary["status"] = status
        }
        if trash != nil{
        	dictionary["trash"] = trash
        }
        if walletBalance != nil{
        	dictionary["wallet_balance"] = walletBalance
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		address = aDecoder.decodeObject(forKey: "address") as? String
		companyId = aDecoder.decodeObject(forKey: "company_id") as? String
		countryCode = aDecoder.decodeObject(forKey: "country_code") as? String
		countryId = aDecoder.decodeObject(forKey: "country_id") as? String
		createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
		deviceToken = aDecoder.decodeObject(forKey: "device_token") as? String
		deviceType = aDecoder.decodeObject(forKey: "device_type") as? String
		dob = aDecoder.decodeObject(forKey: "dob") as? String
		email = aDecoder.decodeObject(forKey: "email") as? String
		firstName = aDecoder.decodeObject(forKey: "first_name") as? String
		gender = aDecoder.decodeObject(forKey: "gender") as? String
		id = aDecoder.decodeObject(forKey: "id") as? String
		isSocial = aDecoder.decodeObject(forKey: "is_social") as? String
		lastName = aDecoder.decodeObject(forKey: "last_name") as? String
		lat = aDecoder.decodeObject(forKey: "lat") as? String
		lng = aDecoder.decodeObject(forKey: "lng") as? String
		mobileNo = aDecoder.decodeObject(forKey: "mobile_no") as? String
		password = aDecoder.decodeObject(forKey: "password") as? String
		profileImage = aDecoder.decodeObject(forKey: "profile_image") as? String
		qrCode = aDecoder.decodeObject(forKey: "qr_code") as? String
		rating = aDecoder.decodeObject(forKey: "rating") as? String
		referralCode = aDecoder.decodeObject(forKey: "referral_code") as? String
		rememberToken = aDecoder.decodeObject(forKey: "remember_token") as? String
		socialId = aDecoder.decodeObject(forKey: "social_id") as? String
		socialType = aDecoder.decodeObject(forKey: "social_type") as? String
		status = aDecoder.decodeObject(forKey: "status") as? String
		trash = aDecoder.decodeObject(forKey: "trash") as? String
		walletBalance = aDecoder.decodeObject(forKey: "wallet_balance") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if companyId != nil{
			aCoder.encode(companyId, forKey: "company_id")
		}
		if countryCode != nil{
			aCoder.encode(countryCode, forKey: "country_code")
		}
		if countryId != nil{
			aCoder.encode(countryId, forKey: "country_id")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if deviceToken != nil{
			aCoder.encode(deviceToken, forKey: "device_token")
		}
		if deviceType != nil{
			aCoder.encode(deviceType, forKey: "device_type")
		}
		if dob != nil{
			aCoder.encode(dob, forKey: "dob")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if firstName != nil{
			aCoder.encode(firstName, forKey: "first_name")
		}
		if gender != nil{
			aCoder.encode(gender, forKey: "gender")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isSocial != nil{
			aCoder.encode(isSocial, forKey: "is_social")
		}
		if lastName != nil{
			aCoder.encode(lastName, forKey: "last_name")
		}
		if lat != nil{
			aCoder.encode(lat, forKey: "lat")
		}
		if lng != nil{
			aCoder.encode(lng, forKey: "lng")
		}
		if mobileNo != nil{
			aCoder.encode(mobileNo, forKey: "mobile_no")
		}
		if password != nil{
			aCoder.encode(password, forKey: "password")
		}
		if profileImage != nil{
			aCoder.encode(profileImage, forKey: "profile_image")
		}
		if qrCode != nil{
			aCoder.encode(qrCode, forKey: "qr_code")
		}
		if rating != nil{
			aCoder.encode(rating, forKey: "rating")
		}
		if referralCode != nil{
			aCoder.encode(referralCode, forKey: "referral_code")
		}
		if rememberToken != nil{
			aCoder.encode(rememberToken, forKey: "remember_token")
		}
		if socialId != nil{
			aCoder.encode(socialId, forKey: "social_id")
		}
		if socialType != nil{
			aCoder.encode(socialType, forKey: "social_type")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if trash != nil{
			aCoder.encode(trash, forKey: "trash")
		}
		if walletBalance != nil{
			aCoder.encode(walletBalance, forKey: "wallet_balance")
		}

	}

}
