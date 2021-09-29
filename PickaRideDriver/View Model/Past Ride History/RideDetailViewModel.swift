//
//  RideDetailViewModel.swift
//  PickaRideDriver
//
//  Created by Tej on 29/09/21.
//

import Foundation
import UIKit

class RideDeatilViewModel{
    
    weak var rideDetailsVC : RideDetailsVC? = nil
    
    func webserviceAcceptBookingRideAPI(reqModel: RidesRequestModel){
        self.rideDetailsVC?.btnAccept.showLoading()
        WebServiceSubClass.AcceptBookLaterAPI(reqModel: reqModel) { (status, message, response, error) in
            self.rideDetailsVC?.btnAccept.hideLoading()
            if status{
                self.rideDetailsVC?.popBack()
                Toast.show(title: UrlConstant.Success, message: response?.message ?? "", state: .success)
            }else{
                Toast.show(title: UrlConstant.Failed, message: message, state: .failure)
            }
        }
    }
    
}
