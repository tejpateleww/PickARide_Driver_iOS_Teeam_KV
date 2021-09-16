//
//  WebServicesSubclass.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 04/06/21.
//

import Foundation
import UIKit

class WebServiceSubClass{
    
    class func InitApi(completion: @escaping (Bool,String,InitResponseModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.Init.rawValue + kAPPVesion + SingletonClass.sharedInstance.UserId, responseModel: InitResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func GetCountryList(completion: @escaping (Bool,String,CountryListModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.getCountryList.rawValue, responseModel: CountryListModel.self) { (status, message, response, error) in
            if status{
                SingletonClass.sharedInstance.CountryList = response?.data ?? []
            }
            completion(status, message, response, error)
        }
    }
    
    class func GetManufacturerList(completion: @escaping (Bool,String,ManufacturerListModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.vehicleTypeManufacturerList.rawValue, responseModel: ManufacturerListModel.self){ (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func Login(reqModel : LoginReqModel , completion: @escaping (Bool,String,RegisterFinal?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.login.rawValue, requestModel: reqModel, responseModel: RegisterFinal.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func Logout(completion: @escaping (Bool,String,LogoutReponseModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.logout.rawValue + SingletonClass.sharedInstance.UserId, responseModel: LogoutReponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func OTPRequestApi(reqModel : OTPRequestModel , completion: @escaping (Bool,String,OTPResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.registerOTP.rawValue, requestModel: reqModel, responseModel: OTPResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func Register(reqModel : RegisterFinalRequestModel , completion: @escaping (Bool,String,RegisterFinal?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.register.rawValue, requestModel: reqModel, responseModel: RegisterFinal.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func ForgotPasswordApi(reqModel : ForgotPasswordReqModel , completion: @escaping (Bool,String,PasswordResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.forgotPassword.rawValue, requestModel: reqModel, responseModel: PasswordResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func ChangePasswordApi(reqModel : ChangePasswordReqModel , completion: @escaping (Bool,String,PasswordResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.changePassword.rawValue, requestModel: reqModel, responseModel: PasswordResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func UpdatePersonalDocsApi(reqModel : UpdatePersonalDocsReqModel , completion: @escaping (Bool,String,RegisterFinal?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.updatePersonalDocs.rawValue, requestModel: reqModel, responseModel: RegisterFinal.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func UpdateVehicleDocsApi(reqModel : UpdateVehicleDocsReqModel , completion: @escaping (Bool,String,RegisterFinal?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.updateVehicleDocs.rawValue, requestModel: reqModel, responseModel: RegisterFinal.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func UpdateBankInfoApi(reqModel : UpdateBankInfoReqModel , completion: @escaping (Bool,String,RegisterFinal?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.updateBankInfo.rawValue, requestModel: reqModel, responseModel: RegisterFinal.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func UpdateDutyStatusApi(reqModel : ChangeDutyStatusReqModel , completion: @escaping (Bool,String,ChangeDutyResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.changeDuty.rawValue, requestModel: reqModel, responseModel: ChangeDutyResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func CompleteTripApi(reqModel : CompleteTripReqModel , completion: @escaping (Bool,String,CurrentBookingDatum?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.completeTrip.rawValue, requestModel: reqModel, responseModel: CurrentBookingDatum.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func VerifyCustomerAPI(reqModel : VerifyCustomerReqModel , completion: @escaping (Bool,String,VerifyCustomerModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.verifyCustomer.rawValue, requestModel: reqModel, responseModel: VerifyCustomerModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func CancelBookingAPI(reqModel : CancelBookingReqModel , completion: @escaping (Bool,String,CancelBookingModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.cancelTrip.rawValue, requestModel: reqModel, responseModel: CancelBookingModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func UpdateVehicleInfoApi(reqModel : UpdateVehicleInfoReqModel , completion: @escaping (Bool,String,RegisterFinal?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.vehicleInfo.rawValue, requestModel: reqModel, responseModel: RegisterFinal.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func RateAndReviewApi(reqModel : RateAndReviewReqModel , completion: @escaping (Bool,String,RateAndReviewModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.reviewRating.rawValue, requestModel: reqModel, responseModel: RateAndReviewModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func UploadSingleDocsApi(reqModel : UploadDocReqModel , imgKey: String, image: UIImage, completion: @escaping (Bool,String,UploadSingleDocResponseModel?,Any) -> ()){
        URLSessionRequestManager.makeImageUploadRequest(urlString: ApiKey.uploadDocs.rawValue, requestModel: reqModel, responseModel: UploadSingleDocResponseModel.self, image: image, imageKey: imgKey) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func UpdateBasicInfoApi(reqModel : UpdateBasicInfoReqModel , imgKey: String, image: UIImage, completion: @escaping (Bool,String,RegisterFinal?,Any) -> ()){
        URLSessionRequestManager.makeImageUploadRequest(urlString: ApiKey.updateBasicInfo.rawValue, requestModel: reqModel, responseModel: RegisterFinal.self, image: image, imageKey: imgKey) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func GetCurrentBookingApi(completion: @escaping (Bool,String,CurrentBookingModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.currentBooking.rawValue + SingletonClass.sharedInstance.UserId, responseModel: CurrentBookingModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func GetCancelTripReasonsApi(completion: @escaping (Bool,String,cancelReasonModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.cancelReasonList.rawValue, responseModel: cancelReasonModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func GetRideHistoryApi(Page: String, completion: @escaping (Bool,String,PastBookingResModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.pastBookingHistory.rawValue + SingletonClass.sharedInstance.UserId + "/" + Page, responseModel: PastBookingResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func GetUpcomingRideApi(Page: String, completion: @escaping (Bool,String,PastBookingResModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.upcomingBookingHistory.rawValue + SingletonClass.sharedInstance.UserId + "/" + Page, responseModel: PastBookingResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //----------------//
    
    //    class func InitApi(keyPath : String , completion: @escaping (Bool,InitResponseModel?,Any) -> ()) {
    //        URLSessionRequestManager.makeGetRequest(urlString: keyPath, responseModel: InitResponseModel.self) { (status, response, error) in
    //            completion(status, response, error)
    //        }
    //    }
    //
    //    class func GetCountryList(keyPath : String , completion: @escaping (Bool,CountryDataResponseModel?,Any) -> ()){
    //        URLSessionRequestManager.makeGetRequest(urlString: keyPath, responseModel: CountryDataResponseModel.self) { (status, response, error) in
    //            completion(status, response, error)
    //        }
    //    }
    //
    //    class func Logout(keyPath : String , completion: @escaping (Bool,LogoutReponseModel?,Any) -> ()){
    //        URLSessionRequestManager.makeGetRequest(urlString: keyPath, responseModel: LogoutReponseModel.self) { (status, response, error) in
    //            completion(status, response, error)
    //        }
    //    }
    //
    //    class func RegisterToGetOTP(reqModel : RegisterOTPRequestModel , completion: @escaping (Bool,RegisterOTPResponseModel?,Any) -> ()){
    //        URLSessionRequestManager.makePostRequest(urlString: ApiKey.registerOTP.rawValue, requestModel: reqModel, responseModel: RegisterOTPResponseModel.self) { (status, response, error) in
    //            completion(status, response, error)
    //        }
    //    }
    //
    //    class func FinalRegistration(reqModel : RegisterFinalRequestModel , completion: @escaping (Bool,RegisterFinal?,Any) -> ()){
    //        URLSessionRequestManager.makePostRequest(urlString: ApiKey.register.rawValue, requestModel: reqModel, responseModel: RegisterFinal.self) { (status, response, error) in
    //            completion(status, response, error)
    //        }
    //    }
    //
    //    class func AddCard(reqModel : AddCardRequestModel , completion: @escaping (Bool,CardListResponseModel?,Any) -> ()){
    //        URLSessionRequestManager.makePostRequest(urlString: ApiKey.addCard.rawValue, requestModel: reqModel, responseModel: CardListResponseModel.self) { (status, response, error) in
    //            completion(status, response, error)
    //        }
    //    }
    //
    //    class func CardList(reqModel : CommonUserIdRequestModel , completion: @escaping (Bool,CardListResponseModel?,Any) -> ()){
    //        URLSessionRequestManager.makePostRequest(urlString: ApiKey.cardlist.rawValue, requestModel: reqModel, responseModel: CardListResponseModel.self) { (status, response, error) in
    //            completion(status, response, error)
    //        }
    //    }
    //
    //    class func addMonettoWallet(reqModel : AddMoneyRequestModel , completion: @escaping (Bool,AddMoneyResponseModel?,Any) -> ()){
    //        URLSessionRequestManager.makePostRequest(urlString: ApiKey.addMoney.rawValue, requestModel: reqModel, responseModel: AddMoneyResponseModel.self) { (status, response, error) in
    //            completion(status, response, error)
    //        }
    //    }
    //
    //    class func walletHistory(reqModel : WalletHistoryRequestModel , completion: @escaping (Bool,WalletHistoryListModel?,Any) -> ()){
    //        URLSessionRequestManager.makePostRequest(urlString: ApiKey.walletHistory.rawValue, requestModel: reqModel, responseModel: WalletHistoryListModel.self) { (status, response, error) in
    //            completion(status, response, error)
    //        }
    //    }
    //
    //    class func WalletToMobileNum(reqModel : walletToMobileNumReqModel , completion: @escaping (Bool,AddMoneyResponseModel?,Any) -> ()){
    //        URLSessionRequestManager.makePostRequest(urlString: ApiKey.transferMoneyToMobileNum.rawValue, requestModel: reqModel, responseModel: AddMoneyResponseModel.self) { (status, response, error) in
    //            completion(status, response, error)
    //        }
    //    }
    
}
