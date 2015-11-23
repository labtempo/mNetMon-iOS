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
        print("saving data")
        let data : NSData = NSKeyedArchiver.archivedDataWithRootObject(AppData.sharedInstance.reads)
        PListManager.sharedInstance.writePlist("Database", key: "reads", data: data)
    }

    
    func readAppData(){
        print("reading data")
        let read = PListManager.sharedInstance.readPlist("Database", key: "reads")
        let data = read as! NSData
        AppData.sharedInstance.reads = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Read]
    }


}