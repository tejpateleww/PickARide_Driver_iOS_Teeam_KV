//
//  NewBookingResVehicleType.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 10, 2021

import Foundation
import SwiftyJSON


class NewBookingResVehicleType : NSObject, NSCoding{

    var baseCharge : String!
    var baseKm : String!
    var bookingFee : String!
    var capacity : String!
    var commission : String!
    var createdAt : String!
    var customerCancellationFee : String!
    var descriptionField : String!
    var driverCancellationFee : String!
    var extraCharge : String!
    var freeCancallationTime : String!
    var id : String!
    var image : String!
    var isNightCharge : String!
    var isSpecialEventCharge : String!
    var name : String!
    var nightCharge : String!
    var nightFrom : String!
    var nightTo : String!
    var perKmCharge : String!
    var perMinuteCharge : String!
    var premiumCharge : String!
    var specialEventCharge : String!
    var specialEventFrom : String!
    var specialEventTo : String!
    var status : String!
    var trash : String!
    var unselectImage : String!
    var updatedAt : String!
    var waitingTimePerMinCharge : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        baseCharge = json["base_charge"].stringValue
        baseKm = json["base_km"].stringValue
        bookingFee = json["booking_fee"].stringValue
        capacity = json["capacity"].stringValue
        commission = json["commission"].stringValue
        createdAt = json["created_at"].stringValue
        customerCancellationFee = json["customer_cancellation_fee"].stringValue
        descriptionField = json["description"].stringValue
        driverCancellationFee = json["driver_cancellation_fee"].stringValue
        extraCharge = json["extra_charge"].stringValue
        freeCancallationTime = json["free_cancallation_time"].stringValue
        id = json["id"].stringValue
        image = json["image"].stringValue
        isNightCharge = json["is_night_charge"].stringValue
        isSpecialEventCharge = json["is_special_event_charge"].stringValue
        name = json["name"].stringValue
        nightCharge = json["night_charge"].stringValue
        nightFrom = json["night_from"].stringValue
        nightTo = json["night_to"].stringValue
        perKmCharge = json["per_km_charge"].stringValue
        perMinuteCharge = json["per_minute_charge"].stringValue
        premiumCharge = json["premium_charge"].stringValue
        specialEventCharge = json["special_event_charge"].stringValue
        specialEventFrom = json["special_event_from"].stringValue
        specialEventTo = json["special_event_to"].stringValue
        status = json["status"].stringValue
        trash = json["trash"].stringValue
        unselectImage = json["unselect_image"].stringValue
        updatedAt = json["updated_at"].stringValue
        waitingTimePerMinCharge = json["waiting_time_per_min_charge"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if baseCharge != nil{
        	dictionary["base_charge"] = baseCharge
        }
        if baseKm != nil{
        	dictionary["base_km"] = baseKm
        }
        if bookingFee != nil{
        	dictionary["booking_fee"] = bookingFee
        }
        if capacity != nil{
        	dictionary["capacity"] = capacity
        }
        if commission != nil{
        	dictionary["commission"] = commission
        }
        if createdAt != nil{
        	dictionary["created_at"] = createdAt
        }
        if customerCancellationFee != nil{
        	dictionary["customer_cancellation_fee"] = customerCancellationFee
        }
        if descriptionField != nil{
        	dictionary["description"] = descriptionField
        }
        if driverCancellationFee != nil{
        	dictionary["driver_cancellation_fee"] = driverCancellationFee
        }
        if extraCharge != nil{
        	dictionary["extra_charge"] = extraCharge
        }
        if freeCancallationTime != nil{
        	dictionary["free_cancallation_time"] = freeCancallationTime
        }
        if id != nil{
        	dictionary["id"] = id
        }
        if image != nil{
        	dictionary["image"] = image
        }
        if isNightCharge != nil{
        	dictionary["is_night_charge"] = isNightCharge
        }
        if isSpecialEventCharge != nil{
        	dictionary["is_special_event_charge"] = isSpecialEventCharge
        }
        if name != nil{
        	dictionary["name"] = name
        }
        if nightCharge != nil{
        	dictionary["night_charge"] = nightCharge
        }
        if nightFrom != nil{
        	dictionary["night_from"] = nightFrom
        }
        if nightTo != nil{
        	dictionary["night_to"] = nightTo
        }
        if perKmCharge != nil{
        	dictionary["per_km_charge"] = perKmCharge
        }
        if perMinuteCharge != nil{
        	dictionary["per_minute_charge"] = perMinuteCharge
        }
        if premiumCharge != nil{
        	dictionary["premium_charge"] = premiumCharge
        }
        if specialEventCharge != nil{
        	dictionary["special_event_charge"] = specialEventCharge
        }
        if specialEventFrom != nil{
        	dictionary["special_event_from"] = specialEventFrom
        }
        if specialEventTo != nil{
        	dictionary["special_event_to"] = specialEventTo
        }
        if status != nil{
        	dictionary["status"] = status
        }
        if trash != nil{
        	dictionary["trash"] = trash
        }
        if unselectImage != nil{
        	dictionary["unselect_image"] = unselectImage
        }
        if updatedAt != nil{
        	dictionary["updated_at"] = updatedAt
        }
        if waitingTimePerMinCharge != nil{
        	dictionary["waiting_time_per_min_charge"] = waitingTimePerMinCharge
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		baseCharge = aDecoder.decodeObject(forKey: "base_charge") as? String
		baseKm = aDecoder.decodeObject(forKey: "base_km") as? String
		bookingFee = aDecoder.decodeObject(forKey: "booking_fee") as? String
		capacity = aDecoder.decodeObject(forKey: "capacity") as? String
		commission = aDecoder.decodeObject(forKey: "commission") as? String
		createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
		customerCancellationFee = aDecoder.decodeObject(forKey: "customer_cancellation_fee") as? String
		descriptionField = aDecoder.decodeObject(forKey: "description") as? String
		driverCancellationFee = aDecoder.decodeObject(forKey: "driver_cancellation_fee") as? String
		extraCharge = aDecoder.decodeObject(forKey: "extra_charge") as? String
		freeCancallationTime = aDecoder.decodeObject(forKey: "free_cancallation_time") as? String
		id = aDecoder.decodeObject(forKey: "id") as? String
		image = aDecoder.decodeObject(forKey: "image") as? String
		isNightCharge = aDecoder.decodeObject(forKey: "is_night_charge") as? String
		isSpecialEventCharge = aDecoder.decodeObject(forKey: "is_special_event_charge") as? String
		name = aDecoder.decodeObject(forKey: "name") as? String
		nightCharge = aDecoder.decodeObject(forKey: "night_charge") as? String
		nightFrom = aDecoder.decodeObject(forKey: "night_from") as? String
		nightTo = aDecoder.decodeObject(forKey: "night_to") as? String
		perKmCharge = aDecoder.decodeObject(forKey: "per_km_charge") as? String
		perMinuteCharge = aDecoder.decodeObject(forKey: "per_minute_charge") as? String
		premiumCharge = aDecoder.decodeObject(forKey: "premium_charge") as? String
		specialEventCharge = aDecoder.decodeObject(forKey: "special_event_charge") as? String
		specialEventFrom = aDecoder.decodeObject(forKey: "special_event_from") as? String
		specialEventTo = aDecoder.decodeObject(forKey: "special_event_to") as? String
		status = aDecoder.decodeObject(forKey: "status") as? String
		trash = aDecoder.decodeObject(forKey: "trash") as? String
		unselectImage = aDecoder.decodeObject(forKey: "unselect_image") as? String
		updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
		waitingTimePerMinCharge = aDecoder.decodeObject(forKey: "waiting_time_per_min_charge") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if baseCharge != nil{
			aCoder.encode(baseCharge, forKey: "base_charge")
		}
		if baseKm != nil{
			aCoder.encode(baseKm, forKey: "base_km")
		}
		if bookingFee != nil{
			aCoder.encode(bookingFee, forKey: "booking_fee")
		}
		if capacity != nil{
			aCoder.encode(capacity, forKey: "capacity")
		}
		if commission != nil{
			aCoder.encode(commission, forKey: "commission")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if customerCancellationFee != nil{
			aCoder.encode(customerCancellationFee, forKey: "customer_cancellation_fee")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if driverCancellationFee != nil{
			aCoder.encode(driverCancellationFee, forKey: "driver_cancellation_fee")
		}
		if extraCharge != nil{
			aCoder.encode(extraCharge, forKey: "extra_charge")
		}
		if freeCancallationTime != nil{
			aCoder.encode(freeCancallationTime, forKey: "free_cancallation_time")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if isNightCharge != nil{
			aCoder.encode(isNightCharge, forKey: "is_night_charge")
		}
		if isSpecialEventCharge != nil{
			aCoder.encode(isSpecialEventCharge, forKey: "is_special_event_charge")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if nightCharge != nil{
			aCoder.encode(nightCharge, forKey: "night_charge")
		}
		if nightFrom != nil{
			aCoder.encode(nightFrom, forKey: "night_from")
		}
		if nightTo != nil{
			aCoder.encode(nightTo, forKey: "night_to")
		}
		if perKmCharge != nil{
			aCoder.encode(perKmCharge, forKey: "per_km_charge")
		}
		if perMinuteCharge != nil{
			aCoder.encode(perMinuteCharge, forKey: "per_minute_charge")
		}
		if premiumCharge != nil{
			aCoder.encode(premiumCharge, forKey: "premium_charge")
		}
		if specialEventCharge != nil{
			aCoder.encode(specialEventCharge, forKey: "special_event_charge")
		}
		if specialEventFrom != nil{
			aCoder.encode(specialEventFrom, forKey: "special_event_from")
		}
		if specialEventTo != nil{
			aCoder.encode(specialEventTo, forKey: "special_event_to")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if trash != nil{
			aCoder.encode(trash, forKey: "trash")
		}
		if unselectImage != nil{
			aCoder.encode(unselectImage, forKey: "unselect_image")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if waitingTimePerMinCharge != nil{
			aCoder.encode(waitingTimePerMinCharge, forKey: "waiting_time_per_min_charge")
		}

	}

}
