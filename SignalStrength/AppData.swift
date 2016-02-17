//
//  AppData.swift
//  Location
//
//  Created by Henrique do Prado Linhares on 18/11/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation

/*
Singleton responsable for the management of the reads during the app execution
*/
class AppData{
    
    static let sharedInstance = AppData()
    private var reads:[Read]
    private var isCurrentlyReading:Bool
    
    init(){
        self.reads = [Read]()
        self.isCurrentlyReading = false
    }
    
    func getReads()->[Read]{
        return self.reads
    }
    
    func setReads(pReads:[Read]){
        self.reads = pReads
    }
    
    func getIsCurrentlyReading()->Bool{
        return self.isCurrentlyReading
    }
    
    func setIsCurrentlyReading(pBool:Bool){
        self.isCurrentlyReading = pBool
    }
    
    func changeIsCurrentlyReadingStatus(){
        self.isCurrentlyReading = !self.isCurrentlyReading
    }
    
    /*
    Function used to add another read to the reads.
    */
    func addRead(pRead:Read){
        AppData.sharedInstance.setReads(ReadManagementFunctions().addReadToReads(pRead, pReads: self.reads))
        AppDAO.sharedInstance.saveAppData()
    }
    
}