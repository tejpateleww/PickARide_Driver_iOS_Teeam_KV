////
////  WalletModuleViewModel.swift
////  Danfo_Rider
////
////  Created by Hiral Jotaniya on 14/06/21.
////
//
//import Foundation
//
//class WalletUserModel {
//    
//    weak var walletVC : WalletVC?
//    weak var sendMoneyPopup : SendMoneyPopupVC?
//    
//    var arrWalletHistory = [WalletHistoryDetail]()
//    var isLoading = false
//    var pageIndex = 1
//    
//    func webServiceOfAddMoneyToWallet(reqModel : AddMoneyRequestModel){
//        Utility.showHUD()
//        WebServiceSubClass.addMonettoWallet(reqModel:reqModel ) { (status, response, error) in
//            Utility.hideHUD()
//            if let vc = self.walletVC{
//                if status{
//                    Toast.show(message: response?.message ?? ToastMessagesString.MoneyAddedtoWallet.rawValue, state: .success)
//                  
//                    self.webserviceOfWalletHistory(page: 1)
//                }else{
//                    Utility.showAlertOfAPIResponse(param: error, vc: vc)
//                }
//            }
//            
//        }
//    }
//    
//    func webserviceOfWalletHistory(page: Int){
//        let reqModel = WalletHistoryRequestModel(customerID: Singleton.shared.UserId, page: page)
//        isLoading = true
//        self.pageIndex += 1
//        Utility.showHUD()
//        WebServiceSubClass.walletHistory(reqModel: reqModel) { (status, response, error) in
//            Utility.hideHUD()
//            if let vc = self.walletVC{
//                if status{
//                    if let historyData = response?.data{
//                        if historyData.count != 0{
//                            self.arrWalletHistory = historyData
//                            self.isLoading = false
//                            vc.tblWalletHistory.reloadData()
//                            Singleton.shared.userProfileData?.walletBalance = response?.walletBalance ?? ""
//                            vc.lblWalletBal.text = Singleton.shared.userProfileData?.walletBalance
//                            user_defaults.setUserData()
//                        }else{ self.isLoading = true }
//                    }
//                }else{
//                    self.isLoading = true
//                    Utility.showAlertOfAPIResponse(param: error, vc: vc)
//                }
//            }
//        }
//    }
//    
//    func webserviceWalletToMobileNumber(){
//        let reqModel = walletToMobileNumReqModel(customerID: Singleton.shared.UserId, mobileNum: sendMoneyPopup?.txtPhoneNumber.text ?? "", amount:sendMoneyPopup?.txtAmount.text?.replacingOccurrences(of:currency, with: "") ?? "0.0" )
//        
//        Utility.showHUD()
//        WebServiceSubClass.WalletToMobileNum(reqModel: reqModel) { (status, response, error) in
//            Utility.hideHUD()
//            if let vc = self.sendMoneyPopup{
//                if status{
//                    Toast.show( message: response?.message ?? "", state: .success) {
//                        vc.dismiss(animated: true) {
//                            self.webserviceOfWalletHistory(page: 1)
//                        }
//                    }
//                }else{
//                    Toast.show(message: response?.message ?? "", state: .failure)
//                }
//            }
//           
//        }
//    }
//    
//}
//
//
//
