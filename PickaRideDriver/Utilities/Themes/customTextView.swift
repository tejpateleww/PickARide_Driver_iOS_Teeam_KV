//
//  customTextView.swift
//  PickARide User
//
//  Created by Apple on 15/12/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import Foundation
import AVKit
import IQKeyboardManagerSwift
class signUPPageTextView : UITextView {
    override func awakeFromNib() {
        let text = NSMutableAttributedString(string: "SignUpPage_textViewText1".Localized())
        text.addAttribute(NSAttributedString.Key.font, value: CustomFont.regular.returnFont(13), range: NSMakeRange(0, text.length))
        
        let selectablePart = NSMutableAttributedString(string: "SignUpPage_textViewText2".Localized())
        selectablePart.addAttribute(NSAttributedString.Key.font, value: CustomFont.regular.returnFont(13), range: NSMakeRange(0, selectablePart.length))
        // Add an underline to indicate this portion of text is selectable (optional)
        selectablePart.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0,selectablePart.length))
        selectablePart.addAttribute(NSAttributedString.Key.underlineColor, value: colors.loginPlaceHolderColor.value, range: NSMakeRange(0, selectablePart.length))
        // Add an NSLinkAttributeName with a value of an url or anything else
        selectablePart.addAttribute(NSAttributedString.Key.link, value: "termsandconditions", range: NSMakeRange(0,selectablePart.length))
        
        // Combine the non-selectable string with the selectable string
        text.append(selectablePart)
        
        let newText = NSMutableAttributedString(string: "SignUpPage_textViewText3".Localized())
        newText.addAttribute(NSAttributedString.Key.font, value: CustomFont.regular.returnFont(13), range: NSMakeRange(0, newText.length))
        text.append(newText)
        
        let selectablePart2 = NSMutableAttributedString(string: "SignUpPage_textViewText4".Localized())
        selectablePart2.addAttribute(NSAttributedString.Key.font, value: CustomFont.regular.returnFont(13), range: NSMakeRange(0, selectablePart2.length))
        // Add an underline to indicate this portion of text is selectable (optional)
        selectablePart2.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0,selectablePart2.length))
        selectablePart2.addAttribute(NSAttributedString.Key.underlineColor, value: colors.loginPlaceHolderColor.value, range: NSMakeRange(0, selectablePart2.length))
        // Add an NSLinkAttributeName with a value of an url or anything else
        selectablePart2.addAttribute(NSAttributedString.Key.link, value: "privacypolicy", range: NSMakeRange(0,selectablePart2.length))
//
//        // Combine the non-selectable string with the selectable string
        text.append(selectablePart2)
        
        // Center the text (optional)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        text.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text.length))
        
        // To set the link text color (optional)
        self.linkTextAttributes = [NSAttributedString.Key.foregroundColor:colors.loginPlaceHolderColor.value, NSAttributedString.Key.font: CustomFont.regular.returnFont(13)]
        // Set the text view to contain the attributed text
        self.attributedText = text
        // Disable editing, but enable selectable so that the link can be selected
        self.isEditable = false
        self.isSelectable = true
        // Set the delegate in order to use textView(_:shouldInteractWithURL:inRange)
    }
}
class ratingTextview : IQTextView{
    override func awakeFromNib() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.init(hexString: "#E4E9F2").cgColor
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.textContainerInset = UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
    }
}
