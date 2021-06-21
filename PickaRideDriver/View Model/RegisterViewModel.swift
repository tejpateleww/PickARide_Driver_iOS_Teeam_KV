////
////  RegisterViewModel.swift
////  Danfo_Rider
////
////  Created by Hiral Jotaniya on 07/06/21.
////
//
//import Foundation
//class RegisterUserModel{
//    weak var registerVC : RegisterVC? = nil
//    var registerRequestModel : RegisterFinalRequestModel?
//    
//    func webserviceRegisterOTP(){
//        let makeReq = RegisterOTPRequestModel()
//        makeReq.email = registerVC?.txtEmail.text ?? ""
//        makeReq.mobile_no = registerVC?.txtMobileNumber.text ?? ""
//        
//        Utility.showHUD()
//        WebServiceSubClass.RegisterToGetOTP( reqModel: makeReq) { (status, response, error) in
//            Utility.hideHUD()
//            if status{
//                    let OTPVc : OTP_VC = OTP_VC.instantiate(fromAppStoryboard: .Login)
//                    OTPVc.comingFrom = .register
//                    OTPVc.strOTP = String(format: "%d", response?.otp ?? 0)
//                    OTPVc.registerRequestModel = self.registerRequestModel
//                    self.registerVC?.navigationController?.pushViewController(OTPVc, animated: true)
//            }else{
//                    if let registervc = self.registerVC{
//                        Utility.showAlertOfAPIResponse(param: error, vc: registervc)
//                    }
//                }
//        }
//    }
//}
//
//
//class RegisterOTPUserModel{
//    weak var registerOTPVC: OTP_VC? = nil
//    
//    func webserviceTORegister(){
//        if let reqModel = registerOTPVC?.registerRequestModel {
//            
//            Utility.showHUD()
//            WebServiceSubClass.FinalRegistration(reqModel: reqModel) { (status, response, error) in
//               
//                Utility.hideHUD()
//                if status{
//                   
//                        user_defaults.set(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
//                        Singleton.shared.userProfileData = response?.data
//                        if let apikey =  response?.data?.xAPIKey{
//                            Singleton.shared.Api_Key = apikey
//                            user_defaults.set(apikey , forKey: UserDefaultsKey.X_API_KEY.rawValue)
//                        }
//                        if let userID =  response?.data?.id{
//                            Singleton.shared.UserId = userID
//                        }
//                        user_defaults.setUserData()
//                        appDel.GoToHome()
//                   
//                }else{
//                  
//                        if let registervc = self.registerOTPVC{
//                            Utility.showAlertOfAPIResponse(param: error, vc: registervc)
//                        }
//                    }
//              
//            }
//        }
//        
//    }
//    
//}
