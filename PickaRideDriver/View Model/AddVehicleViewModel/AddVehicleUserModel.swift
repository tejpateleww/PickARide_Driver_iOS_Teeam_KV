//
//  AddVehicleUserModel.swift
//  PickaRideDriver
//
//  Created by Tej on 06/09/21.
//

import Foundation

class AddVehicleUserModel{
    
    weak var addVehicleVC : AddVehicleVC? = nil
    var registerRequestModel = RegisterFinalRequestModel()
    
    func webserviceGetManufacturerList(){
        Utilities.showHud()
        WebServiceSubClass.GetManufacturerList { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                self.addVehicleVC?.ManufacturerList = response
                self.addVehicleVC?.setupData()
            }else{
                Utilities.showAlertAction(AppName, message: apiMessage, vc: self.addVehicleVC!)
            }
        }
    }
}
