//
//  PastBookingResBookingInfo.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 16, 2021

import Foundation

class PastBookingResBookingInfo : Codable {

        let acceptTime : String?
        let arrivedTime : String?
        let baseFare : String?
        let bookingFee : String?
        let bookingTime : String?
        let bookingType : String?
        let cancelBy : String?
        let cancelReason : String?
        let cancellationCharge : String?
        let cardId : String?
        let companyAmount : String?
        let customerFirstName : String?
        let customerId : String?
        let customerLastName : String?
        let discount : String?
        let distance : String?
        let distanceFare : String?
        let driverAmount : String?
        let driverId : String?
        let dropoffLat : String?
        let dropoffLng : String?
        let dropoffLocation : String?
        let dropoffTime : String?
        let durationFare : String?
        let estimatedFare : String?
        let extraCharge : String?
        let grandTotal : String?
        let id : String?
        let noOfPassenger : String?
        let onTheWay : String?
        let paymentResponse : String?
        let paymentStatus : String?
        let paymentType : String?
        let pickupDateTime : String?
        let pickupLat : String?
        let pickupLng : String?
        let pickupLocation : String?
        let pickupTime : String?
        let promocode : String?
        let referenceId : String?
        let status : String?
        let subTotal : String?
        let tax : String?
        let tips : String?
        let tipsStatus : String?
        let tripDuration : String?
        let vehicleName : String?
        let vehicleTypeId : String?
        let waitingTime : String?
        let waitingTimeCharge : String?

