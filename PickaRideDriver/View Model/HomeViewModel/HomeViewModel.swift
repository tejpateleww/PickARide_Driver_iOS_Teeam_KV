//
//  HomeViewModel.swift
//  PickaRideDriver
//
//  Created by Tej on 09/09/21.
//

import Foundation
import UIKit

class HomeViewModel{
    
    weak var homeVC : HomeVC? = nil
    
    func webserviceChangeDutyStatusAPI(reqModel: ChangeDutyStatusReqModel){
        Utilities.showHud()
        WebServiceSubClass.UpdateDutyStatusApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                self.homeVC?.strDutyStatusfromCurrentBooking = response?.duty ?? ""
                self.homeVC?.changeDutyStatusBasedOnCurrentBooking()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
    func webserviceGetCurrentBookingAPI(){
        WebServiceSubClass.GetCurrentBookingApi{ (status, apiMessage, response, error) in
            if status{
                self.homeVC?.strDutyStatusfromCurrentBooking = response?.data?.driverDuty ?? ""
                self.homeVC?.changeDutyStatusBasedOnCurrentBooking()
                if(response?.data != nil){
                    self.homeVC?.currentBookingModel = response?.data
                    self.homeVC?.checkForCurrentBooking()
                }
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
    func webserviceCompBookingAPI(reqModel: CompleteTripReqModel){
        self.homeVC?.acceptedRideDetailsView.btnSubmit.showLoading()
        WebServiceSubClass.CompleteTripApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.homeVC?.acceptedRideDetailsView.btnSubmit.hideLoading()
            if status{
                self.homeVC?.openReviewScreen()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
    func webserviceVerifyCustomerAPI(reqModel: VerifyCustomerReqModel){
        self.homeVC?.acceptedRideDetailsView.btnSubmit.showLoading()
        WebServiceSubClass.VerifyCustomerAPI(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.homeVC?.acceptedRideDetailsView.btnSubmit.hideLoading()
            if status{
                Toast.show(title: UrlConstant.Success, message: response?.otp ?? "", state: .success)
                self.homeVC?.strArrivedOtp = response?.otp ?? ""
                self.homeVC?.acceptedRideDetailsView.btnSubmit.setTitle("START RIDE", for: .normal)
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
    func webserviceCancelBookingAPI(reqModel: CancelBookingReqModel){
        //self.homeVC?.acceptedRideDetailsView.btnSubmit.showLoading()
        WebServiceSubClass.CancelBookingAPI(reqModel: reqModel) { (status, apiMessage, response, error) in
            //self.homeVC?.acceptedRideDetailsView.btnSubmit.hideLoading()
            if status{
                Toast.show(title: UrlConstant.Success, message: apiMessage, state: .success)
                self.homeVC?.callCurrentBookingAPI()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }

}
