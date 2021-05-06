//
//  customTextField.swift
//  CoreSound
//
//  Created by EWW083 on 03/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class customTextField: UITextField {
    
    private let defaultUnderlineColor = UIColor.gray
    private let bottomLine = UIView()

    override func awakeFromNib() {
        super.awakeFromNib()

        borderStyle = .none
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.backgroundColor = defaultUnderlineColor

        self.addSubview(bottomLine)
        bottomLine.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 1).isActive = true
        bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    public func setUnderlineColor(color: UIColor = .red) {
        bottomLine.backgroundColor = color
    }

    public func setDefaultUnderlineColor() {
        bottomLine.backgroundColor = defaultUnderlineColor
    }
    //MARK:- LeftImage Set
    @IBInspectable var leftImage : UIImage? {
        didSet {
            if let image = leftImage{
                leftViewMode = .always
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
                imageView.image = image
                imageView.tintColor = tintColor
                let view = UIView(frame : CGRect(x: 0, y: 0, width: 30, height: 22))
                view.addSubview(imageView)
                leftView = view
            }else {
                leftViewMode = .never
            }

        }
    }
    @IBInspectable var rightImage: UIImage? {
        didSet {
            if let image = rightImage {
                rightViewMode = .always
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
                imageView.image = image
                imageView.tintColor = tintColor
                let view = UIView(frame : CGRect(x: 0, y: 0, width: 30, height: 22))
                view.addSubview(imageView)
                rightView = view
            }else{
                rightViewMode = .never
            }
        }
    }
    //MARK:- valid
    func valid(){
        self.textColor = .white
           //self.isValid = true
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
          // self.isHighlightedField = false
           self.layoutSubviews()
       }
       //MARK:- TextField Invalid
       func invalid(){
           //rightImage = #imageLiteral(resourceName: "invalid_field")
         
           textColor = UIColor.red
         //  self.isValid = false
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: colors.red.value])
          // isHighlightedField = true
           self.layoutSubviews()
           
           DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            self.textColor = .white
              // self.rightImage = nil
               //self.isValid = true
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
           //    self.isHighlightedField = false
               self.layoutSubviews()
           }
       }
}
class emailPasswordTextField : UITextField {
    override func awakeFromNib() {
        self.font = CustomFont.regular.returnFont(15)
        self.textColor = colors.black.value
      //  self.placeHolderColor = colors.loginPlaceHolderColor.value
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: colors.loginPlaceHolderColor.value.withAlphaComponent(0.45)])
    }
}
class verifyPinTextField : UITextField {
    override func awakeFromNib() {
        self.font = CustomFont.bold.returnFont(30)
        self.textColor = colors.loginPlaceHolderColor.value
      //  self.placeHolderColor = colors.loginPlaceHolderColor.value
      
    }
}
class ChangePasswordTextField : UITextField {
    override func awakeFromNib() {
        self.font = CustomFont.medium.returnFont(15)
        self.textColor = colors.black.value
      //  self.placeHolderColor = colors.loginPlaceHolderColor.value
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: colors.confirmPasswordPlaceHolder.value])
    }
}


class leftSideImageTextField: UITextField {
    @IBInspectable var leftImage : UIImage? {
        didSet {
            if let image = leftImage{
                leftViewMode = .always
                let view = UIView(frame : CGRect(x: 0, y: 0, width: 33, height: 24))
                
                let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 14, height: 14))
                imageView.image = image
                imageView.tintColor = tintColor
               
                view.addSubview(imageView)
                leftView = view
            }else {
                leftViewMode = .never
            }

        }
    }
    override func awakeFromNib() {
        self.font = CustomFont.regular.returnFont(17)
        self.textColor = colors.black.value
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: colors.confirmPasswordPlaceHolder.value])
    }
    
}
class chooseLocationTextField : UITextField {
    override func awakeFromNib() {
        self.font = CustomFont.regular.returnFont(18)
        self.textColor = colors.loginPlaceHolderColor.value
      //  self.placeHolderColor = colors.loginPlaceHolderColor.value
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: colors.phoneNumberColor.value])
    }
}
class phonenumberTextField : UITextField {
    override func awakeFromNib() {
        self.font = CustomFont.regular.returnFont(15)
        self.textColor = colors.black.value
        //  self.placeHolderColor = colors.loginPlaceHolderColor.value
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: colors.loginPlaceHolderColor.value.withAlphaComponent(0.45)])
    }
}
class MyOfferTextField : UITextField {
    override func awakeFromNib() {
        self.font = CustomFont.regular.returnFont(15)
        self.textColor = colors.black.value
        //  self.placeHolderColor = colors.loginPlaceHolderColor.value
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: colors.loginPlaceHolderColor.value.withAlphaComponent(0.45)])
       
    }
}

