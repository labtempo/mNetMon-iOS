//
//  UserDefaultData.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 11/09/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import Foundation

class UserDefaultData{

    private let defaults = NSUserDefaults.standardUserDefaults()
    
    func setString(param:String, key:String){
        defaults.setObject(param, forKey: key)
    }
    
    func getString(key:String)->String?{
        return defaults.stringForKey(key)
    }
    
}