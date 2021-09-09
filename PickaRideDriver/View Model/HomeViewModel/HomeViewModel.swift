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
                self.homeVC?.strDutyStatus = response?.message ?? ""
                self.homeVC?.changeDutyStatus()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
    func webserviceGetCurrentBookingAPI(){
        WebServiceSubClass.GetCurrentBookingApi{ (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                self.homeVC?.strDutyStatusfromCurrentBooking = response?.data?.driverDuty ?? ""
                self.homeVC?.changeDutyStatusBasedOnCurrentBooking()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
}
