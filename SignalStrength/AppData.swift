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
    
    private var readsLayers:ReadsLayers
    private var isCurrentlyReading:Bool
    
    init(){
        self.readsLayers = ReadsLayers()
        self.isCurrentlyReading = false
    }
    
    func getReadsLayers()->ReadsLayers{
        return self.readsLayers
    }
    
    func setReadsLayers(pReadsLayers:ReadsLayers){
        self.readsLayers = pReadsLayers
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
        let layers = ReadsManagement().addReadToReadsLayers(pRead, pReadsLayers: self.readsLayers)
        self.readsLayers = layers
        AppDAO.sharedInstance.saveAppData()
    }
    
}