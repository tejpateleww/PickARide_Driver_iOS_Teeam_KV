//
//  PastBookingResVehicleType.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 16, 2021

import Foundation

class PastBookingResVehicleType : Codable {

        let baseCharge : String?
        let baseKm : String?
        let bookingFee : String?
        let capacity : String?
        let commission : String?
        let createdAt : String?
        let customerCancellationFee : String?
        let descriptionField : String?
        let driverCancellationFee : String?
        let extraCharge : String?
        let freeCancallationTime : String?
        let id : String?
        let image : String?
        let isNightCharge : String?
        let isSpecialEventCharge : String?
        let name : String?
        let nightCharge : String?
        let nightFrom : String?
        let nightTo : String?
        let perKmCharge : String?
        let perMinuteCharge : String?
        let premiumCharge : String?
        let specialEventCharge : String?
        let specialEventFrom : String?
        let specialEventTo : String?
        let status : String?
        let trash : String?
        let unselectImage : String?
        let updatedAt : String?
        let waitingTimePerMinCharge : String?

        enum CodingKeys: String, CodingKey {
                case baseCharge = "base_charge"
                case baseKm = "base_km"
                case bookingFee = "booking_fee"
                case capacity = "capacity"
                case commission = "commission"
                case createdAt = "created_at"
                case customerCancellationFee = "customer_cancellation_fee"
                case descriptionField = "description"
                case driverCancellationFee = "driver_cancellation_fee"
                case extraCharge = "extra_charge"
                case freeCancallationTime = "free_cancallation_time"
                case id = "id"
                case image = "image"
                case isNightCharge = "is_night_charge"
                case isSpecialEventCharge = "is_special_event_charge"
                case name = "name"
                case nightCharge = "night_charge"
                case nightFrom = "night_from"
                case nightTo = "night_to"
                case perKmCharge = "per_km_charge"
                case perMinuteCharge = "per_minute_charge"
                case premiumCharge = "premium_charge"
                case specialEventCharge = "special_event_charge"
                case specialEventFrom = "special_event_from"
                case specialEventTo = "special_event_to"
                case status = "status"
                case trash = "trash"
                case unselectImage = "unselect_image"
                case updatedAt = "updated_at"
                case waitingTimePerMinCharge = "waiting_time_per_min_charge"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                baseCharge = try values.decodeIfPresent(String.self, forKey: .baseCharge)
                baseKm = try values.decodeIfPresent(String.self, forKey: .baseKm)
                bookingFee = try values.decodeIfPresent(String.self, forKey: .bookingFee)
                capacity = try values.decodeIfPresent(String.self, forKey: .capacity)
                commission = try values.decodeIfPresent(String.self, forKey: .commission)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                customerCancellationFee = try values.decodeIfPresent(String.self, forKey: .customerCancellationFee)
                descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
                driverCancellationFee = try values.decodeIfPresent(String.self, forKey: .driverCancellationFee)
                extraCharge = try values.decodeIfPresent(String.self, forKey: .extraCharge)
                freeCancallationTime = try values.decodeIfPresent(String.self, forKey: .freeCancallationTime)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                image = try values.decodeIfPresent(String.self, forKey: .image)
                isNightCharge = try values.decodeIfPresent(String.self, forKey: .isNightCharge)
                isSpecialEventCharge = try values.decodeIfPresent(String.self, forKey: .isSpecialEventCharge)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                nightCharge = try values.decodeIfPresent(String.self, forKey: .nightCharge)
                nightFrom = try values.decodeIfPresent(String.self, forKey: .nightFrom)
                nightTo = try values.decodeIfPresent(String.self, forKey: .nightTo)
                perKmCharge = try values.decodeIfPresent(String.self, forKey: .perKmCharge)
                perMinuteCharge = try values.decodeIfPresent(String.self, forKey: .perMinuteCharge)
                premiumCharge = try values.decodeIfPresent(String.self, forKey: .premiumCharge)
                specialEventCharge = try values.decodeIfPresent(String.self, forKey: .specialEventCharge)
                specialEventFrom = try values.decodeIfPresent(String.self, forKey: .specialEventFrom)
                specialEventTo = try values.decodeIfPresent(String.self, forKey: .specialEventTo)
                status = try values.decodeIfPresent(String.self, forKey: .status)
                trash = try values.decodeIfPresent(String.self, forKey: .trash)
                unselectImage = try values.decodeIfPresent(String.self, forKey: .unselectImage)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                waitingTimePerMinCharge = try values.decodeIfPresent(String.self, forKey: .waitingTimePerMinCharge)
        }

}
