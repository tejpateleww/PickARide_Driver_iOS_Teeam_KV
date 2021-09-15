//
//  CancelReasonPopUpVC.swift
//  PickaRideDriver
//
//  Created by Tej on 15/09/21.
//

import UIKit

protocol CancelRideFromOtherViewDelgate {
    func onCancelRideFromOther(StrReason:String)
    func onCancelRideFromOtherCancel()
}

class CancelReasonPopUpVC: UIViewController {
    
    @IBOutlet weak var lblHeader: themeLabel!
    @IBOutlet weak var txtReason: ratingTextview!
    @IBOutlet weak var btnConfirm: themeButton!
    @IBOutlet weak var btnBack: CancelButton!
    
    var delegate : CancelRideFromOtherViewDelgate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func prepareView(){
        self.txtReason.delegate = self
    }
    
    func Validate() -> Bool{
        if(self.txtReason.text == ""){
            Toast.show(title: UrlConstant.Failed, message: "Please proview Reason...", state: .failure)
            return false
        }else{
            return true
        }
    }
    
    @IBAction func btnConfirmAction(_ sender: Any) {
        if(Validate()){
            self.delegate?.onCancelRideFromOther(StrReason: self.txtReason.text ?? "")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.delegate?.onCancelRideFromOtherCancel()
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CancelReasonPopUpVC : UITextViewDelegate{
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
    }
}

