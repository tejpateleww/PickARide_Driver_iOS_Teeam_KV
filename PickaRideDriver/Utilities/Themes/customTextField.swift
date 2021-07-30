//
//  customTextField.swift
//  CoreSound
//
//  Created by EWW083 on 03/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialTextFields_ColorThemer


class themeTextField : UITextField{
    
    @IBInspectable var Font_Size : CGFloat = 16.0
    @IBInspectable public var isbold: Bool = false
    @IBInspectable public var isMedium: Bool = false
    @IBInspectable public var islight: Bool = false
    @IBInspectable var Font_Color = UIColor.white
    override func awakeFromNib() {
        super.awakeFromNib()
        //            self.font = CustomFont.regular.returnFont(16.0)
        //            self.placeHolderColor = colors.lightGrey.value
        //            self.textColor = colors.lightGrey.value
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftViewMode = .always
        self.layer.borderWidth = 1
        self.layer.borderColor = colors.textfieldbordercolor.value.cgColor
        self.tintColor = themeColor
        if isbold{
            self.font = CustomFont.bold.returnFont(Font_Size)
        }else if isMedium{
            self.font = CustomFont.medium.returnFont(Font_Size)
        }else if islight {
            self.font = CustomFont.light.returnFont(Font_Size)
        }else{
            self.font = CustomFont.regular.returnFont(Font_Size)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

class themeMeterialFloatingTextfield: UIView {
    
    private var textFieldControllerFloating: MDCTextInputControllerOutlined!
    var textField: MDCTextField!

    @IBInspectable var Font_Size : CGFloat = 16.0
    @IBInspectable public var isbold: Bool = false
    @IBInspectable public var isMedium: Bool = false
    @IBInspectable public var islight: Bool = false
    @IBInspectable var isSecure : Bool = false
    @IBInspectable var placeHolder: String!
    @IBInspectable var value: String!
    @IBInspectable var placeholderFont: UIFont!
    @IBInspectable var titleFont: UIFont!
    @IBInspectable var placeholdercolor : Bool = false
    

    override open func draw(_ rect: CGRect) {
        super.draw(rect)

        textField.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)

    }
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        setUpProperty()
        
    }
    func setUpProperty() {
        //Change this properties to change the propperties of text
        textField = MDCTextField(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        textField.placeholder = placeHolder
        textField.text = value
//        self.titleFont = CustomFont.bold.returnFont(14.0)
//        self.placeholderFont = CustomFont.regular.returnFont(16.0)
//        if placeholdercolor == true {
//            textFieldControllerFloating.floatingPlaceholderActiveColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.47)
//        }
        
        if isSecure == true{
            textField.isSecureTextEntry = true
        }else{
            textField.isSecureTextEntry = false
        }
        if isbold{
            self.textField?.font = CustomFont.bold.returnFont(Font_Size)
        }else if isMedium{
            self.textField?.font = CustomFont.medium.returnFont(Font_Size)
        }else if islight {
            self.textField?.font = CustomFont.light.returnFont(Font_Size)
        }else{
            self.textField?.font = CustomFont.regular.returnFont(Font_Size)
        }

        //Change this properties to change the colors of border around text
        textFieldControllerFloating = MDCTextInputControllerOutlined(textInput: textField)

        textFieldControllerFloating.activeColor = themeColor
        textFieldControllerFloating.floatingPlaceholderActiveColor = themeColor
        textFieldControllerFloating.normalColor = themeColor
        textFieldControllerFloating.inlinePlaceholderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.47)

        //Change this font to make borderRect bigger
        textFieldControllerFloating.inlinePlaceholderFont = CustomFont.regular.returnFont(16.0)
        textFieldControllerFloating.textInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))

        self.addSubview(textField)
    }
}

class themeWBorderTextField : UITextField{
    
    @IBInspectable var Font_Size : CGFloat = 16.0
    @IBInspectable public var isbold: Bool = false
    @IBInspectable public var isMedium: Bool = false
    @IBInspectable public var islight: Bool = false
    @IBInspectable var Font_Color = themeColor
    override func awakeFromNib() {
        super.awakeFromNib()
        //            self.font = CustomFont.regular.returnFont(16.0)
        //            self.placeHolderColor = colors.lightGrey.value
        //            self.textColor = colors.lightGrey.value
//        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
//        self.leftViewMode = .always
        self.tintColor = Font_Color
        if isbold{
            self.font = CustomFont.bold.returnFont(Font_Size)
        }else if isMedium{
            self.font = CustomFont.medium.returnFont(Font_Size)
        }else if islight {
            self.font = CustomFont.light.returnFont(Font_Size)
        }else{
            self.font = CustomFont.regular.returnFont(Font_Size)
        }
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
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
        self.font = CustomFont.regular.returnFont(15)
        self.textColor = colors.black.value
        //  self.placeHolderColor = colors.loginPlaceHolderColor.value
//        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
//                                                        attributes: [NSAttributedString.Key.foregroundColor: colors.confirmPasswordPlaceHolder.value])
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
extension UITextField{
    @IBInspectable
        var borderColor: UIColor? {
            get {
                if let color = layer.borderColor {
                    return UIColor(cgColor: color)
                }
                return nil
            }
            set {
                if let color = newValue {
                    layer.borderColor = color.cgColor
                } else {
                    layer.borderColor = nil
                }
            }
        }
}
