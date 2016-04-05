//
//  AppDAO.swift
//  Location
//
//  Created by Henrique do Prado Linhares on 19/11/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation

class AppDAO{
    
    static let sharedInstance = AppDAO()
    
    func databaseExists()->Bool{
        let ans = PListManager.sharedInstance.readPlist("Database", key: "databaseExists") as? Bool
        if (ans == true){
            return true
        }
        return false
    }
    
    func saveAppData(){
        var data : NSData = NSKeyedArchiver.archivedDataWithRootObject(AppData.sharedInstance.layers)
        PListManager.sharedInstance.writePlist("Database", key: "reads", data: data)
        data = NSKeyedArchiver.archivedDataWithRootObject(AppData.sharedInstance.getIsCurrentlyReading())
        PListManager.sharedInstance.writePlist("Database", key: "isCurrentlyReading", data: data)
    }

    func readAppData(){        
        var read = PListManager.sharedInstance.readPlist("Database", key: "reads")
        var data = read as! NSData
        AppData.sharedInstance.layers = (NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Layer])
        read = PListManager.sharedInstance.readPlist("Database", key: "isCurrentlyReading")
        data = read as! NSData
        AppData.sharedInstance.setIsCurrentlyReading(NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Bool) 
    }
    
}