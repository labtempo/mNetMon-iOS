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
    
    func findServer(serverAddress:String, completionHandler: (Bool, String?) -> ()){
        
        let address = "http://"+serverAddress+"/handshake"
    
        
        Alamofire.request(.GET, address, parameters:["format":"json"]).responseJSON { response in
            
            switch response.result{
            
            case .Success:
                completionHandler(true, self.getServerName(JSON(response.result.value!)))
                break
            case .Failure:
                completionHandler(false, nil)
                break
            }
            
        }
   
    }
    
    private func getServerName(json:JSON)->String{
        if (json["table"]["response"] == "success"){
            return json["table"]["serverName"].stringValue
        }
        return ""
    }
    
}