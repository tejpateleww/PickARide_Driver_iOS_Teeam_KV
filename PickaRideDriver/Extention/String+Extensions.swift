//
//  String+Extensions.swift
//  CoreSound
//
//  Created by EWW083 on 04/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//

import Foundation
import UIKit
extension String{
    
    var trimmedString: String { return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
    
    var length: Int { return self.trimmedString.count}
    
    //MARK: - ================================
    //MARK: URL Encoding
    //MARK: ==================================
    func urlencoding() -> String {
        var output: String = ""
        
        for thisChar in self {
            if thisChar == " " {
                output += "+"
            }
            else if thisChar == "." ||
                thisChar == "-" ||
                thisChar == "_" ||
                thisChar == "~" ||
                (thisChar >= "a" && thisChar <= "z") ||
                (thisChar >= "A" && thisChar <= "Z") ||
                (thisChar >= "0" && thisChar <= "9") {
                let code = String(thisChar).utf8.map{ UInt8($0) }[0]
                output += String(format: "%c", code)
            }
            else {
                let code = String(thisChar).utf8.map{ UInt8($0) }[0]
                output += String(format: "%%%02X", code)
            }
        }
        return output;
    }
    
    //MARK: - ================================
    //MARK: Contains Alphabets
    //MARK: ==================================
    func containsAlphabets() -> Bool {
        var iscontain : Bool = false
        let characterSet = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyz")
        if self.count > 1 {
            for character in self.lowercased() {
                let string = String.init(character)
                if string.rangeOfCharacter(from: characterSet) != nil {
                    iscontain = true
                    break
                }
            }
        }
        else {
            if self.rangeOfCharacter(from: characterSet) != nil {
                iscontain = true
            }
            else {
                iscontain = false
            }
        }
        return iscontain
    }
    
    //MARK: - ================================
    //MARK: Contains Numbers
    //MARK: ==================================
    func containsNumbers() -> Bool {
        var iscontain : Bool = false
        let characterSet = CharacterSet(charactersIn:"0123456789")
        if self.count > 1 {
            for character in self {
                let string = String.init(character)
                if string.rangeOfCharacter(from: characterSet) != nil {
                    iscontain = true
                    break
                }
            }
        }
        else {
            if self.rangeOfCharacter(from: characterSet) != nil {
                iscontain = true
            }
            else {
                iscontain = false
            }
        }
        return iscontain
    }
    
    //MARK: - ================================
    //MARK: Convert String to Dictionary
    //MARK: ==================================
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                Utilities.printOutput(error.localizedDescription)
            }
        }
        return nil
    }
    
    //MARK: - ================================
    //MARK: Check if string is Image
    //MARK: ==================================
    public func isImageFromString() -> Bool {
        // Add here your image formats.
        let imageFormats = ["jpg",
                            "png",
                            "gif",
                            "webp",
                            "svg",
                            "ai",
                            "eps",
                            "bmp",
                            "psd",
                            "thm",
                            "pspimage",
                            "tif",
                            "yuv",
                            "drw",
                            "Eps",
                            "ps",
                            "pcd"]
        
        if let ext = self.getExtension() {
            return imageFormats.contains(ext)
        }
        return false
    }
    
    public func getExtension() -> String? {
        let ext = (self as NSString).pathExtension
        if ext.isEmpty {
            return nil
        }
        return ext
    }
    
    //MARK: - ================================
    //MARK: Replace a Pertucular character
    //MARK: ==================================
    public func replaceCharacter(oldCharacter:String, newCharacter:String)->String{
        return self.replacingOccurrences(of: oldCharacter, with: newCharacter, options: .literal, range: nil)
    }
    
    //MARK: - ================================
    //MARK: Convert to HTML Text
    //MARK: ==================================
    func convertHtml() -> NSAttributedString {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do{
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:  NSAttributedString.DocumentType.html], documentAttributes: nil)
        }catch{
            return NSAttributedString()
        }
    }
    
    //MARK: - ================================
    //MARK: Get Currency Symbol
    //MARK: ==================================
    func getSymbolForCurrencyCode() -> String? {
        var cod = self
        if cod == ""{
            if Locale.current.currencyCode != nil{
                cod = Locale.current.currencyCode!
            } else{
                cod = "USD"
            }
        }
        let upperCode = cod.uppercased()
        let symbol = Locale.availableIdentifiers.map { Locale(identifier: $0) }.first { $0.currencyCode == upperCode }
        let sym = "\((symbol?.currencySymbol?.last)!)"
        return sym
    }
    
    //MARK: - ================================
    //MARK: Strike Through Words
    //MARK: ==================================
    func strikeThrough(color: UIColor)->NSAttributedString{
            let textRange = NSMakeRange(0, self.count)
            let attributedText = NSMutableAttributedString(string: self)
            attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                        value: NSUnderlineStyle.single.rawValue,
                                        range: textRange)
            attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle, value: color, range: textRange)
            return attributedText
        }
    
    func strikeThrough(color: UIColor, forString:String)->NSAttributedString{
        let textRange = (self as NSString).range(of: forString)
        let attributedText = NSMutableAttributedString(string: self)
        attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: textRange)
        attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle, value: color, range: textRange)
        return attributedText
    }
    
    
    //MARK: - ================================
    //MARK: Remove HTML Tags from string
    //MARK: ==================================
    func removeHTMLTags()->String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
    
    //MARK: - ================================
    //MARK: Convert to Double
    //MARK: ==================================
    func toDouble() -> Double {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return 0.0
        }
    }
    //MARK: - ================================
    //MARK: Convert to Intger
    //MARK: ==================================
    func toInt() -> Int {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return 0
        }
    }
    
    //MARK: - ================================
    //MARK: For Coupon codes with spacing
    //MARK: ==================================
    func getAttributedStringWithKern() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: 4, range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
    
    //MARK: - ================================
    //MARK: For localized string
    //MARK: ==================================
    func Localized() -> String {
        guard let lang = user_defaults.value(forKey: UserDefaultsKey.selLanguage.rawValue) as? String else { return "" }
        let path = Bundle.main.path(forResource: lang , ofType: "lproj")
        let bundle = Bundle(path: path!)!
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    
    //MARK: - ================================
    //MARK: For Validation string
    //MARK: ==================================
    
    func isValidEmailAddress() -> Bool
    {
        var returnValue = true
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let results = regex.matches(in: self, range: NSRange(location: 0, length: self.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return returnValue
    }
    func capitalizingFirstLetter() -> String {
    return prefix(1).localizedUppercase + lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
    self = self.capitalizingFirstLetter()
    }
    
    func masked(_ n: Int = 5, reversed: Bool = false) -> String {
        let mask = String(repeating: "•", count: Swift.max(0, count-n))
        return reversed ? mask + suffix(n) : prefix(n) + mask
    }
    
    func toCurrencyString() -> String {
        return Double(self)?.toCurrencyString() ?? ""
    }
    
}


extension Double {
    func toCurrencyString() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = SingletonClass.sharedInstance.currencySymbol
        //currencyFormatter.locale = Locale(identifier: "en_ZA")
        let priceString = currencyFormatter.string(from: NSNumber(value: self))!
        return priceString
    }

    func timeStampToDate() -> Date? {
        return Date(timeIntervalSince1970: self)
    }
}