class addCarddetailsTextField : UITextField {
    @IBInspectable var RightSideImage : UIImage? {
        didSet {
            if let image = RightSideImage{
                rightViewMode = .always
                let view = UIView(frame : CGRect(x: 0, y: 0, width: 33, height: 24))
                
                let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 14, height: 14))
                imageView.image = image
                imageView.tintColor = tintColor
                imageView.contentMode = .scaleAspectFit
               
                view.addSubview(imageView)
                rightView = view
            }else {
                rightViewMode = .never
            }

        }
    }
    override func awakeFromNib() {
        
        self.font = CustomFont.regular.returnFont(15)
        self.textColor = colors.loginPlaceHolderColor.value
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: colors.confirmPasswordPlaceHolder.value])
        
        
    }
}
class ProfileTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.font = CustomFont.regular.returnFont(15)
        borderStyle = .none
    }

    @IBInspectable var leftImage : UIImage? {
        didSet {
            if let image = leftImage{
                leftViewMode = .always
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
                imageView.image = image
                imageView.tintColor = tintColor
                let view = UIView(frame : CGRect(x: 0, y: 0, width: 12, height: 16))
                view.addSubview(imageView)
                leftView = view
            }else {
                leftViewMode = .never
            }

        }
    }
    @IBInspectable var rightImage: UIImage? {
        didSet {
            if let image = rightImage {
                rightViewMode = .always
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
                imageView.image = image
                imageView.tintColor = tintColor
                let view = UIView(frame : CGRect(x: 0, y: 0, width: 12, height: 16))
                view.addSubview(imageView)
                rightView = view
            }else{
                rightViewMode = .never
            }
        }
    }
   @IBInspectable var rightOneImage: UIImage? {
       didSet {
           if let image = rightOneImage {
               rightViewMode = .always
               let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 8, height: 14))
               imageView.image = image
               imageView.tintColor = tintColor
            let view = UIView(frame : CGRect(x: 0, y: 0, width: 12, height: 14))
               view.addSubview(imageView)
               rightView = view
           }else{
               rightViewMode = .never
           }
       }
   }
  
    func valid(){
        self.textColor = .white
           //self.isValid = true
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
          // self.isHighlightedField = false
           self.layoutSubviews()
       }
   
       func invalid(){
           //rightImage = #imageLiteral(resourceName: "invalid_field")
         
           textColor = UIColor.red
         //  self.isValid = false
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: colors.red.value])
          // isHighlightedField = true
           self.layoutSubviews()
           
           DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            self.textColor = .white
              // self.rightImage = nil
               //self.isValid = true
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
           //    self.isHighlightedField = false
               self.layoutSubviews()
           }
       }
}

class addNewDestinationTextField : SkyFloatingLabelTextField {
    override func awakeFromNib() {
        self.titleColor = colors.loginPlaceHolderColor.value
                self.lineHeight = 1.0
                self.selectedTitleColor = colors.black.value
                self.selectedLineColor = colors.seperatorColor.value
                self.textColor = colors.phoneNumberColor.value
                self.titleFormatter = { $0 }
        
        self.titleFont = CustomFont.medium.returnFont(18)
        self.font = CustomFont.medium.returnFont(18)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
