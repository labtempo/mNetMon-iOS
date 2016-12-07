//
//  Synchronizer.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 06/11/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Synchronizer {
    
    static let sharedInstance = Synchronizer()
    
    var isSynchronizing = false
    
    func startSync(){
        
    }
    
    func findServer(serverAddress:String){
        
        let address = "http://"+serverAddress+"/handshake"
        
        
        Alamofire.request(.GET, address, parameters:["format":"json"]).responseJSON { response in
            
            if let data = response.result.value {
                let json = JSON(data)
                self.handleServerAck(json, serverAddress: serverAddress)
            }
        }

    }
    
    private func handleServerAck(json:JSON, serverAddress:String){
        if (json["table"]["response"] == "success"){
            let appServer = ApplicationServer()
            appServer.name = json["table"]["serverName"].stringValue
            appServer.ip = serverAddress
            let realm = RealmInterface.sharedInstance.getRealmInstance()
            try! realm.write{
                realm.add(appServer)
            }
        }
    }
    
}