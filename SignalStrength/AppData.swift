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
        let searchResult = searchInReads(pRead)
        if (searchResult > -1){
            let firstRead = reads.removeAtIndex(searchResult)
            let alpha = 0.5
            let newSignalValue = ( Double(firstRead.signalStrength.signalValue) * (1 - alpha) ) + ( Double(pRead.signalStrength.signalValue) * alpha )
            let signalStrenght = SignalStrengthValue(pSignalValue: Int(newSignalValue))
            pRead.signalStrength = signalStrenght
        }
        reads.append(pRead)
        AppDAO.sharedInstance.saveAppData()
    }
    
    /*
    
    If the app have already made another read in the same location as the parameter pRead location, return the index of the read
    
    else return -1
    */
    private func searchInReads(pRead:Read)->Int{
        var index = 0
        for r:Read in self.reads{
            if ( (r.latitude == pRead.latitude) && (r.longitude == pRead.longitude) ){
                return index
            }
            index = index + 1
        }
        return -1
    }
    
}