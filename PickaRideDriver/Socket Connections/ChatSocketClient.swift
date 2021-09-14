//
//  ChatSocketClient.swift
//  HC Pro Doctor
//
//  Created by Apple on 06/04/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
extension HomeVC{
    
    
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
            self.emitSocket_UserConnect()
            self.allSocketOnMethods()
        }
        
        //Connect User On Socket
        SocketIOManager.shared.establishConnection()
        
        print("==============\(SocketIOManager.shared.socket.status)=====================",SocketIOManager.shared.socket.status.active)
    
    }
    
    func onSocketConnectUser(){
        SocketIOManager.shared.socketCall(for: SocketKeys.ConnectUser.rawValue) { (json) in
            print(#function, "\n ", json)
        }
    }
    
    // ON ALL SOCKETS
    func allSocketOnMethods() {
        print("\n\n", #function, "\n\n")
        onSocketConnectUser()
        onSocket_ReceiveLocACK()
//        onSocket_ReceiveOTP()
        onSocket_ForwardBookingRequest()
        onSocket_StratTrip()
    }
    
    // OFF ALL SOCKETS
    func allSocketOffMethods() {
        print("\n\n", #function, "\n\n")
        SocketIOManager.shared.socket.off(SocketKeys.ConnectUser.rawValue)
        SocketIOManager.shared.socket.off(SocketKeys.updateDriverLocation.rawValue)
//        SocketIOManager.shared.socket.off(SocketKeys.verifyCustomer.rawValue)
        SocketIOManager.shared.socket.off(SocketKeys.forwardBookingRequest.rawValue)
        SocketIOManager.shared.socket.off(SocketKeys.startTrip.rawValue)
    }
    
    //-------------------------------------
    // MARK:= SOCKET ON METHODS =
    //-------------------------------------
    
    func ONSocket_connectToCommunicationchannel(){
        SocketIOManager.shared.socketCall(for: SocketKeys.channelCommunation.rawValue) { (json) in
            print(#function, "\n ", json)
            print(json)
            let dict = json[0]
            print(dict)
        }
    }
   
    func onSocket_ReceiveLocACK(){
        SocketIOManager.shared.socketCall(for: SocketKeys.updateDriverLocation.rawValue) { (json) in
            let dict = json[0]
            print(dict["message"])
        }
    }
    
    func onSocket_ForwardBookingRequest(){
        SocketIOManager.shared.socketCall(for: SocketKeys.forwardBookingRequest.rawValue) { (json) in
            print(#function, "\n ", json)
            print(json)
            let dict = NewBookingResModel.init(fromJson: json[0])
            self.newBookingResModel = dict.bookingInfo
            self.handleRideFlow(state: RideState.NewRequest)
        }
    }
    
//    func onSocket_ReceiveOTP(){
//        SocketIOManager.shared.socketCall(for: SocketKeys.verifyCustomer.rawValue) { (json) in
//            let dict = json[0]
//            let otp = dict["otp"]
//            print(otp)
//            Toast.show(title: UrlConstant.Success, message: otp.stringValue, state: .success)
//            self.strArrivedOtp = otp.stringValue
//        }
//    }
    
    func onSocket_StratTrip(){
        SocketIOManager.shared.socketCall(for: SocketKeys.startTrip.rawValue) { (json) in
            let dict = json[0]
            print(dict)
            self.callCurrentBookingAPI()
        }
    }
    
    //-------------------------------------
    // MARK:= SOCKET EMIT METHODS =
    //-------------------------------------
    
    //will emit every 10 sec
    func emitSocket_connectToCommunicationchannel(){
        let param: [String: Any] = ["user_id" : SingletonClass.sharedInstance.UserId]
        SocketIOManager.shared.socketEmit(for: SocketKeys.channelCommunation.rawValue, with: param)
    }
    
    // Socket Emit Connect user
    func emitSocket_UserConnect(){
        print(#function)
        let param: [String: Any] = ["user_id" : SingletonClass.sharedInstance.UserId]
        SocketIOManager.shared.socketEmit(for: SocketKeys.ConnectUser.rawValue, with: param)
    }
    
    //MARK:- ===== Socket Emit update location =======
    func emitSocket_UpdateLocation(latitute:Double,long:Double){
        let param = ["driver_id" : SingletonClass.sharedInstance.UserId ,"lat" : latitute ,"lng" : long] as [String : Any]
        print(param)
        SocketIOManager.shared.socketEmit(for: SocketKeys.updateDriverLocation.rawValue, with: param)
    }
    
    func emitSocket_forwardBookingRequestToAnotherDriver(bookingId : Int){
        let param = ["driver_id" : SingletonClass.sharedInstance.UserId ,"booking_id" : bookingId] as [String : Any]
        print(param)
        SocketIOManager.shared.socketEmit(for: SocketKeys.forwardBookingRequestToAnotherDriver.rawValue, with: param)
    }
    
//    func emitSocket_verifyCustomer(bookingId : String,customerId : String){
//        let param = ["driver_id" : SingletonClass.sharedInstance.UserId ,"booking_id" : bookingId,"customer_id" : customerId ] as [String : Any]
//        print(param)
//        SocketIOManager.shared.socketEmit(for: SocketKeys.verifyCustomer.rawValue, with: param)
//    }
    
//    func emitSocket_arrivedAtPickupLocation(bookingId : String,otp : String){
//        let param = ["booking_id" : bookingId,"otp" : otp ] as [String : Any]
//        print(param)
//        SocketIOManager.shared.socketEmit(for: SocketKeys.arrivedAtPickupLocation.rawValue, with: param)
//    }
    
    func emitSocket_startTrip(bookingId : String){
        let param = ["booking_id" : bookingId] as [String : Any]
        print(param)
        SocketIOManager.shared.socketEmit(for: SocketKeys.startTrip.rawValue, with: param)
    }

}