        enum CodingKeys: String, CodingKey {
                case acceptTime = "accept_time"
                case arrivedTime = "arrived_time"
                case baseFare = "base_fare"
                case bookingFee = "booking_fee"
                case bookingTime = "booking_time"
                case bookingType = "booking_type"
                case cancelBy = "cancel_by"
                case cancelReason = "cancel_reason"
                case cancellationCharge = "cancellation_charge"
                case cardId = "card_id"
                case companyAmount = "company_amount"
                case customerFirstName = "customer_first_name"
                case customerId = "customer_id"
                case customerLastName = "customer_last_name"
                case discount = "discount"
                case distance = "distance"
                case distanceFare = "distance_fare"
                case driverAmount = "driver_amount"
                case driverId = "driver_id"
                case dropoffLat = "dropoff_lat"
                case dropoffLng = "dropoff_lng"
                case dropoffLocation = "dropoff_location"
                case dropoffTime = "dropoff_time"
                case durationFare = "duration_fare"
                case estimatedFare = "estimated_fare"
                case extraCharge = "extra_charge"
                case grandTotal = "grand_total"
                case id = "id"
                case noOfPassenger = "no_of_passenger"
                case onTheWay = "on_the_way"
                case paymentResponse = "payment_response"
                case paymentStatus = "payment_status"
                case paymentType = "payment_type"
                case pickupDateTime = "pickup_date_time"
                case pickupLat = "pickup_lat"
                case pickupLng = "pickup_lng"
                case pickupLocation = "pickup_location"
                case pickupTime = "pickup_time"
                case promocode = "promocode"
                case referenceId = "reference_id"
                case status = "status"
                case subTotal = "sub_total"
                case tax = "tax"
                case tips = "tips"
                case tipsStatus = "tips_status"
                case tripDuration = "trip_duration"
                case vehicleName = "vehicle_name"
                case vehicleTypeId = "vehicle_type_id"
                case waitingTime = "waiting_time"
                case waitingTimeCharge = "waiting_time_charge"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                acceptTime = try values.decodeIfPresent(String.self, forKey: .acceptTime)
                arrivedTime = try values.decodeIfPresent(String.self, forKey: .arrivedTime)
                baseFare = try values.decodeIfPresent(String.self, forKey: .baseFare)
                bookingFee = try values.decodeIfPresent(String.self, forKey: .bookingFee)
                bookingTime = try values.decodeIfPresent(String.self, forKey: .bookingTime)
                bookingType = try values.decodeIfPresent(String.self, forKey: .bookingType)
                cancelBy = try values.decodeIfPresent(String.self, forKey: .cancelBy)
                cancelReason = try values.decodeIfPresent(String.self, forKey: .cancelReason)
                cancellationCharge = try values.decodeIfPresent(String.self, forKey: .cancellationCharge)
                cardId = try values.decodeIfPresent(String.self, forKey: .cardId)
                companyAmount = try values.decodeIfPresent(String.self, forKey: .companyAmount)
                customerFirstName = try values.decodeIfPresent(String.self, forKey: .customerFirstName)
                customerId = try values.decodeIfPresent(String.self, forKey: .customerId)
                customerLastName = try values.decodeIfPresent(String.self, forKey: .customerLastName)
                discount = try values.decodeIfPresent(String.self, forKey: .discount)
                distance = try values.decodeIfPresent(String.self, forKey: .distance)
                distanceFare = try values.decodeIfPresent(String.self, forKey: .distanceFare)
                driverAmount = try values.decodeIfPresent(String.self, forKey: .driverAmount)
                driverId = try values.decodeIfPresent(String.self, forKey: .driverId)
                dropoffLat = try values.decodeIfPresent(String.self, forKey: .dropoffLat)
                dropoffLng = try values.decodeIfPresent(String.self, forKey: .dropoffLng)
                dropoffLocation = try values.decodeIfPresent(String.self, forKey: .dropoffLocation)
                dropoffTime = try values.decodeIfPresent(String.self, forKey: .dropoffTime)
                durationFare = try values.decodeIfPresent(String.self, forKey: .durationFare)
                estimatedFare = try values.decodeIfPresent(String.self, forKey: .estimatedFare)
                extraCharge = try values.decodeIfPresent(String.self, forKey: .extraCharge)
                grandTotal = try values.decodeIfPresent(String.self, forKey: .grandTotal)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                noOfPassenger = try values.decodeIfPresent(String.self, forKey: .noOfPassenger)
                onTheWay = try values.decodeIfPresent(String.self, forKey: .onTheWay)
                paymentResponse = try values.decodeIfPresent(String.self, forKey: .paymentResponse)
                paymentStatus = try values.decodeIfPresent(String.self, forKey: .paymentStatus)
                paymentType = try values.decodeIfPresent(String.self, forKey: .paymentType)
                pickupDateTime = try values.decodeIfPresent(String.self, forKey: .pickupDateTime)
                pickupLat = try values.decodeIfPresent(String.self, forKey: .pickupLat)
                pickupLng = try values.decodeIfPresent(String.self, forKey: .pickupLng)
                pickupLocation = try values.decodeIfPresent(String.self, forKey: .pickupLocation)
                pickupTime = try values.decodeIfPresent(String.self, forKey: .pickupTime)
                promocode = try values.decodeIfPresent(String.self, forKey: .promocode)
                referenceId = try values.decodeIfPresent(String.self, forKey: .referenceId)
                status = try values.decodeIfPresent(String.self, forKey: .status)
                subTotal = try values.decodeIfPresent(String.self, forKey: .subTotal)
                tax = try values.decodeIfPresent(String.self, forKey: .tax)
                tips = try values.decodeIfPresent(String.self, forKey: .tips)
                tipsStatus = try values.decodeIfPresent(String.self, forKey: .tipsStatus)
                tripDuration = try values.decodeIfPresent(String.self, forKey: .tripDuration)
                vehicleName = try values.decodeIfPresent(String.self, forKey: .vehicleName)
                vehicleTypeId = try values.decodeIfPresent(String.self, forKey: .vehicleTypeId)
                waitingTime = try values.decodeIfPresent(String.self, forKey: .waitingTime)
                waitingTimeCharge = try values.decodeIfPresent(String.self, forKey: .waitingTimeCharge)
        }

}
