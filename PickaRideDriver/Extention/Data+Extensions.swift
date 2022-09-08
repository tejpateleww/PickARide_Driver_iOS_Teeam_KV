//
//  Data+Extensions.swift
//  CoreSound
//
//  Created by EWW083 on 04/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//

import Foundation
import UIKit

enum DateFormatInputType: String {
    case fullDate = "yyyy-MM-dd HH:mm:ss"
    case dateWithOutSeconds = "yyyy-MM-dd HH:mm"
    case yyyyMMdd = "yyyy-MM-dd"
    case ddMMyyyy = "dd-MM-yyyy"
    case onlyDateType_3 = "MM-dd-yyyy"
    
    func getDate(from string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = rawValue
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: string)
    }
}

enum DateFormatOutputType: String {
    case fullDate = "d MMM, yyyy h:mm a"
    case standardFullDate = "yyyy-MM-dd HH:mm:ss"
    case onlyDate = "d MMM, yyyy"
    //    case onlyMonthType1 = "d MMM yy"
    case onlyDateType_2 = "yyyy-MM-dd"
    case onlyDateType_3 = "MM/dd/yyyy"
    case onlyTime = "h:mm a"
    case onlyTime24Hours = "HH:mm"
    case dayWithMonth = "EEEE, MMM dd"
    case standardOnlyDate = "d-M-yyyy"
    case onlyNameOfDay = "EEEE"
    case MonthNameWithYear = "MMM YYYY"
    case MonthDateYear = "MMM d" //"MMM d, yyyy"
    
    func getString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = rawValue
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: date)
    }
}

extension Data {
    mutating func appendString(string: String) {
        let data = string.data(using: .utf8, allowLossyConversion: true)
        append(data!)
    }
    
    func toString() -> String
    {
        return String(data: self, encoding: .utf8)!
    }
}

extension Date {
    //MARK: Week related timings
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 0, to: sunday)
    }
    var formattedStartWeekString: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let startWeekDate = Date().startOfWeek else { return "" }
        return dateFormatter.string(from: startWeekDate)
    }
    var formattedEndWeekString: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let endWeekDate = Date().endOfWeek else { return "" }
        return dateFormatter.string(from: endWeekDate)
    }
    var dateConvertString: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM. YYYY"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let endWeekDate = Date().endOfWeek else { return "" }
        return dateFormatter.string(from: endWeekDate)
    }
    var dateConvertStringType1: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let endWeekDate = Date().endOfWeek else { return "" }
        return dateFormatter.string(from: endWeekDate)
    }
    var formattedDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    var formattedDateStartWithDay: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    var formattedDateStyle2: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    var Date_In_DD_MM_YYYY_FORMAT: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    var chatRequiredTimeZone: String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatOutputType.standardFullDate.rawValue
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
         return dateFormatter.string(from: self)
    }
    var fullDateDayFormate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM; yy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self).replacingOccurrences(of: ";", with: "'")
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 6, to: sunday)
    }
    
    
    var dayBefore: Date? {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)
    }
    var dayAfter: Date? {
        return Calendar.current.date(byAdding: .day, value: +1, to: self)
    }
    var lastWeekDate: Date? {
        return previousWeek()
    }
    func previousWeek() -> Date {
        return addingTimeInterval(-7*24*60*60)
    }
    
    func nextWeek() -> Date {
        return addingTimeInterval(7*24*60*60)
    }
    
    var dateValue: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    var hourValue: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    var monthValue: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    var dayValue: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    ///Like monday tuesday, wednesday..
    var dayOfWeekFullString: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    var fullMonthDay: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    var timeIn12Hours: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    
}
