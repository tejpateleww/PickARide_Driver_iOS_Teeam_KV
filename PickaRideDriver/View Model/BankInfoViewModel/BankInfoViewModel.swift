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
                SingletonClass.sharedInstance.UserProfilData = response?.data
                user_defaults.setUserData()
                let _ = user_defaults.getUserData()
                self.bankDetailsVC?.popBack()
                Toast.show(title: UrlConstant.Success, message: apiMessage, state: .success)
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
                SingletonClass.sharedInstance.UserProfilData = response?.data
                user_defaults.setUserData()
                let _ = user_defaults.getUserData()
                self.addVehicleVC?.popBack()
                Toast.show(title: UrlConstant.Success, message: apiMessage, state: .success)
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
}

class UserInfoViewModel{
    
    weak var editProfileVC : EditProfileVC? = nil

    func webserviceUserBasicInfoUpdateAPI(reqModel: UpdateBasicInfoReqModel, reqImage : UIImage){
        self.editProfileVC?.btnSave.showLoading()
        WebServiceSubClass.UpdateBasicInfoApi(reqModel: reqModel, imgKey: "profile_image", image: reqImage) { (status, apiMessage, response, error) in
            self.editProfileVC?.btnSave.hideLoading()
            if status{
                Toast.show(title: UrlConstant.Success, message: apiMessage, state: .success)
                SingletonClass.sharedInstance.UserProfilData = response?.data
                user_defaults.setUserData()
                let _ = user_defaults.getUserData()
                self.editProfileVC?.prepareView()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
    func webserviceSingleDocUpload(reqModel: UploadDocReqModel, reqImage : UIImage){
        
        WebServiceSubClass.UploadSingleDocsApi(reqModel: reqModel, imgKey: "image", image: reqImage) { (status, apiMessage, response, error) in
            if status{
                self.editProfileVC?.strImageURL = response?.url ?? ""
                self.editProfileVC?.setupUserImage()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
}
