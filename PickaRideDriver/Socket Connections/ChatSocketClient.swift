//
//  ChatSocketClient.swift
//  HC Pro Doctor
//
//  Created by Apple on 06/04/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import SwiftyJSON

extension ChatViewController{
    
    //MARK:- Socket On All
    func ChatSocketOnMethods() {
        
        SocketIOManager.shared.socket.on(clientEvent: .disconnect) { (data, ack) in
            print ("socket is disconnected please reconnect")
            SocketIOManager.shared.isSocketOn = false
        }
        
        SocketIOManager.shared.socket.on(clientEvent: .reconnect) { (data, ack) in
            print ("socket is reconnected")
            SocketIOManager.shared.isSocketOn = true
        }
        
        print("===========\(SocketIOManager.shared.socket.status)========================",SocketIOManager.shared.socket.status.active)
        SocketIOManager.shared.socket.on(clientEvent: .connect) {data, ack in
            print ("socket connected")
            SocketIOManager.shared.isSocketOn = true
            self.ChatSocketOffMethods()
            self.emitSocket_UserConnect()
            self.allChatSocketOnMethods()
        }
        
        if(SocketIOManager.shared.socket.status == .connected){
            self.ChatSocketOffMethods()
            self.emitSocket_UserConnect()
            self.allChatSocketOnMethods()
        }
        
        SocketIOManager.shared.establishConnection()
        print("==============\(SocketIOManager.shared.socket.status)=====================",SocketIOManager.shared.socket.status.active)
    }
    
    //MARK:- Active Socket Methods
    func allChatSocketOnMethods() {
        onSocketConnectUser()
        onSocket_SendMessage()
        onSocket_ReceiveMessage()
    }
    
    //MARK:- Deactive Socket Methods
    func ChatSocketOffMethods() {
        SocketIOManager.shared.socket.off(SocketKeys.ConnectUser.rawValue)
        SocketIOManager.shared.socket.off(SocketKeys.SendMessage.rawValue)
        SocketIOManager.shared.socket.off(SocketKeys.ReceiverMessage.rawValue)
    }
    
    //MARK:- On Methods
    func onSocketConnectUser(){
        SocketIOManager.shared.socketCall(for: SocketKeys.ConnectUser.rawValue) { (json) in
            print(#function, "\n ", json)
        }
    }
    
    func onSocket_SendMessage(){
        SocketIOManager.shared.socketCall(for: SocketKeys.SendMessage.rawValue) { (json) in
            print(#function, "\n ", json)
            let dict = json[0]
//            print(dict)
            
            let chatObj : chatHistoryDatum = chatHistoryDatum()
            chatObj.id = dict["id"].stringValue
            chatObj.bookingId = dict["booking_id"].stringValue
            chatObj.message =  dict["message"].stringValue
            chatObj.receiverId =  dict["receiver_id"].stringValue
            chatObj.receiverType = dict["receiver_type"].stringValue
            chatObj.senderId =  dict["sender_id"].stringValue
            chatObj.senderType = dict["sender_type"].stringValue
            chatObj.createdAt = dict["created_at"].stringValue
            
            self.arrayChatHistory.append(chatObj)
            self.filterArrayData(isFromDidLoad: true)

            self.txtviewComment.text = ""
            self.txtviewComment.textColor = .black
        }
    }
    
    func onSocket_ReceiveMessage(){
        SocketIOManager.shared.socketCall(for: SocketKeys.ReceiverMessage.rawValue) { (json) in
            print(#function, "\n ", json)
            let dict = json[0]
            print(dict)
            
            let chatObj : chatHistoryDatum = chatHistoryDatum()
            chatObj.id = dict["id"].stringValue
            chatObj.bookingId = dict["booking_id"].stringValue
            chatObj.message =  dict["message"].stringValue
            chatObj.receiverId =  dict["receiver_id"].stringValue
            chatObj.receiverType = dict["receiver_type"].stringValue
            chatObj.senderId =  dict["sender_id"].stringValue
            chatObj.senderType = dict["sender_type"].stringValue
            chatObj.createdAt = dict["created_at"].stringValue
            
            self.arrayChatHistory.append(chatObj)
            self.filterArrayData(isFromDidLoad: true)
        }
    }
    
    //MARK:- Emit Methods
    func emitSocket_UserConnect(){
        print(#function)
        let param: [String: Any] = ["driver_id" : SingletonClass.sharedInstance.UserId]
        SocketIOManager.shared.socketEmit(for: SocketKeys.ConnectUser.rawValue, with: param)
    }
    
    func emitSocket_SendMessage(param: [String : Any]) {
        SocketIOManager.shared.socketEmit(for: SocketKeys.SendMessage.rawValue, with: param)
    }
    
    
}
