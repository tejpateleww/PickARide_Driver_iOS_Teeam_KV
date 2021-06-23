//
//  UILabel+Extension.swift
//  CoreSound
//
//  Created by EWW083 on 04/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//

import Foundation
import UIKit
extension UILabel{
    //MARK:- color font
   func setTitleColorFont(color:colors,font:UIFont){
    self.textColor = color.value
          self.font = font
      }

    func addImageWithText(strText: String, img:UIImage, afterAttributedText: Bool, textfont: UIFont, textColor: UIColor) {

        let attachment = NSTextAttachment()
        attachment.image = img
        let attachmentString = NSAttributedString(attachment: attachment)

        guard let txt = self.text else {
            return
        }
        let range = (txt + strText as NSString).range(of: strText)
//CustomFont.regular.returnFont(15)
//        colors.NotifProfileLinkCol.value
        if afterAttributedText {
            let strLabelText = NSMutableAttributedString(string: txt)
            strLabelText.append(NSMutableAttributedString(string: strText))
            strLabelText.append(attachmentString)
            strLabelText.addAttributes([NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.font: textfont], range: range)
            self.attributedText = strLabelText
        } else {
            let strLabelText = NSMutableAttributedString(string: txt)
            strLabelText.append(attachmentString)
            strLabelText.append(NSMutableAttributedString(string: strText))
            strLabelText.addAttributes([NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.font: textfont], range: range)
            self.attributedText = strLabelText
        }
    }

    func addImageBetweenTwoText(strText1: String, strText2:String, img:UIImage, textfont: UIFont, textColor: UIColor) {

            let attachment = NSTextAttachment()
            attachment.image = img
            let attachmentString = NSAttributedString(attachment: attachment)

            guard let txt = self.text else {
                return
            }
        let range1 = NSString(string: txt + strText1 + strText2).range(of: strText1)
        var range2 = NSString(string: txt + strText1 + strText2).range(of: strText2)
        range2.location = range2.location + 1
//            let range1 = (txt + strText1 as NSString).range(of: strText1)
    //CustomFont.regular.returnFont(15)
    //        colors.NotifProfileLinkCol.value
                let strLabelText = NSMutableAttributedString(string: txt)
                strLabelText.append(NSMutableAttributedString(string: strText1))
                strLabelText.append(attachmentString)
                strLabelText.append(NSMutableAttributedString(string: strText2))
                strLabelText.addAttributes([NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.font: textfont], range: range1)
                strLabelText.addAttributes([NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.font: textfont], range: range2)
                self.attributedText = strLabelText
            
        }
    
    func removeImage() {
        let text = self.text
        self.attributedText = nil
        self.text = text
    }
    
    func addText(strText: String, textfont: UIFont, textColor: UIColor) {

        guard let txt = self.text else {
            return
        }
        
        let range = (txt + strText as NSString).range(of: strText)

        let strLabelText = NSMutableAttributedString(string: txt)
            strLabelText.append(NSMutableAttributedString(string: strText))
            strLabelText.addAttributes([NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.font: textfont], range: range)
        self.attributedText = strLabelText
    }
}
