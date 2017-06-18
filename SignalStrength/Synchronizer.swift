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
import RealmSwift

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
                        print("network task done")
                    }
            }
        }
        
    }
    

    
    func syncRead(read:Read, address:String, completionHandler: (Bool) -> ()){
        let completeAddress = self.httpPrefix + address + self.readsRestRoute
        Alamofire.request(.POST, completeAddress, parameters: read.toJson(), encoding:.JSON).responseJSON { response in
            print("chegou no response")
            print(response)
            let json = JSON(response.result.value!)
            
            if (json["table"]["response"] == "success"){
                completionHandler(true)
            } else {
                completionHandler(false)
            }
            
            print("fechando requisicao")
           
        } 
    }

    
    func syncAllReads(reads:Results<Read>, address:String, completionHandler: (Bool) -> ()){
        let completeAddress = self.httpPrefix + address + self.readsRestRoute
        let params = ReadSerializer.readsToJson(reads)
        Alamofire.request(.POST, completeAddress, parameters: params, encoding:.JSON).responseJSON { response in
            switch response.result{
            case .Success:
                let json = JSON(response.result.value!)
                if (json["table"]["response"] == "success"){
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
                break
            case .Failure:
                completionHandler(false)
                break
            }
        }
    }
    

    
}
