////
////  CardModuleViewModel.swift
////  Danfo_Rider
////
////  Created by Hiral Jotaniya on 10/06/21.
////
//
//import Foundation
//
//
//class AddCardUserViewModel {
//    weak var addcardVC : AddCardVC?
//    
//    func webserviceOfAddCard(){
//        if let reqModel = addcardVC?.addcardReqModel{
//            Utility.showHUD()
//            WebServiceSubClass.AddCard(reqModel:reqModel ){ (status, response, error) in
//                Utility.hideHUD()
//                if let vc = self.addcardVC {
//                    if status{
//                        vc.callbackCardAdded()
//                        vc.navigationController?.popViewController(animated: true)
//                    }else{
//                        Utility.showAlertOfAPIResponse(param: error, vc: vc)
//                    }
//                }
//            }
//        }
//    }
//}
//
//class CardListUserViewModel{
//    weak var cardListVC : PaymentCardListVC?
//    var responseStatus : webserviceResponse = .initial
//    var cardListReqModel = CommonUserIdRequestModel()
//    var arrCardList = [Card](){
//        didSet{
////            cardListVC?.tblCards.reloadData()
//        }
//    }
//    func webserviceOfCardList(){
//        cardListReqModel = CommonUserIdRequestModel(customerID: Singleton.shared.UserId)
//        if let vc = self.cardListVC {
////            vc.refresher.isRefreshing ? nil : Utility.showHUD()
//            WebServiceSubClass.CardList(reqModel:cardListReqModel ) { (status, response, error) in
////                Utility.hideHUD()
//                
//                self.responseStatus = .gotData
//                if status{
//                    if let cards = response?.cards{
//                        self.arrCardList = cards
//                        
//                        self.cardListVC?.tblCards.dataSource = self.cardListVC
//                        let indexPath = IndexPath.init(row: 0, section: 0)
//                        let cell = self.cardListVC?.tblCards.cellForRow(at: indexPath) as! ShimmerCell
//                        cell.stopShimmering()
//                        self.cardListVC?.tblCards.stopSkeletonAnimation()
//                        self.cardListVC?.tblCards.reloadData()
//                        
//                    }
//                }else{
//                    Utility.showAlertOfAPIResponse(param: error, vc: vc)
//                }
//                DispatchQueue.main.async {
//                    vc.refresher.endRefreshing()
//                }
//            }
//        }
//    }
//    
//    func webserviceOfRemoveCard(){
//        
//    }
//}
//
//class MakePaymentViewModel{
//    weak var makePaymentVC : MakePaymentVC?
//    var cardListReqModel = CommonUserIdRequestModel()
//    var arrCardList = [Card](){
//        didSet{
//            makePaymentVC?.tblCards.reloadData()
//        }
//    }
//    func webserviceOfCardList(){
//        cardListReqModel = CommonUserIdRequestModel(customerID: Singleton.shared.UserId)
//        if let vc = self.makePaymentVC {
//            vc.refresher.isRefreshing ? nil : Utility.showHUD()
//            WebServiceSubClass.CardList(reqModel:cardListReqModel ) { (status, response, error) in
//                Utility.hideHUD()
//                if status{
//                    if let cards = response?.cards{
//                        self.arrCardList = cards
//                    }
//                    
//                }else{
//                    Utility.showAlertOfAPIResponse(param: error, vc: vc)
//                }
//                DispatchQueue.main.async {
//                    vc.refresher.endRefreshing()
//                }
//            }
//        }
//    }
//}
