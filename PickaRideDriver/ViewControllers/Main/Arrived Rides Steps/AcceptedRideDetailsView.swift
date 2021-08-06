//
//  AcceptedRideDetailsView.swift
//  PickaRideDriver
//
//  Created by Mehul Panchal on 19/05/21.
//

import UIKit

protocol AcceptedRideDetailsViewDelgate {
    func onArrivedUserLocation()
    func onCancelAcceptedRideRequest()
    func onChatRideRequest()
    func onCallRideRequest()
}

class AcceptedRideDetailsView: UIView {
    
    var delegate : AcceptedRideDetailsViewDelgate?
    
    @IBOutlet weak var stackContackview: UIStackView!
    @IBOutlet weak var btnDownArrow: UIButton!
    @IBOutlet weak var btnSubmit: CommonButton!
    @IBOutlet weak var btnCancel: CancelButton!
    @IBOutlet weak var ViewTripCode: UIView!
    @IBOutlet weak var lblTime: CommonLabel!
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var btnSos: UIButton!
    @IBOutlet weak var lblExtraTime: CommonLabel!
    @IBOutlet weak var btnNavigate: UIButton!
    @IBOutlet weak var vwLine: UIView!
    @IBOutlet weak var lblMessage: CommonLabel!
    @IBOutlet weak var viewDropLocation: UIView!
    @IBOutlet weak var lbDropLocation: UILabel!
    @IBOutlet weak var lblEnterTripCode: CommonLabel!
    @IBOutlet weak var viewContactOptions: UIView!
    @IBOutlet weak var txtfieldTripCode: UITextField!
    @IBOutlet weak var topVW: UIView!
    @IBOutlet weak var mainVW: UIView!
    @IBOutlet weak var mainVWBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var timewVW: UIView!
    
    var isArrived : Bool = false
    var isComplete : Bool = false
    var isCompleteClicked : Bool = false
    var TextfieldCountIsFour = false
    var isNoTapFromCancelRide = false
    
    var isExpandCategory:  Bool  = false {
        didSet {
            mainVWBottomConstraint.constant = isExpandCategory ? 0 : (-mainVW.frame.height + topVW.frame.height + timewVW.frame.height + 35)
            btnDownArrow.isHidden = !isExpandCategory
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState], animations: {
                self.layoutIfNeeded()
            }) { (success) in
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
         setupView()
        self.setupViewCategory()
//        txtfieldTripCode.addTarget(self, action: #selector(textFieldEdidtingDidChange(_ :)), for: UIControl.Event.editingChanged)
    }
    
    func setupViewCategory() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.topVW.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.topVW.addGestureRecognizer(swipeDown)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            self.endEditing(true)
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
//                ViewTripCode.isHidden = true
                self.isExpandCategory = false
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
                self.isExpandCategory = true

