//
//  LogoutUserModel.swift
//  PickaRideDriver
//
//  Created by Tej on 09/09/21.
//

import Foundation

import Foundation
import UIKit

class LogoutUserModel{
    
    weak var menuViewController : MenuViewController? = nil
   
    func webserviceForLogout(){
        WebServiceSubClass.Logout { (status, message, response, error) in
            if status{
                self.menuViewController?.DoLogoutFinal()
            }else{
                Toast.show(title: UrlConstant.Failed, message: message, state: .failure)
            }
        }
    }
}
