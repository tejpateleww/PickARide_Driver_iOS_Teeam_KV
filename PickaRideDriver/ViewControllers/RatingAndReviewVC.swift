//
//  RatingAndReviewVC.swift
//  PickaRideDriver
//
//  Created by Bhumi on 10/06/21.
//

import UIKit
import Cosmos

class RatingAndReviewVC: UIViewController, UITextViewDelegate {

    //MARK:- IBOutlets
    
    @IBOutlet weak var lblName: themeLabel!
    @IBOutlet weak var vwLine: UIView!
    @IBOutlet weak var vwCosmos: CosmosView!
    @IBOutlet weak var txtviewReview: ratingTextview!
    @IBOutlet weak var btnReviewYourOrder: themeButton!
    //MARK:- Variables
    var reviewBtnTapClosure : (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vwLine.backgroundColor = hexStringToUIColor(hex: "#EBEDF0")
        txtviewReview.setBorderColor(bcolor: .clearCol)
        txtviewReview.delegate = self
    }
    
    //MARK:- Custom Methods
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        vwLine.backgroundColor = themeColor
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        vwLine.backgroundColor = hexStringToUIColor(hex: "#EBEDF0")
    }
    
    //MARK:- IBACtions
    @IBAction func btnReviewYourOrderTap(_ sender: UIButton) {
        if let obj = reviewBtnTapClosure{
            obj()
        }
        self.dismiss(animated: false, completion: nil)
    }
    
    
}