            default:
                break
            }
        }
    }
    
    @objc func setBottomViewOnclickofViewTop(){
        self.isExpandCategory = !self.isExpandCategory
    }
    
    override func layoutSubviews() {
        viewDropLocation.cornerRadius = viewDropLocation.frame.size.height / 2
    }
    
    func setRideDetails(/*Pass model class here*/) {
        lblTime.text = "2 min"
        lblExtraTime.text = "0.5 min"
        lblMessage.text = "Picking up James smith"
        lbDropLocation.text = "1 Ash Park, Pembroke Dock, SA7254, Drury Lane, Oldham, OL9 7PH"
    }
    
    @IBAction func btnNavigateTap(_ sender: Any) {
        
    }
    @IBAction func btnSubmitButtonClickAction(_ sender: Any) {
        self.btnCancel.isHidden = !isComplete
        if  isCompleteClicked{
            isComplete = false
            isCompleteClicked = false
            delegate?.onArrivedUserLocation()
            btnSubmit.setTitle("ARRIVED", for: .normal)
            btnDownArrow.isHidden = false
            viewContactOptions.isHidden = false
            btnNavigate.isHidden = false
//            btnDownArrow.isHidden = false
        }else if isComplete{
            btnSubmit.setTitle("COMPLETE", for: .normal)
            isComplete = false
            btnDownArrow.isHidden = true
            isCompleteClicked = true
            ViewTripCode.isHidden = true
            viewContactOptions.isHidden = true
            btnNavigate.isHidden = false
//            btnDownArrow.isHidden = true
//            delegate?.onArrivedUserLocation()
        }else if isArrived{
            
//            ViewTripCode.isHidden = true
//            btnSubmit.setTitle("START RIDE", for: .normal)
//            btnNavigate.isHidden = false
//            lblMessage.text = "Arrived Rockden"
//            isArrived = false
//            isComplete = true
        }else{
            ViewTripCode.isHidden = false
            btnSubmit.setTitle("START RIDE", for: .normal)
            btnNavigate.isHidden = false
            lblMessage.text = "Arrived Rockden"
            isArrived = false
            isComplete = true
            
//            ViewTripCode.isHidden = false
//            btnSubmit.setTitle(ConstantString.BUTTON_TITLE_OK, for: .normal)
//            if btnSubmit.title(for: .normal) == ConstantString.BUTTON_TITLE_OK{
//                isArrived = true
//            }
        }
        
    }
    
    func completeTap(){
        self.btnCancel.isHidden = !isComplete
        isComplete = false
        isCompleteClicked = false
//        delegate?.onArrivedUserLocation()
        btnSubmit.setTitle("ARRIVED", for: .normal)
        btnDownArrow.isHidden = false
        viewContactOptions.isHidden = false
        btnNavigate.isHidden = false
    }
    
    func isCompleted(){
//        if isNoTapFromCancelRide{
            self.btnCancel.isHidden = false
//        }
//        self.btnCancel.isHidden = !isComplete
        btnSubmit.setTitle("COMPLETE", for: .normal)
        isComplete = false
        btnDownArrow.isHidden = true
        isCompleteClicked = true
        ViewTripCode.isHidden = true
        viewContactOptions.isHidden = true
        btnNavigate.isHidden = false
    }
    @IBAction func btnSosTap(_ sender: Any) {
    }
    
    @IBAction func btnCallClickAction(_ sender: Any) {
        delegate?.onCallRideRequest()
    }
    
    @IBAction func btnMessageClickAction(_ sender: Any) {
        delegate?.onChatRideRequest()
        
    }
    
    @IBAction func btnCancelClickAction(_ sender: Any) {
        
        delegate?.onCancelAcceptedRideRequest()
    }
    
    @IBAction func btnArrowUpDownClickAction(_ sender: Any) {
        if btnSubmit.title(for: .normal) == "COMPLETE"{
           
//            UIView.animate(withDuration: 0.3, animations: { [unowned self] in
//                self.vwLine.isHidden = !self.vwLine.isHidden
//            })
        }else{
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.ViewTripCode.isHidden = !self.ViewTripCode.isHidden
        })
        self.txtfieldTripCode.endEditing(self.ViewTripCode.isHidden ? false : true)
    }
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        sender.text?.removeAll { !("0"..."9" ~= $0) }
        let text = sender.text ?? ""
        for index in text.indices.reversed() {
            if text.distance(from: text.endIndex, to: index).isMultiple(of: 1) &&
                index != text.startIndex &&
                index != text.endIndex {
                sender.text?.insert(" ", at: index)
                sender.text?.insert(" ", at: index)
            }
        }
        print(sender.text!)
    }
}

extension AcceptedRideDetailsView {
    
//    @objc func textFieldEdidtingDidChange(_ textField :UITextField) {
//        let attributedString = NSMutableAttributedString(string: textField.text ?? "")
//        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(31.0), range: NSRange(location: 0, length: attributedString.length))
//        textField.attributedText = attributedString
//    }
    
    func setupView() {
        
        ViewTripCode.isHidden = true
        txtfieldTripCode.tintColor = themeColor
//        txtfieldTripCode.defaultTextAttributes.updateValue(31.0, forKey: NSAttributedString.Key.kern)
        txtfieldTripCode.font = UIFont.regular(ofSize: FontsSize.Medium)
        txtfieldTripCode.textAlignment = .center
        txtfieldTripCode.textColor = themeColor
        txtfieldTripCode.delegate = self

        lblTime.font = UIFont.bold(ofSize: FontsSize.Regular)
        lblTime.text = ""
        
        lblExtraTime.font = UIFont.bold(ofSize: FontsSize.Regular)
        lblExtraTime.text = ""
        
        lblMessage.font =  UIFont.regular(ofSize: FontsSize.Small)
        lblMessage.text = ""
        
        lbDropLocation.font = UIFont.regular(ofSize: FontsSize.ExtraSmall)
        lbDropLocation.text = ""
        
        lblEnterTripCode.font = UIFont.bold(ofSize: FontsSize.Medium)
        lblEnterTripCode.text = ConstantString.LABEL_TITLE_HOME_ENTER_TRIP_CODE
        
        btnSubmit.setTitle(ConstantString.BUTTON_TITLE_HOME_ARRIVED, for: .normal)
    }
    internal override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event){
                return true
            }
        }
        return false
    }
}

extension AcceptedRideDetailsView : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 10
    }
}
