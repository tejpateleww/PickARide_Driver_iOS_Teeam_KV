//
//  WebServicesSubclass.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 04/06/21.
//

import Foundation
class WebServiceSubClass{

    class func InitApi(keyPath : String , completion: @escaping (Bool,InitResponseModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: keyPath, responseModel: InitResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func GetCountryList(keyPath : String , completion: @escaping (Bool,CountryDataResponseModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: keyPath, responseModel: CountryDataResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func Logout(keyPath : String , completion: @escaping (Bool,LogoutReponseModel?,Any) -> ()){
        URLSessionRequestManager.makeGetRequest(urlString: keyPath, responseModel: LogoutReponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func RegisterToGetOTP(reqModel : RegisterOTPRequestModel , completion: @escaping (Bool,RegisterOTPResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.registerOTP.rawValue, requestModel: reqModel, responseModel: RegisterOTPResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func FinalRegistration(reqModel : RegisterFinalRequestModel , completion: @escaping (Bool,RegisterFinalResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.register.rawValue, requestModel: reqModel, responseModel: RegisterFinalResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func AddCard(reqModel : AddCardRequestModel , completion: @escaping (Bool,CardListResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.addCard.rawValue, requestModel: reqModel, responseModel: CardListResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func CardList(reqModel : CommonUserIdRequestModel , completion: @escaping (Bool,CardListResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.cardlist.rawValue, requestModel: reqModel, responseModel: CardListResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func addMonettoWallet(reqModel : AddMoneyRequestModel , completion: @escaping (Bool,AddMoneyResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.addMoney.rawValue, requestModel: reqModel, responseModel: AddMoneyResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func walletHistory(reqModel : WalletHistoryRequestModel , completion: @escaping (Bool,WalletHistoryListModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.walletHistory.rawValue, requestModel: reqModel, responseModel: WalletHistoryListModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
    class func WalletToMobileNum(reqModel : walletToMobileNumReqModel , completion: @escaping (Bool,AddMoneyResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.transferMoneyToMobileNum.rawValue, requestModel: reqModel, responseModel: AddMoneyResponseModel.self) { (status, response, error) in
            completion(status, response, error)
        }
    }
    
}
