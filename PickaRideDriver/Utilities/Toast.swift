//
//  Toast.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 08/06/21.
//

import Foundation
import UIKit

//MARK:- Toast Alert Images
let AlertCheckImg = #imageLiteral(resourceName: "imgAlertCheck")
let AlertCancelImg = #imageLiteral(resourceName: "imgAlertCancel")
let AlertInfoImg = #imageLiteral(resourceName: "imgAlertInfo")

enum MessageAlertState {
    case success , failure , info , theme
}

class Toast {
    
    static func show(title: String = "" ,delay :Double = 1.5,  message: String, state : MessageAlertState ,  completion: (() -> Void)? = nil) {
        guard let window = UIApplication.shared.keyWindow else { return}
        
        let toastContainer = UIView(frame: CGRect())
        toastContainer.tag = viewComponentsTags.ToastView.rawValue
        if (window.viewWithTag(viewComponentsTags.ToastView.rawValue) != nil ){
            return
        }
        
        let toastLabel = UILabel(frame: CGRect())
        let statusImage = UIImageView(frame: CGRect())
        switch state {
        case .success:
            toastContainer.backgroundColor = ThemeColorEnum.ThemeGreen.rawValue//UIColor(red: 97.0/255.0, green: 161.0/255.0, blue: 23.0/255.0, alpha: 1.0)// UIColor.green//.withAlphaComponent(0.9)
            statusImage.image = AlertCheckImg
        case .failure:
            toastContainer.backgroundColor = ThemeColorEnum.ThemeRed.rawValue//UIColor(red: 249.0/255.0, green: 66.0/255.0, blue: 47.0/255.0, alpha: 1.0)// UIColor.red//.withAlphaComponent(0.9)
            statusImage.image = AlertCancelImg
        case .info:
            toastContainer.backgroundColor = ThemeColorEnum.Info.rawValue//UIColor.appColor(.themeSolidGray)//.withAlphaComponent(0.9) //UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0)
            statusImage.image = AlertInfoImg
            
        case .theme:
            toastContainer.backgroundColor = ThemeColorEnum.Theme.rawValue//UIColor.appColor(.themeGold)//.withAlphaComponent(0.9)
            statusImage.image = AlertInfoImg
        }
        
        statusImage.layer.cornerRadius = 15
        statusImage.clipsToBounds = true
        
        
        toastContainer.alpha = 1.0
        toastContainer.layer.cornerRadius = 15
        toastContainer.clipsToBounds = true
        
        toastLabel.textAlignment = .left;
        
        if title != "" {
            toastLabel.addInterlineSpacing(title: "\(title)\n", message: message, spacingValue: 1.5)
        }else{
            let messagetoPrint = NSMutableAttributedString()
                .normal(message, fontSize: 15.0 , fontColor: .white)
            
            toastLabel.attributedText = messagetoPrint
        }
        
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        
        
        toastContainer.addSubview(statusImage)
        toastContainer.addSubview(toastLabel)
        
        
        statusImage.translatesAutoresizingMaskIntoConstraints = false
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let i1 = NSLayoutConstraint(item: statusImage, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 15)
        statusImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        statusImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let i4 = NSLayoutConstraint(item: statusImage, attribute: .centerY, relatedBy: .equal, toItem: toastContainer, attribute: .centerY, multiplier: 1, constant: 0)
        toastContainer.addConstraints([i1, i4])
        
        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: statusImage, attribute: .trailing, multiplier: 1, constant: 15)
        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -15)
        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
        toastContainer.addConstraints([a1, a2, a3, a4])
        
        window.addSubview(toastContainer)
        
        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal, toItem: window, attribute: .leading, multiplier: 1, constant: 20)
        let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal, toItem: window, attribute: .trailing, multiplier: 1, constant: -20)
        let c3 = NSLayoutConstraint(item: toastContainer, attribute: .top, relatedBy: .equal, toItem: window, attribute: .top, multiplier: 1, constant: 0)
        window.addConstraints([c1,c2,c3])
        
        DispatchQueue.main.async {
            c3.constant = 50
            
            
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.beginFromCurrentState, .curveLinear, .allowUserInteraction], animations: {
                window.layoutIfNeeded()
                
            }, completion: { completed in
                c3.constant = 0
                UIView.animate(withDuration: 0.1, delay: delay, options: .curveLinear, animations: {
                    window.layoutIfNeeded()
                }) { _ in
                    toastContainer.removeFromSuperview()
                    if let comp = completion{
                        comp()
                    }
                    
                }
            })
        }
    }
}




private extension UILabel {

    // MARK: - spacingValue is spacing that you need
    func addInterlineSpacing(title: String, message: String,spacingValue: CGFloat) {

        // MARK: - Check if there's any text

        // MARK: - Create "NSMutableAttributedString" with your text
        let attributedString = NSMutableAttributedString()
            .bold(title , fontSize: 15.0 , fontColor: .white)
            .normal(message, fontSize: 14.0 , fontColor: .white)

        // MARK: - Create instance of "NSMutableParagraphStyle"
        let paragraphStyle = NSMutableParagraphStyle()

        // MARK: - Actually adding spacing we need to ParagraphStyle
        paragraphStyle.lineSpacing = spacingValue

        // MARK: - Adding ParagraphStyle to your attributed String
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
        ))

        // MARK: - Assign string that you've modified to current attributed Text
        attributedText = attributedString
    }

}



extension NSMutableAttributedString {
 var fontSize:CGFloat { return 18 }
//    var boldFont:UIFont { return UIFont(name: FontBook.semibold.rawValue, size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont:UIFont { return UIFont(name: FontBook.regular.rawValue, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}
    
    func bold(_ value:String , fontSize : CGFloat,  fontColor : UIColor = .white) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : FontBook.semibold.of(size: fontSize),
            .foregroundColor : fontColor
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value:String, fontSize : CGFloat , fontColor : UIColor = .white) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : FontBook.regular.of(size: fontSize),//normalFont,
            .foregroundColor : fontColor
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    // Other styling methods /
    func orangeHighlight(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.orange
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func blackHighlight(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.black
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func underlined(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
