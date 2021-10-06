//
//  ChatViewModel.swift
//  PickaRideDriver
//
//  Created by Tej on 05/10/21.
//

import Foundation
import UIKit

class ChatViewModel{
    
    weak var ChatCV : ChatViewController? = nil
    
    func webserviceGetChatHistoryAPI(strBookingID:String){

        WebServiceSubClass.GetChatHistoryApi(BookingID: strBookingID){ (status, apiMessage, response, error) in
            self.ChatCV?.tblChat.isHidden = false
            if status{
                self.ChatCV?.arrayChatHistory = response?.data ?? []
                self.ChatCV?.filterArrayData(isFromDidLoad: true)
                self.ChatCV?.tblChat.reloadData()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
}
