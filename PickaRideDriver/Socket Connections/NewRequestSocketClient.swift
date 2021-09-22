//
//  ChatSocketClient.swift
//  HC Pro Doctor
//
//  Created by Apple on 06/04/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
extension IncomingRideRequestView{
    
    
    // ----------------------------------------------------
    //MARK:- --- All Socket Methods ---
    //-----------------------------------------------------
    
    // Socket On All
    func SocketOnMethods() {
        
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
            self.allSocketOffMethods()
            self.allSocketOnMethods()
        }
        
        //Connect User On Socket
        SocketIOManager.shared.establishConnection()
        
        print("==============\(SocketIOManager.shared.socket.status)=====================",SocketIOManager.shared.socket.status.active)
    
        if(SocketIOManager.shared.socket.status.active){
            allSocketOnMethods()
        }
    }
    
    // ON ALL SOCKETS
    func allSocketOnMethods() {
        print("\n\n", #function, "\n\n")
        onSocket_AcceptBookingRequest()
    }
    
    // OFF ALL SOCKETS
    func allSocketOffMethods() {
        print("\n\n", #function, "\n\n")
        SocketIOManager.shared.socket.off(SocketKeys.forwardBookingRequest.rawValue)
        SocketIOManager.shared.socket.off(SocketKeys.acceptBookingRequest.rawValue)
    }
    
    //-------------------------------------
    // MARK:= SOCKET ON METHODS =
    //-------------------------------------
    
    func onSocket_AcceptBookingRequest(){
        SocketIOManager.shared.socketCall(for: SocketKeys.acceptBookingRequest.rawValue) { (json) in
            print(#function, "\n ", json)
            print(json)
            let dict = NewBookingResModel.init(fromJson: json[0])
            self.newBookingResModel = dict.bookingInfo
            self.callCurrentBookingAPI()
            
            self.btnAcceptRequest.showLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.btnAcceptRequest.hideLoading()
                self.delegate?.onAcceptRideRequest()
            }
           
        }
    }
    
    //-------------------------------------
    // MARK:= SOCKET EMIT METHODS =
    //-------------------------------------
    
    func emitSocket_forwardBookingRequestToAnotherDriver(bookingId : String){
        let param = ["driver_id" : SingletonClass.sharedInstance.UserId ,"booking_id" : bookingId] as [String : Any]
        print(param)
        SocketIOManager.shared.socketEmit(for: SocketKeys.forwardBookingRequestToAnotherDriver.rawValue, with: param)
    }
    
    func emitSocketAcceptBookingRequest(bookingId : Int, bookingType : String){
        let param = ["driver_id" : SingletonClass.sharedInstance.UserId ,"booking_id" : bookingId,"booking_type" : bookingType] as [String : Any]
        print(param)
        SocketIOManager.shared.socketEmit(for: SocketKeys.acceptBookingRequest.rawValue, with: param)
    }
}
