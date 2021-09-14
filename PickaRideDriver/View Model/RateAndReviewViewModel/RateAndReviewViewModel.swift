//
//  RateAndReviewViewModel.swift
//  PickaRideDriver
//
//  Created by Tej on 14/09/21.
//

import Foundation
import UIKit

class RateAndReviewViewModel{
    
    weak var ratingAndReviewVC : RatingAndReviewVC? = nil
    
    func webserviceRatingAndReviewAPI(reqModel: RateAndReviewReqModel){
        self.ratingAndReviewVC?.btnReviewYourOrder.showLoading()
        WebServiceSubClass.RateAndReviewApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.ratingAndReviewVC?.btnReviewYourOrder.hideLoading()
            if status{
                Toast.show(title: UrlConstant.Success, message: apiMessage, state: .success)
                self.ratingAndReviewVC?.dismissView()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
}
