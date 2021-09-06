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
    var registerRequestModel = RegisterFinalRequestModel()
    
    func webserviceSingleDocUpload(reqModel: UploadDocReqModel, reqImage : UIImage){
        Utilities.showHud()
        WebServiceSubClass.UploadSingleDocsApi(reqModel: reqModel, imgKey: "image", image: reqImage) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: status ? .success : .failure)
            if status{
                self.PersonalDocumentVC?.strImageURL = response?.url ?? ""
                self.PersonalDocumentVC?.UpdateData()
            }else{
                Utilities.showAlertAction(AppName, message: apiMessage, vc: self.PersonalDocumentVC!)
            }
        }
    }
}
