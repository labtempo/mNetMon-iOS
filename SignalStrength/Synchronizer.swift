//
//  Synchronizer.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 06/11/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import Alamofire

class Synchronizer {
    
    static let sharedInstance = Synchronizer()
    
    var isSynchronizing = false
    
    func startSync(){
        
    }
    
    func findServer(serverAddress:String){
        
        let address = "http://"+serverAddress+"/handshake"
        
        
        Alamofire.request(.GET, address, parameters:["format":"json"]).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }

    }
    
}