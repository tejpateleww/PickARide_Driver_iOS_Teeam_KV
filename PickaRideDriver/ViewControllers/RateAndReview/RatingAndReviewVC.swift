//
//  RatingAndReviewVC.swift
//  PickaRideDriver
//
//  Created by Bhumi on 10/06/21.
//

import UIKit
import Cosmos

protocol HomeNavigationBarDelegate {
    func onClosePopup()
}

class RatingAndReviewVC: BaseVC {

    //MARK:- IBOutlets
    
    @IBOutlet weak var lblName: themeLabel!
    @IBOutlet weak var vwLine: UIView!
    @IBOutlet weak var vwCosmos: CosmosView!
    @IBOutlet weak var txtviewReview: ratingTextview!
    @IBOutlet weak var btnReviewYourOrder: themeButton!
    @IBOutlet weak var btnDone: loginScreenButton!
    
    //MARK:- Variables
    var delegate : HomeNavigationBarDelegate?
    var currentBookingModel : CurrentBookingDatum?
    var finalRatingValue: String = ""
    var newRatingValue: Double = 1.0
    var rateAndReviewViewModel = RateAndReviewViewModel()
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PrepareView()
    }
    
    //MARK:- Custom Methods
    func PrepareView(){
        vwLine.backgroundColor = hexStringToUIColor(hex: "#EBEDF0")
        txtviewReview.setBorderColor(bcolor: .lightGrey)
        txtviewReview.delegate = self
        
        self.vwCosmos.settings.fillMode = .half
        self.vwCosmos.settings.minTouchRating = 1.0
        self.vwCosmos.rating = newRatingValue
        
        self.vwCosmos.didFinishTouchingCosmos = { d in
            self.finalRatingValue = String(format: "%.2f", d)
            self.newRatingValue =  Double(self.finalRatingValue) ?? 0.0
            self.vwCosmos.rating = Double(self.finalRatingValue) ?? 0.0
        }
        
        self.setupData()
    }
    
    func setupData(){
        let custName = (self.currentBookingModel?.customerInfo?.firstName)! + " " + (self.currentBookingModel?.customerInfo?.lastName)!
        self.lblName.text = custName
    }
    
    func Validate() -> Bool{
        if(self.txtviewReview.text == "" || self.txtviewReview.text == "Write your review here..."){
            Toast.show(title: UrlConstant.Failed, message: "Please proview review...", state: .failure)
            return false
        }
        return true
    }
    
    func dismissView(){
        delegate?.onClosePopup()
        self.dismiss(animated: false, completion: nil)
    }
    
    //MARK:- IBACtions
    @IBAction func btnReviewYourOrderTap(_ sender: UIButton) {
        //if(self.Validate()){}
        self.callRateAndReviewAPI()
    }
    
    @IBAction func btnDoneTap(_ sender: Any) {
        self.dismissView()
    }
    
}

extension RatingAndReviewVC {
    
    func callRateAndReviewAPI(){
        self.rateAndReviewViewModel.ratingAndReviewVC = self
        
        let RateReq = RateAndReviewReqModel()
        RateReq.bookingId = self.currentBookingModel?.id ?? ""
        RateReq.rating = "\(self.newRatingValue)"
        RateReq.comment = (self.txtviewReview.text == "Write your review here...") ? "" : self.txtviewReview.text ?? ""
        
        self.rateAndReviewViewModel.webserviceRatingAndReviewAPI(reqModel: RateReq)
    }
}

extension RatingAndReviewVC : UITextViewDelegate{
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        vwLine.backgroundColor = hexStringToUIColor(hex: "#EBEDF0")
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        vwLine.backgroundColor = hexStringToUIColor(hex: "#EBEDF0")
    }
}
