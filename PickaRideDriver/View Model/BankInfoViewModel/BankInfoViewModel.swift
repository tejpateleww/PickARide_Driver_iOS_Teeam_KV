//
//  SingleDocUploadViewModel.swift
//  PickaRideDriver
//
//  Created by Tej on 08/09/21.
//

import Foundation
import UIKit

class BankInfoViewModel{
    
    weak var bankDetailsVC : BankDetailsVC? = nil
    
    func webserviceUpdateBankInfoAPI(reqModel: UpdateBankInfoReqModel){
        self.bankDetailsVC?.btnNext.showLoading()
        WebServiceSubClass.UpdateBankInfoApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.bankDetailsVC?.btnNext.hideLoading()
            if status{
                Toast.show(title: UrlConstant.Success, message: apiMessage, state: .success)
                SingletonClass.sharedInstance.UserProfilData = response?.data
                user_defaults.setUserData()
                let _ = user_defaults.getUserData()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
}

class VehicleInfoViewModel{
    
    weak var addVehicleVC : AddVehicleVC? = nil
    
    func webserviceUpdateVehicleInfoAPI(reqModel: UpdateVehicleInfoReqModel){
        self.addVehicleVC?.btnNext.showLoading()
        WebServiceSubClass.UpdateVehicleInfoApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.addVehicleVC?.btnNext.hideLoading()
            if status{
                Toast.show(title: UrlConstant.Success, message: apiMessage, state: .success)
                SingletonClass.sharedInstance.UserProfilData = response?.data
                user_defaults.setUserData()
                let _ = user_defaults.getUserData()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
}
