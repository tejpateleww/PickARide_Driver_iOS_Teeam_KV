//
//  PopUpVC.swift
//  PickaRideDriver
//
//  Created by Harsh on 24/06/21.
//

import UIKit

protocol DatePickDelegate {
    func refreshDocScrren(strExpDate:String)
}

class PopUpVC: UIViewController {

    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var btnOk: themeButton!
    @IBOutlet weak var txtDate: SettingForDatePicker!
    @IBOutlet weak var lblExpiryDate: themeLabel!
    
    var delegateDatePick: DatePickDelegate?
    var strDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PrepareView()
    }
    
    func PrepareView(){
        
        if(self.strDate == ""){
            self.txtDate.text = self.getCurrentShortDate()
        }else{
            self.txtDate.text = strDate
        }
        
        txtDate.textColor = themeColor
        vwContainer.layer.cornerRadius = 8
        txtDate.tintColor = themeColor
    }
    
    func getCurrentShortDate() -> String {
        let todaysDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let DateInFormat = dateFormatter.string(from: todaysDate as Date)
        return DateInFormat
    }
    
    @IBAction func btnOkTap(_ sender: Any) {
        self.delegateDatePick?.refreshDocScrren(strExpDate : self.txtDate.text ?? "")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnCloseTap(_ sender: Any) {
        self.delegateDatePick?.refreshDocScrren(strExpDate : self.txtDate.text ?? "")
        self.dismiss(animated: true, completion: nil)
    }
    
}



class SettingForDatePicker: UITextField {
    var date: Date?
    let datePicker = UIDatePicker()
    let formatter = DateFormatter()
    
    @IBInspectable var istitlleGray : Bool = true
    @IBInspectable var istitleBlack : Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        self.font = CustomFont.regular.returnFont(22)
        self.textColor = .black
        datePicker.minimumDate = Date()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return (action == #selector(UIResponderStandardEditActions.copy(_:))
                    || action == #selector(UIResponderStandardEditActions.paste(_:))) ?
            false : super.canPerformAction(action, withSender: sender)
    }
    
    override func didMoveToSuperview() {
        datePicker.datePickerMode = .date
        formatter.dateStyle = .short
        formatter.dateFormat = "yyyy-MM-dd"
        datePicker.minimumDate = Date()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        }
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        toolbar.setItems([cancel,space,done], animated: false)
        inputAccessoryView = toolbar
        inputView = datePicker
        datePicker.minimumDate = Date()
    }
    @objc func cancelAction(_ sender: UIBarButtonItem) {
        endEditing(true)
    }
    @objc func doneAction(_ sender: UIBarButtonItem) {
        date = datePicker.date
        text = formatter.string(from: datePicker.date)
        endEditing(true)
    }
    

}
