////
////  SideMenuViewModel.swift
////  Danfo_Rider
////
////  Created by Hiral Jotaniya on 10/06/21.
////
//
//import Foundation
//
//
//class SidemenuViewModel {
//    weak var sideMenuVC : Side_MenuVC?
//    
//    func webserviceOfLogout(){
//        Utility.showHUD()
//        let keyPath =  ApiKey.logout.rawValue + Singleton.shared.UserId
//        WebServiceSubClass.Logout(keyPath: keyPath) { (status, response, error) in
//            Utility.hideHUD()
//            if status{
//                user_defaults.set(false, forKey: UserDefaultsKey.isUserLogin.rawValue)
//                appDel.SetLogout()
//            }else{
//                if let sidemenuvc = self.sideMenuVC{
//                    Utility.showAlertOfAPIResponse(param: error, vc: sidemenuvc)
//                }
//            }
//        }
//    }
//}
