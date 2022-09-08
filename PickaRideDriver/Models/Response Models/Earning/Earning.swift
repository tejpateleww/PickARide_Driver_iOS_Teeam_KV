//
//  Earning.swift
//  PickaRideDriver
//
//  Created by Gaurang on 05/09/22.
//

import Foundation

// MARK: - EarningInfo
struct EarningInfo: Codable {
    let totalEarning, totalRide, cardTotal, remainingBalance: String?
    let totalHours: String?
    let graphData: [EarningGraphData]

    enum CodingKeys: String, CodingKey {
        case totalEarning = "total_earning"
        case totalRide = "total_ride"
        case cardTotal = "card_total"
        case remainingBalance = "remaining_balance"
        case totalHours = "total_hours"
        case graphData = "graph_data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalEarning = try? values.decode(String.self, forKey: .totalEarning)
        totalRide = try? values.decode(String.self, forKey: .totalRide)
        cardTotal = try? values.decode(String.self, forKey: .cardTotal)
        remainingBalance = try? values.decode(String.self, forKey: .remainingBalance)
        totalHours = try? values.decode(String.self, forKey: .totalHours)
        graphData = (try? values.decode([EarningGraphData].self, forKey: .graphData)) ?? []
    }
}

// MARK: - GraphDatum
struct EarningGraphData: Codable {
    let day: WeekDay
    let earning: Double
    
    enum CodingKeys: String, CodingKey {
        case day = "days"
        case earning
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        day = try values.decode(WeekDay.self, forKey: .day)
        if let earningString = try? values.decode(String.self, forKey: .earning) {
            earning = Double(earningString) ?? 0
        } else {
            earning = try values.decode(Double.self, forKey: .earning)
        }
    }
}
    
enum WeekDay: String, Codable {
    case monday     = "Monday"
    case tuesday    = "Tuesday"
    case wednesday  = "Wednesday"
    case thursday   = "Thursday"
    case friday     = "Friday"
    case saturday   = "Saturday"
    case sunday     = "Sunday"
    
    var shortName: String {
        return String(rawValue.prefix(1))
    }
}

/*{
    "status": true,
    "message": "Earning get successfully.",
    "data": {
        "total_earning": "61.66",
        "total_ride": "5",
        "card_total": "0",
        "remaining_balance": "368.81",
        "total_hours": "41:33",
        "graph_data": [
            {
                "days": "Tuesday",
                "earning": "9.97"
            },
            {
                "days": "Wednesday",
                "earning": "37.08"
            },
            {
                "days": "Thursday",
                "earning": "7.27"
            },
            {
                "days": "Saturday",
                "earning": "7.34"
            }
        ]
    }
}
*/
