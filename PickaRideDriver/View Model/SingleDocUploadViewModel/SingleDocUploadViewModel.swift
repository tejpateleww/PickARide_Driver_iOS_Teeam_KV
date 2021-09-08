//
//  SingleDocUploadViewModel.swift
//  PickaRideDriver
//
//  Created by Tej on 06/09/21.
//

import Foundation
import UIKit

class SingleDocUploadModel{
    
    weak var PersonalDocumentVC : PersonalDocumentVC? = nil
    weak var vehicleDocumentVC : VehicleDocumentVC? = nil
    var registerRequestModel = RegisterFinalRequestModel()
    
    func webserviceSingleDocUpload(reqModel: UploadDocReqModel, reqImage : UIImage){
        
        WebServiceSubClass.UploadSingleDocsApi(reqModel: reqModel, imgKey: "image", image: reqImage) { (status, apiMessage, response, error) in
            if status{
                if(self.PersonalDocumentVC == nil){
                    self.vehicleDocumentVC?.strImageURL = response?.url ?? ""
                    self.vehicleDocumentVC?.UpdateData()
                }else{
                    self.PersonalDocumentVC?.strImageURL = response?.url ?? ""
                    self.PersonalDocumentVC?.UpdateData()
                }
            }else{
                Utilities.showAlertAction(AppName, message: apiMessage, vc: self.PersonalDocumentVC!)
            }
        }
    }
    
    func webserviceUpdatePersonalDocsAPI(reqModel: UpdatePersonalDocsReqModel){
        self.PersonalDocumentVC?.btnNext.showLoading()
        WebServiceSubClass.UpdatePersonalDocsApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.PersonalDocumentVC?.btnNext.hideLoading()
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
    
    func webserviceUpdateVehicleDocsAPI(reqModel: UpdateVehicleDocsReqModel){
        self.vehicleDocumentVC?.btnNext.showLoading()
        WebServiceSubClass.UpdateVehicleDocsApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.vehicleDocumentVC?.btnNext.hideLoading()
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
