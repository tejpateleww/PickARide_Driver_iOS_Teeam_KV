//
//  UICollectionViewCell+Extension.swift
//  HC Pro Patient
//
//  Created by Shraddha Parmar on 21/09/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

extension UIResponder {

     private static weak var _currentFirstResponder: UIResponder?

     static var currentFirstResponder: UIResponder? {
         _currentFirstResponder = nil
         UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)

         return _currentFirstResponder
     }

     @objc func findFirstResponder(_ sender: Any) {
         UIResponder._currentFirstResponder = self
     }

}

extension Date {
    
    func timeAgoSinceDate(isForNotification : Bool = false) -> String {
        
        let weekdays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]
        
        let calendar = NSCalendar.current
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        
        if calendar.isDateInToday(self) {
            var title = "Today"
            if !isForNotification{
                dateFormatter.dateFormat = "h:mm a"
                title = "Today, " + dateFormatter.string(from: self)
            }
            return title
        }else if calendar.isDateInTomorrow(self) {
            var title = "Tomorrow"
            if !isForNotification{
                dateFormatter.dateFormat = "h:mm a"
                title = "Tomorrow, " + dateFormatter.string(from: self)
            }
            return title
        }else if calendar.isDateInYesterday(self) {
            var title = "Yesterday"
            if !isForNotification{
                dateFormatter.dateFormat = "h:mm a"
                title = "Yesterday, " + dateFormatter.string(from: self)
            }
            return title
            
        }else{
            if isForNotification{
                dateFormatter.dateFormat = "M/d/yyyy"
            }else{
                dateFormatter.dateFormat = "M/d/yyyy, h:mm a"
            }
            return dateFormatter.string(from: self)
        }
    }
}
