//
//  CancelTripViewModel.swift
//  PickaRideDriver
//
//  Created by Tej on 15/09/21.
//

import Foundation
import UIKit

class CancelTripViewModel{
    
    weak var cancelRideVC : CancelRideVC? = nil
    
    func webserviceGetCancelTripReasonsAPI(){
        self.cancelRideVC?.btnDone.showLoading()
        WebServiceSubClass.GetCancelTripReasonsApi{ (status, apiMessage, response, error) in
            self.cancelRideVC?.btnDone.hideLoading()
            if status{
                self.cancelRideVC?.arrReason = response?.data ?? []
                self.cancelRideVC?.tblReasonForCancel.reloadData()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
}

