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
    
    let httpPrefix = "http://"
    private let readsRestRoute = "/reads"
    private let handshakeRestRoute = "/handshake"
    
    
    
    var isSynchronizing = false
    var serverAddress = ""
    
    
    func startSync(){
        let pendingReads = Layer.filter("id = 1").first!.reads.filter("isSyncPending = true")
        
        let address = self.httpPrefix + self.serverAddress + self.readsRestRoute
        
        for r:Read in pendingReads{
            print(self.serverAddress)
            
            Alamofire.request(.POST, address, parameters: r.toJson(), encoding:.JSON).responseJSON {
                    response in switch response.result
                    {
                    case .Success(let JSON):
                        print("Success with JSON: \(JSON)")
                        //converting json into NSDictionary
                        
                        let response = JSON as! NSDictionary
                        print(response)
                        
                        
                        
                    case .Failure(let error):
                        print("Request failed with error: \(error)")
                    }
            }
            
        }
        
    }
    

    
    func syncRead(read:Read, address:String, completionHandler: (Bool) -> ()){
        let completeAddress = self.httpPrefix + address + self.readsRestRoute
        Alamofire.request(.POST, completeAddress, parameters: read.toJson(), encoding:.JSON).responseJSON { response in
            let json = JSON(response.result.value!)
            if (json["table"]["response"] == "success"){
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }


    
}