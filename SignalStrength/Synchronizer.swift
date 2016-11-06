//
//  Synchronizer.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 06/11/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import Foundation

class Synchronizer {
    
    static let sharedInstance = Synchronizer()
    
    var isSynchronizing = false
    
    func startSync(){
        
    }
    
    func findServer(serverAddress:String){
        
        let url:NSURL = NSURL(string: "http://httpbin.org/get")!
        let data:NSData? = NSData(contentsOfURL: url)
        if (data != nil) {
            let responseStr = NSString(data: data!, encoding:NSUTF8StringEncoding)! as String
            print(responseStr)

        }
        
    }
    
}