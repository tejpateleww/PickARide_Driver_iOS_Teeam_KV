//
//  RidesViewModel.swift
//  PickaRideDriver
//
//  Created by Tej on 16/09/21.
//

import Foundation
import UIKit

class RidesViewModel{
    
    weak var myRidesVC : MyRidesVC? = nil
    
    func webserviceGetRideHistoryAPI(Page : String){
        self.myRidesVC?.isApiProcessing = true
        WebServiceSubClass.GetRideHistoryApi(Page: Page) { (status, apiMessage, response, error) in
            self.myRidesVC?.isApiProcessing = false
            self.myRidesVC?.tblMyRides.isHidden = false
            if status{
                if(response?.data?.count == 0){
                    if(Page == "1"){
                        self.myRidesVC?.arrRides = response?.data ?? []
                        self.myRidesVC?.isStopPaging = true
                    }else{
                        print("End of Pagination...")
                        self.myRidesVC?.isStopPaging = true
                    }
                }else{
                    if(Page == "1"){
                        self.myRidesVC?.arrRides = response?.data ?? []
                    }else{
                        self.myRidesVC?.arrRides.append(contentsOf: response?.data ?? [])
                    }
                }
                self.myRidesVC?.tblMyRides.reloadData()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
    
    func webserviceGetUpcomingRideAPI(Page : String){
        self.myRidesVC?.isApiProcessing = true
        WebServiceSubClass.GetUpcomingRideApi(Page: Page) { (status, apiMessage, response, error) in
            self.myRidesVC?.isApiProcessing = false
            self.myRidesVC?.tblMyRides.isHidden = false
            if status{
                if(response?.data?.count == 0){
                    if(Page == "1"){
                        self.myRidesVC?.arrRides = response?.data ?? []
                        self.myRidesVC?.isStopPaging = true
                    }else{
                        print("End of Pagination...")
                        self.myRidesVC?.isStopPaging = true
                    }
                }else{
                    if(Page == "1"){
                        self.myRidesVC?.arrRides = response?.data ?? []
                    }else{
                        self.myRidesVC?.arrRides.append(contentsOf: response?.data ?? [])
                    }
                }
                self.myRidesVC?.tblMyRides.reloadData()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
    func webserviceInProcessBookingRideAPI(Page : String){
        self.myRidesVC?.isApiProcessing = true
        WebServiceSubClass.GetInProcessBookingRideApi(Page: Page) { (status, apiMessage, response, error) in
            self.myRidesVC?.isApiProcessing = false
            self.myRidesVC?.tblMyRides.isHidden = false
            if status{
                if(response?.data?.count == 0){
                    if(Page == "1"){
                        self.myRidesVC?.arrRides = response?.data ?? []
                        self.myRidesVC?.isStopPaging = true
                    }else{
                        print("End of Pagination...")
                        self.myRidesVC?.isStopPaging = true
                    }
                }else{
                    if(Page == "1"){
                        self.myRidesVC?.arrRides = response?.data ?? []
                    }else{
                        self.myRidesVC?.arrRides.append(contentsOf: response?.data ?? [])
                    }
                }
                self.myRidesVC?.tblMyRides.reloadData()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
    func webserviceAcceptBookingRideAPI(reqModel: RidesRequestModel){
        Utilities.showHud()
        WebServiceSubClass.AcceptBookLaterAPI(reqModel: reqModel) { (status, message, response, error) in
            Utilities.hideHud()
            if status{
                self.myRidesVC?.upcomingCurrentPage = 1
                self.myRidesVC?.callUpcomingRideAPI()
                Toast.show(title: UrlConstant.Success, message: response?.message ?? "", state: .success)
            }else{
                Toast.show(title: UrlConstant.Failed, message: message, state: .failure)
            }
        }
    }
    
}
